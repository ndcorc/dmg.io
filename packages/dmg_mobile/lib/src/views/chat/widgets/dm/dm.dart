import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:dmg_mobile/src/services/index.dart';
import 'widgets/index.dart';

class DM extends HookWidget {
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    print("args = ${args['channelId']}");
    List<Map<String, dynamic>> chatHistory = getChatHistory();
    Map<String, dynamic> senders = getSenders(chatHistory);

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height - 135,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Theme(
              data: ThemeData(
                textTheme: TextTheme(
                  headline1: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle1: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  ),
                  bodyText1: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height - 135,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: GroupedListView<dynamic, String>(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  elements: chatHistory,
                  groupBy: (msg) => msg['date'],
                  groupSeparatorBuilder: (String groupByValue) => Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.grey[50],
                        ),
                      ),
                    ),
                    child: Text(
                      groupByValue,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  itemBuilder: (context, dynamic msg) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserAvatar(sender: senders[msg["sender"]]),
                          UserMessage(msg: msg),
                        ],
                      ),
                    );
                    //Text(msg['name']);
                  },
                  order: GroupedListOrder.ASC,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
