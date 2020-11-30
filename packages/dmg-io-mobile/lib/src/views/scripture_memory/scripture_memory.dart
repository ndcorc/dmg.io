import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';

class ScriptureMemory extends HookWidget {
  const ScriptureMemory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeDilation = 5.0;
    return Expanded(
      child: Hero(
        tag: 'scripture-memory',
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Scripture Memory",
                  textAlign: TextAlign.center,
                  style: useTheme().h2,
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: FlipCard(
                      direction: FlipDirection.HORIZONTAL, // default
                      front: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                        color: Colors.white38,
                        child: Text('Front'),
                      ),
                      back: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                        color: Colors.white38,
                        child: Text('Back'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
