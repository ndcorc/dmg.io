import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';

class Home extends HookWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = useProvider(themeProvider.state);
    final themeCtrl = useProvider(themeProvider);
    final router = useProvider(routerProvider('app'));
    print(theme.mode);
    final themeData = useTheme();
    print("themeData = ${themeData.primaryColor}");
    /* final futureRootRouter = routerFamily('root').future;
    final rootRouter = useFuture(useProvider(futureRootRouter));
    final futureRouter = routerFamily('app').future;
    final router = useFuture(useProvider(futureRouter)); */
    /* print("router = $router");
    if (router.connectionState != ConnectionState.done) return Container(child: Text("")); */
    final auth = useProvider(authProvider);
    //final authState = useProvider(authProvider.state);
    return Container(
      color: themeData.primaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text('Choose Theme:'),
            SizedBox(height: 5),
            RaisedButton(
              onPressed: () => themeCtrl.setTheme("light"),
              child: Text("Light Mode"),
            ),
            RaisedButton(
              onPressed: () => themeCtrl.setTheme("dark"),
              child: Text("Dark Mode"),
            ),
            RaisedButton(
              onPressed: () => themeCtrl.setTheme("system"),
              child: Text("System Mode"),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (router.canPop)
                  RaisedButton(
                    onPressed: () => router.pop(),
                    child: Text("Go Back"),
                  ),
                SizedBox(width: 10),
                RaisedButton(
                  onPressed: () => router.push('dashboard'),
                  child: Text("To Dashboard"),
                ),
              ],
            ),
            RaisedButton(
              onPressed: () async {
                try {
                  if (await auth.signOut()) {
                    router.push('home');
                  } else {
                    router.push('intro');
                  }
                } on Exception catch (e) {
                  print(e);
                }
              }, //rootRouter.pop(),
              child: Text("Logout to Intro"),
            ),
          ],
        ),
      ),
    );
  }
}
