import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_mobile/src/providers/index.dart';
import 'package:dmg_mobile/src/views/index.dart';
import 'src/providers/index.dart';
import 'src/models/index.dart';
import 'src/utils/index.dart';
import 'src/repositories/auth.dart';
import 'src/views/loading/loading.dart';

void main() async {
  Chain.capture(() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt('theme') ?? 0;
      final authStatus = enumFrom(Status.values, prefs.getString('auth')) ?? Status.Uninitialized;
      final status = authStatus == Status.Authenticated;

      runApp(
        ProviderScope(
          overrides: [
            authProvider.overrideWithProvider(
              StateNotifierProvider(
                (ref) => AuthCtrl(
                  firebaseAuth: ref.read(firebaseAuthProvider),
                  authRepo: ref.read(authRepoProvider),
                  rootRouter: ref.read(routerProvider('root')),
                  status: authStatus,
                ),
              ),
            ),
            routerProvider('root').overrideWithProvider(StateNotifierProvider((ref) {
              final defaultPage = ref.read(configProvider).getPages('root').first;
              return RouterCtrl(
                router: 'root',
                defaultPage: defaultPage,
                startPage: status ? defaultPage : ref.read(configProvider).getPage('intro'),
                ref: ref,
              );
            })),
            themeProvider.overrideWithValue(ThemeCtrl(mode: ThemeMode.values[themeIndex])),
          ],
          child: MyApp(),
        ),
      );
    } catch (e, st) {
      print(new Chain.forTrace(st));
    }
  });
}

class MyApp extends HookWidget {
  final navKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final pages = useProvider(routerProvider('root').state.select((v) => v.pages));
    print("(main) navKey = $navKey");
    final theme = useProvider(themeProvider.state);

    final auth = useProvider(authProvider.state);
    return (auth.status == Status.Authenticating || auth.status == Status.Unauthenticating)
        ? Loading()
        : MaterialApp(
            title: 'DMG.io',
            debugShowCheckedModeBanner: false,
            themeMode: theme.mode,
            theme: theme.light,
            darkTheme: theme.dark,
            home: Scaffold(
              body: Navigator(
                key: navKey,
                pages: List.of(pages),
                onPopPage: useProvider(routerProvider('root')).onPopPage,
              ),
            ),
          );
  }
}
/*
class Root extends HookWidget {
  const Root({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  }
} */

/* initialRoute: '/root/home',
      home: Root(),
      onGenerateRoute: buildAppRoutes(
        [
          new AppRouter(
            name: 'root',
            builder: (child) => Scaffold(body: child),
            subRoutes: [
              new AppRouter(
                name: 'intro',
                builder: (_) => Intro(),
              ),
              new AppRouter(
                name: 'home',
                builder: (_) => Home(title: "Hello Home"),
              )
            ],
          ),
        ],
      ), */
//home: MyHomePage(title: 'Flutter Demo Home Page'),
/* initialRoute: '/root/intro',
      home: Intro(),
      onGenerateRoute: buildRouters(
        [
          AppRouter(
            name: 'root',
            builder: (child) => Scaffold(body: child),
            subRoutes: [
              AppRouter(name: 'intro', builder: (_) => Intro()),
              AppRouter(name: 'home', builder: (_) => Home())
            ],
          )
        ],
      ), */
