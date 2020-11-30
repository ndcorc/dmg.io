import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_io_mobile/src/models/index.dart' hide Channel;
import 'package:dmg_io_mobile/src/views/index.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';

final configProvider = Provider((ref) => Configuration());

class Configuration {
  final List<List<String>> dashboardSections = [
    [
      "Announcements",
      "Group Details",
    ],
    ["Study Content", "Scripture Memory"],
    ["Ministry Updates"],
    ["DMG Connections"]
  ];

  final tabTitles = [
    "Announcements",
    "Ministry",
    "Group Info",
  ];
  final quickNumbers = ["26", "11", "4", "6"];
  final quickMetrics = ["Gospel Shared", "New Believers", "Bible Studies", "Church Connections"];

  final p1 = [
    "Announcements",
    "Ministry Updates",
    "Group Details",
  ];
  final p2 = [
    ["Study Content", "Scripture Memory"],
    [
      ["26", "11", "4", "6"],
      ["Gospel Shared", "New Believers", "Bible Studies", "Church Connections"],
    ],
    "DMG Connections",
    "Geomovement of Gospel",
  ];

  final p3 = [
    "prayer requests",
    "celebrations",
    "testimonials",
  ];

  final actionItems = ["Study Content", "Scripture Memory"];

  List<Map> dashTabs = [
    {
      'icon': Icons.home,
      'title': 'Home',
      'iconSize': 23,
      'color': Color.fromRGBO(186, 121, 9, 0.25),
      'textColor': Color.fromRGBO(173, 118, 23, 1),
      'customTextStyle': TextStyle(color: Color.fromRGBO(173, 118, 23, 1)),
    },
    {
      'icon': Icons.mail,
      'title': 'Messages',
      'iconSize': 23,
      'color': Color.fromRGBO(186, 121, 9, 0.25),
      'textColor': Color.fromRGBO(173, 118, 23, 1),
      'customTextStyle': TextStyle(color: Color.fromRGBO(173, 118, 23, 1)),
    },
  ];

  List bottomBarItems = [
    {
      "icon": [Icon(FlutterIcons.home_outline_mco), Icons.home],
      "text": "Home",
      "route": 'chat',
    },
    {
      "icon": [Icons.question_answer, Icons.question_answer],
      "text": "DMs",
      "route": 'dms',
    },
    {
      "icon": [Icons.alternate_email, Icons.alternate_email],
      "text": "Mentions",
      "route": 'mentions',
    },
    {
      "icon": [Icons.account_circle, Icons.account_circle],
      "text": "You",
      "route": 'profile',
    },
  ];

  final List<String> _nestedRoutes = ['db', 'channel'];
  final Map<String, List<String>> _routers = {
    'root': ['app', 'intro'],
    'app': ['dashboard', 'unknown', 'chat'],
    'chat': ['channels', 'dms', 'mentions', 'profile', 'channel', 'profile'],
  };

  final List unguarded = ['app', 'intro', 'unknown'];

  final Map<String, Page> _routes = {
    "app": RoutePage(
      router: 'root',
      name: 'app',
      title: 'Home',
      path: '/',
      child: App(),
    ),
    "intro": RoutePage(
      router: 'root',
      name: 'intro',
      title: 'Intro',
      path: '/intro',
      child: Intro(),
    ),
    "dashboard": RoutePage(
      router: 'app',
      name: 'dashboard',
      title: 'Dashboard',
      path: '/dashboard',
      child: Dashboard(),
    ),
    "scripture_memory": RoutePage(
      router: 'app',
      name: 'scripture_memory',
      title: 'Scripture Memory',
      path: '/scripture_memory',
      child: ScriptureMemory(),
    ),
    "unknown": RoutePage(
      router: 'app',
      name: 'unknown',
      title: 'Unknown',
      path: '/unknown',
      child: Unknown(),
    ),
    "ministry": RoutePage(
      router: 'app',
      name: 'ministry',
      title: 'My Ministry',
      path: '/ministry',
      child: Ministry(),
    ),
    "prayer": RoutePage(
      router: 'app',
      name: 'prayer',
      title: 'Prayer',
      path: '/prayer',
      child: Prayer(),
    ),
    "chat": RoutePage(
      router: 'app',
      name: 'chat',
      title: 'Chat',
      path: '/chat',
      child: Chat(),
    ),
    "channels": RoutePage(
      router: 'chat',
      name: 'channels',
      title: 'Channels',
      path: '/chat',
      child: Channels(),
    ),
    "dms": RoutePage(
      router: 'chat',
      name: 'dms',
      title: 'Direct Messages',
      path: '/dms',
      child: DMs(),
    ),
    "mentions": RoutePage(
      router: 'chat',
      name: 'mentions',
      title: 'Mentions',
      path: '/mentions',
      child: Mentions(),
    ),
    "profile": RoutePage(
      router: 'chat',
      name: 'profile',
      title: 'Profile',
      path: '/profile',
      child: Profile(),
    ),
    "channel": RoutePage(
      router: 'chat',
      name: 'channel',
      title: 'Channel',
      path: '/channel',
      child: Channel(),
    ),
    "dm": RoutePage(
      router: 'chat',
      name: 'dm',
      title: 'Direct Message',
      path: '/dm',
      child: Unknown(),
    ),
  };

  List<String> get nested => _nestedRoutes;

  RoutePage getPage(String name) => _routes[name];

  List<String> getRoutes(String router) => _routers[router];

  QueueList<RoutePage> getPages(String router) => mapRoutes(getRoutes(router));

  QueueList<RoutePage> mapRoutes(List<String> routes) =>
      routes.mapTo((r) => getPage(r.value)).toQueue<RoutePage>();

  Map<String, RoutePage> get all => _routes;
}
