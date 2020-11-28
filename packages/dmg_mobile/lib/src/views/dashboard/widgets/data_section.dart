import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_mobile/src/providers/index.dart';
import 'package:dmg_mobile/src/utils/index.dart';

class DataSection extends HookWidget {
  const DataSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final height = useHeight() * 0.9;
    final width = useWidth();
    final sectionHeight = height * 0.3;
    final config = useProvider(configProvider);

    return Container(
      height: sectionHeight,
      width: width,
      child: Expanded(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text("Weekly Content", style: theme.h2),
            ),
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Card(
                            margin: EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Text("${config.quickNumbers[0]}", style: theme.h1.withSize(24)),
                                Text(config.quickMetrics[0], style: theme.h1.withSize(24)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Card(
                            margin: EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Text("${config.quickNumbers[0]}", style: theme.h1.withSize(24)),
                                Text(config.quickMetrics[0], style: theme.h1.withSize(24)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Card(
                            margin: EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Text("${config.quickNumbers[0]}", style: theme.h1.withSize(24)),
                                Text(config.quickMetrics[0], style: theme.h1.withSize(24)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Card(
                            margin: EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Text("${config.quickNumbers[0]}", style: theme.h1.withSize(24)),
                                Text(config.quickMetrics[0], style: theme.h1.withSize(24)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
