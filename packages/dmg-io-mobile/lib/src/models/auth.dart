import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

enum Status {
  Uninitialized,
  Authenticating,
  Authenticated,
  Unauthenticated,
  Unauthenticating,
  NewUser,
  NoAccount,
  NoCurrentGroup,
}

class Auth {
  final Status status;
  final Stream<User> authUser;
  final UserCredential userCredential;
  final AuthCredential authCredential;
  final GoogleAuthCredential googleAuth;
  final String userEmail;
  /* FirebaseAuth auth = FirebaseAuth.instance; */
  //FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  //Future<dynamic> dLink;

  Auth({
    this.status,
    this.userEmail,
    this.authUser,
    this.userCredential,
    this.authCredential,
    this.googleAuth,
  });

  Auth copyWith({
    Status status,
    Stream<User> authUser,
    UserCredential userCredential,
    AuthCredential authCredential,
    GoogleAuthCredential googleAuth,
    String userEmail,
  }) {
    return Auth(
      status: status ?? this.status,
      authUser: authUser ?? this.authUser,
      userCredential: userCredential ?? this.userCredential,
      authCredential: authCredential ?? this.authCredential,
      googleAuth: googleAuth ?? this.googleAuth,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status?.index.toString(),
      'token': userCredential?.credential?.token.toString(),
      'providerId': authCredential?.providerId,
      'signInMethod': authCredential?.signInMethod,
      'googleIdToken': googleAuth?.idToken,
      'googleAccessToken': googleAuth?.accessToken,
      'userEmail': userEmail,
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    final auth = Auth(
      status: Status.values[int.parse(map['status'])],
      userEmail: map['userEmail'],
      /* authCredential: AuthCredential(
        providerId: map['providerId'],
        signInMethod: map['signInMethod'],
        token: int.tryParse(map['token']),
      ),
      googleAuth: GoogleAuthProvider.credential(
        idToken: map['googleIdToken'],
        accessToken: map['googleAccessToken'],
      ), */
    );
    print("auth $auth");
    return auth;
  }

  String toJson() => json.encode(toMap());

  factory Auth.fromJson(String source) => Auth.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Auth(status: $status, authUser: $authUser, userCredential: $userCredential, authCredential: $authCredential, googleAuth: $googleAuth, userEmail: $userEmail)';
  }
}
