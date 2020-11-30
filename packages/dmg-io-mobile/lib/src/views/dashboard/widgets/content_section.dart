import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';

class ContentSection extends HookWidget {
  const ContentSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = useProvider(routerProvider('app'));
    final theme = useTheme();
    final height = useHeight() * 0.9;
    final width = useWidth();
    final sectionHeight = height * 0.325;
    return Container(
      height: sectionHeight,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text("Weekly Content", style: theme.h2),
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  height: sectionHeight * 0.7,
                  width: width * 0.5,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                            child: Text(
                              "Reading",
                              textAlign: TextAlign.center,
                              style: theme.h2,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                            child: Text(
                              "Week 3: Demonstrating the Gospel",
                              textAlign: TextAlign.center,
                              style: theme.h3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  height: sectionHeight * 0.7,
                  width: width * 0.5,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'scripture-memory',
                          child: InkWell(
                            onTap: () => router.push('scripture_memory'),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Center(
                                child: Text(
                                  "Scripture Memory",
                                  textAlign: TextAlign.center,
                                  style: theme.h2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                            child: Text(
                              "Salt and Light // Matthew 5:16",
                              textAlign: TextAlign.center,
                              style: theme.h3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
