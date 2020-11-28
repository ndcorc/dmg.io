import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_mobile/src/providers/index.dart';

class SignInOptions extends HookWidget {
  const SignInOptions({Key key, this.scrollCtrl}) : super(key: key);

  final ScrollController scrollCtrl;

  @override
  Widget build(BuildContext context) {
    final router = useMemoized(() => context.read(routerProvider('root')));
    final authCtrl = useMemoized(() => context.read(authProvider));

    return Container(
      child: Material(
        color: Colors.grey[850],
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 10, top: 50),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          FlutterIcons.google_faw,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  print("Signing in with Google...");
                },
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 5, top: 0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Text(
                        'Continue with Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () async {
                  try {
                    bool success = await authCtrl.signIn();
                    print("success = $success");
                    router.pushReplacement('app');
                  } catch (e) {
                    print("Failure to Sign in with Email/Password: $e");
                  }
                },
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 20),
                child: Text(
                  "Know your worspace URL?",
                  style: TextStyle(color: Colors.grey[300]),
                ),
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 30, top: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Text(
                        'Sign In with URL',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () async {
                  router.pushReplacement('app');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
