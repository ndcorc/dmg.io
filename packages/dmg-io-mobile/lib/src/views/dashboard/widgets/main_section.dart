import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';

class MainSection extends HookWidget {
  const MainSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabIndex = useState(0);
    final drawerState = useProvider(drawerProvider.state);
    final theme = useTheme();
    final ctrl = usePageController(viewportFraction: 0.85, initialPage: 0);
    final tabCtrl = usePageController(viewportFraction: 0.3, initialPage: 0);
    final height = useHeight() * 0.9;
    final sectionHeight = height * 0.30;
    final config = useProvider(configProvider);

    setPage(int index) {
      print("\nindex = $index");
      //tabIndex.value = index;
      ctrl.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
      tabCtrl.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    }

    ScrollPhysics getPhysics() =>
        drawerState.swipeOffset < 1 ? ScrollPhysics() : NeverScrollableScrollPhysics();

    useEffect(() {
      bool isClosed = drawerState.swipeOffset < 1;
      ctrl.addListener(() => isClosed ? tabIndex.value = ctrl.page.round() : null);
      tabCtrl.addListener(() => isClosed ? tabIndex.value = ctrl.page.round() : null);
      return;
    }, []);

    return Container(
      height: sectionHeight,
      padding: EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            height: sectionHeight * 0.15,
            child: PageView.builder(
              controller: tabCtrl,
              physics: getPhysics(),
              onPageChanged: (int index) => setPage(index),
              itemCount: config.tabTitles.length,
              itemBuilder: (_, index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  style: (index == tabIndex.value)
                      ? theme.elevatedButtonTheme.style
                      : theme.elevatedButtonTheme.style.disabled(),
                  child: RichText(
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    text: TextSpan(text: index == 0 ? "Home" : config.tabTitles[index]),
                  ),
                  onPressed: () => (tabCtrl.hasClients) ? setPage(index) : null,
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: ctrl,
              physics: getPhysics(),
              onPageChanged: (int index) => setPage(index),
              itemCount: config.tabTitles.length,
              itemBuilder: (_, index) => Card(
                color: (index == tabIndex.value) ? Color(0xC9744718) : null,
                child: Container(
                  child: Center(
                    child: Text(
                      config.tabTitles[index],
                      textAlign: TextAlign.center,
                      style: theme.h1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
