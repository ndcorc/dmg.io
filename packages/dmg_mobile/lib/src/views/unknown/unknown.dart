import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_mobile/src/providers/index.dart';

class Unknown extends HookWidget {
  Unknown({Key key, String errMsg})
      : _errMsg = errMsg,
        super(key: key);
  final String _errMsg;

  @override
  Widget build(BuildContext context) {
    final router = useProvider(routerProvider('app'));
    return Container(
      child: Column(
        children: [
          Text(_errMsg ?? "Unknown Page"),
          RaisedButton(
            onPressed: () => router.pop(),
            child: Text("Go Back"),
          ),
        ],
      ),
    );
  }
}
