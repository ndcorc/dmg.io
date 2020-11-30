import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/models/auth.dart';
import 'package:dmg_io_mobile/src/repositories/auth.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final authUserProvider = StreamProvider(
  (ref) => ref.watch(firebaseAuthProvider).authStateChanges(),
);

final authProvider = StateNotifierProvider<AuthCtrl>((ref) {
  return AuthCtrl(
    firebaseAuth: ref.read(firebaseAuthProvider),
    authRepo: ref.read(authRepoProvider),
    rootRouter: ref.read(routerProvider('root')),
  );
});

class AuthCtrl extends StateNotifier<Auth> {
  AuthCtrl({
    this.authRepo,
    this.firebaseAuth,
    this.rootRouter,
    Status status,
  }) : super(Auth(status: status ?? Status.Unauthenticated));

  final AuthRepo authRepo;
  final FirebaseAuth firebaseAuth;
  final RouterCtrl rootRouter;

  Future<bool> signIn({String email, String password}) async {
    print("signing in ...");

    state = state.copyWith(
      status: Status.Authenticating,
      userEmail: email,
    );

    try {
      final cred = await firebaseAuth.signInWithEmailAndPassword(
        email: email ?? "nd.corc@gmail.com",
        password: password ?? "Snickers2",
      );
      state = state.copyWith(
        status: Status.Authenticated,
        userEmail: email,
        userCredential: cred,
        authCredential: cred.credential,
      );
      authRepo.saveAuth(state);
      return true;
    } catch (e) {
      print("e ${e.toString()}");
      state = state.copyWith(status: Status.Unauthenticated);
      authRepo.saveAuth(state);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      state = state.copyWith(status: Status.Unauthenticating);
      await firebaseAuth.signOut();
      state = state.copyWith(status: Status.Unauthenticated);
      rootRouter.push('intro');
      authRepo.saveAuth(state);
      return true;
    } catch (e) {
      state = state.copyWith(status: Status.Authenticated);
      authRepo.saveAuth(state);
      return false;
    }
  }

  setAuthenticating() {
    state = state.copyWith(status: Status.Authenticating);
  }

  //Status get status => state.status;

}
