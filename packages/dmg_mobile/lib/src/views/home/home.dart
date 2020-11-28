import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_mobile/src/widgets/index.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:dmg_mobile/src/widgets/modals/index.dart';
import 'package:dmg_mobile/src/views/index.dart';
import 'package:dmg_mobile/src/providers/index.dart';
import 'package:dmg_mobile/src/models/index.dart';
import 'package:dmg_mobile/src/utils/index.dart';
/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart'; */
//import '../controllers/home_controller.dart';

class Home extends HookWidget {
  Home({Key key}) : super(key: key);

  final navKey = GlobalKey<NavigatorState>(debugLabel: 'app');

  @override
  Widget build(BuildContext context) {
    final router = useProvider(routerProvider('app'));
    final routerState = useProvider(routerProvider('app').state);
    final drawer = useProvider(drawerProvider);
    final auth = useProvider(authProvider.state);

    final config = useProvider(configProvider);
    final nested = useState(config.nested.contains(routerState.pages.last.name));
    final theme = useTheme();
    IconData iconWidget = nested.value ? Icons.arrow_back_ios : Icons.menu;

    if (auth.status == Status.Authenticating || auth.status == Status.Unauthenticating)
      return Loading();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        TopBar(),
        Expanded(
          child: Navigator(
            key: navKey,
            pages: List.of(routerState.pages),
            onPopPage: useProvider(routerProvider('app')).onPopPage,
          ),
        )
      ],
    );
  }
}
