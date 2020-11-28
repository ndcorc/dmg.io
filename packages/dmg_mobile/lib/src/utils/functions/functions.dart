import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
//import 'package:firebase_admin/firebase_admin.dart'

bool isToday(int timestamp) => true;

bool isYesterday(int timestamp) => true;

String getDate(int timestamp) =>
    DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(timestamp));

String getTime(int timestamp) {}

Color colorFor(String text) {
  var hash = 0;
  for (var i = 0; i < text.length; i++) {
    hash = text.codeUnitAt(i) + ((hash << 5) - hash);
  }
  final finalHash = hash.abs() % (256 * 256 * 256);
  final red = ((finalHash & 0xFF0000) >> 16);
  final blue = ((finalHash & 0xFF00) >> 8);
  final green = ((finalHash & 0xFF));
  final color = Color.fromRGBO(red, green, blue, 1);
  print(color.toString());
  return color;
}

Color lighten(Color color, [double amount = .4]) {
  assert(amount >= 0 && amount <= 1);
  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
  return hslLight.toColor();
}

/*
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
    String msgDate = getDate(msg["timestamp"]);
    msg["date"] = msgDate;
    return msg;
  }).toList();
  return chatHistory;
} */

/*
Future<String> generateLink(String _email, fa.App _adminApp) async {
  var link = await _adminApp.auth().generateSignInWithEmailLink(
        _email,
        fa.ActionCodeSettings(
          url: "https://dmg.page.link/yQ8a",
          dynamicLinkDomain: "dmg.page.link",
          iosBundleId: "io.dmg.dev",
          handleCodeInApp: true,
        ),
      );
  return link;
}
 */
/*
Email generateEmail(String link, String _email) {
  String body = '''
      <h1>Confirm your email address to get started on DMG.io</h1>
      <p>
          Once you’ve confirmed that <a href=$_email>$_email</a> is your email address, we’ll help you find your DMG teams or create a new one.</p><br><br>
      <p>
      <b>From your mobile device</b>, tap the button below to confirm:</p><br><br>
      <button onclick=$link
          style="background-color:#4CAF50;border:none;color:white;padding:15px 32px;text-align:center;text-decoration:none;display:inline-block;font-size:16px;margin:4px 2px;cursor:pointer;">
          Confirm Email Address
      </button><br><br>
      <p>If you didn’t request this email, there’s nothing to worry about — you can safely ignore it.</p>
    ''';
  Email email = Email(
    body: body,
    subject: "Confirm your email address on DMG.io",
    recipients: [_email],
    isHTML: true,
  );
  return email;
}
 */
