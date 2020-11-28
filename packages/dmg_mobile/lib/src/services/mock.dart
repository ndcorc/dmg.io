import 'dart:math';
import 'package:intl/intl.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:dmg_mobile/src/utils/functions/functions.dart';

List getChatHistory() {
  List<Map<String, dynamic>> chatHistory = [
    {
      "timestamp": DateTime.now().millisecondsSinceEpoch - 12345678,
      "sender": "evan",
      "message": "Hi everyone! My name is Evan and I'm glad to be hear! " + lipsum.createParagraph()
    },
    {
      "timestamp": DateTime.now().millisecondsSinceEpoch - 12345658,
      "sender": "nolan",
      "message": "Hi Evan! Thanks for the heads up! #weirdo " + lipsum.createSentence()
    },
    {
      "timestamp": DateTime.now().millisecondsSinceEpoch - 12345608,
      "sender": "nolan",
      "message": "lol just kidding, but for real though take it easy.."
    },
    {
      "timestamp": DateTime.now().millisecondsSinceEpoch - 12330078,
      "sender": "evan",
      "message": "I think were gunna be friends #nolan! " + lipsum.createParagraph()
    },
  ];
  chatHistory.map((msg) {
    var date = DateTime.fromMillisecondsSinceEpoch(msg["timestamp"]);
    msg["date"] = DateFormat.yMMMd().format(date);
    return msg;
  }).toList();
  return chatHistory;
}

Map<String, dynamic> getSenders(chatHistory) {
  Map<String, dynamic> senders = Map<String, dynamic>();
  chatHistory.forEach((msg) {
    if (!senders.containsKey(msg["sender"])) {
      Random random = Random();
      senders[msg["sender"]] = {"color": colorFor(msg["sender"]), "inverted": !random.nextBool()};
    }
  });
}

List getTreeData() => [
      {
        'name': 'Nolan',
        'children': [
          {
            'name': 'Jacob',
            'children': [
              {'name': 'C'},
              {'name': 'D'}
            ]
          },
          {
            'name': 'Luke',
            'children': [
              {'name': 'G'},
              {'name': 'H'},
              {'name': 'I'}
            ]
          },
        ]
      }
    ];

List<Map<String, dynamic>> getMockData() {
  return [
    {
      "userName": "Slackbot",
      "lastMessage": {"sender": "Slackbot", "message": "Hello", "time": "3:22 PM"},
      "userAvatar": "asdf",
      "isYou": false
    },
    {
      "userName": "nolan",
      "lastMessage": {"sender": "You", "message": "Hello", "time": "3:22 PM"},
      "userAvatar": "asdf",
      "isYou": true
    }
  ];
}

Map<String, List<String>> getChatData() {
  return {
    "unreads": ["unread1", "unread2", "unread3"],
    "channels": [
      "channel1",
      "channel2",
      "channel3",
      "channel4",
      "channel5",
      "channel6",
      "channel7",
      "channel8",
      "channel9"
    ]
  };
}
