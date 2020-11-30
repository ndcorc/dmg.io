import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchModal extends StatelessWidget {
  final ScrollController scrollController;

  const SearchModal({Key key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[850],
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 10, top: 15, bottom: 15, right: 0),
                    margin: EdgeInsets.only(right: 0),
                    child: Theme(
                      data: ThemeData(primaryColor: Colors.black),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          contentPadding: EdgeInsets.only(bottom: 10, top: 2),
                          prefixIcon:
                              Icon(Icons.search, size: 24, color: Colors.white),
                          filled: true,
                          hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                          hintText: "Search",
                          fillColor: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  margin: EdgeInsets.only(left: 0),
                  padding: EdgeInsets.only(right: 2.5),
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      )),
                )
              ],
            ),
            ListTile(
              title: Text('Edit', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.edit, color: Colors.white),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text('Copy', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.content_copy, color: Colors.white),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text('Cut', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.content_cut, color: Colors.white),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text('Move', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.folder_open, color: Colors.white),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text('Delete', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.delete, color: Colors.white),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
}
