import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';
import 'package:dmg_io_mobile/src/models/index.dart';
import 'package:dmg_io_mobile/src/views/loading/loading.dart';
import 'widgets/index.dart';

class Intro extends HookWidget {
  Intro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newPage = useState(false);
    final intro = useProvider(introProvider);
    final slideCtrl = usePageController();
    final media = useMedia();
    /* final ctrls = intro.slides.mapTo((slide) => useAnimationController()); */
    final firstCtrl = useAnimationController();

    // ignore: missing_return
    useEffect(() {
      slideCtrl.addListener(() {
        int next = slideCtrl.page.round();
        if (intro.currentSlide.index != next) {
          newPage.value = true;
          intro.setIndicator(next);
          if (slideCtrl.page == slideCtrl.page.ceil()) {
            intro.setCurrentSlide(next);
          }
        }
      });
      intro.setFirstCtrl(firstCtrl);
    }, const []);

    final themeData = useTheme();
    final auth = useProvider(authProvider.state);
    if (auth.status == Status.Authenticating) return Loading();
    return Container(
      color: themeData.primaryColor,
      height: media.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: media.slideHeight,
            child: PageView.builder(
              controller: slideCtrl,
              itemCount: intro.slides.length,
              itemBuilder: (_, i) => IntroSlide(slide: intro.slides[i]),
            ),
          ),
          IntroActions()
        ],
      ),
    );
  }
}
