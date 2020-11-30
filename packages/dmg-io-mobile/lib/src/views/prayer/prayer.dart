import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';

class Prayer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final config = useProvider(configProvider);
    List sections = config.dashboardSections;

    return Scaffold(
      body: Stack(
        children: <Widget>[dashBg, content],
      ),
    );
  }

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            child: Container(color: Colors.deepPurple),
            flex: 2,
          ),
          Expanded(
            child: Container(color: Colors.transparent),
            flex: 5,
          ),
        ],
      );

  get content => Container(
        child: Column(
          children: <Widget>[
            header,
            grid,
          ],
        ),
      );

  get header => ListTile(
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          '10 items',
          style: TextStyle(color: Colors.blue),
        ),
        trailing: CircleAvatar(),
      );

  get grid => Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: GridView.count(
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            crossAxisCount: 2,
            childAspectRatio: .90,
            children: List.generate(8, (_) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[FlutterLogo(), Text('data')],
                  ),
                ),
              );
            }),
          ),
        ),
      );
  /*
       Container(
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        children: sections,
      ),
    ); */
}
