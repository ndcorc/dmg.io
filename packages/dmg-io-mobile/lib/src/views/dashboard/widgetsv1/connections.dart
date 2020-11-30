import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:expandable/expandable.dart';

class Connections extends StatefulWidget {
  const Connections({Key key}) : super(key: key);

  @override
  _ConnectionsState createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> {
  final Graph graph = Graph();
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  Widget getNodeText(String title) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
        constraints: BoxConstraints(minWidth: 62.5, minHeight: 40),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey[900].withRed(100),
          border: Border.all(width: 2, color: Colors.grey[500]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        )),
      ),
    );
  }

  @override
  // ignore: must_call_super
  void initState() {
    final Node root = Node(getNodeText("Nolan"));
    final Node node1 = Node(getNodeText("Jacob"));
    final Node node2 = Node(getNodeText("Luke"));
    final Node node3 = Node(getNodeText("Sam"));
    final Node node4 = Node(getNodeText("Bob"));
    final Node node5 = Node(getNodeText("Tim"));
    final Node node6 = Node(getNodeText("John"));
    graph.addEdge(root, node1);
    graph.addEdge(root, node2);
    graph.addEdge(node1, node3);
    graph.addEdge(node1, node4);
    graph.addEdge(node2, node5);
    graph.addEdge(node2, node6);
    builder
      ..siblingSeparation = (5)
      ..levelSeparation = (50)
      ..subtreeSeparation = (50)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  Widget getGraph(Paint paint) => Container(
        margin: EdgeInsets.all(0),
        alignment: Alignment.topLeft,
        width: 370,
        height: 255,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: InteractiveViewer(
                constrained: false,
                scaleEnabled: false,
                panEnabled: false,
                child: Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[50].withOpacity(0.2),
                    ),
                  ),
                  margin: EdgeInsets.only(left: 5, right: 0, top: 7.5, bottom: 10),
                  padding: EdgeInsets.only(
                    left: 0,
                    top: 0,
                    bottom: 20,
                    right: 20,
                  ),
                  child: GraphView(
                    graph: graph,
                    paint: paint,
                    algorithm: BuchheimWalkerAlgorithm(
                      builder,
                      TreeEdgeRenderer(builder),
                    ),
                  ),
                ),
              ),
            ),
            //Flexible(child: Container()),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    Paint paint = Paint();
    paint.color = Colors.white;
    paint.strokeWidth = 5;
    paint.style = PaintingStyle.stroke;
    return ExpandablePanel(
      theme: ExpandableThemeData(
        hasIcon: false,
      ),
      header: Container(
        margin: EdgeInsets.only(bottom: 5, top: 0),
        child: Row(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 5, left: 15),
                child: Text(
                  "DMG Connections",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    /*  */ fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: ExpandableIcon(
                  theme: const ExpandableThemeData(
                    expandIcon: Icons.arrow_right,
                    collapseIcon: Icons.arrow_drop_down,
                    iconColor: Colors.grey,
                    iconSize: 36.0,
                    iconPadding: EdgeInsets.only(top: 10, right: 15),
                    hasIcon: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      collapsed: Container(
        margin: EdgeInsets.only(bottom: 15, left: 15),
        child: Text(
          "Expand to view connections ...",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
        ),
      ),
      expanded: getGraph(paint),
    );
  }
}
