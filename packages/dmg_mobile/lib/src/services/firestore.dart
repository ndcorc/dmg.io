import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:dmg_mobile/src/models/index.dart';
/* import 'package:dmg_mobile/utils/getters.dart'; */

final databaseProvider = Provider((ref) => Database.instance);

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User _user;
  Group _group;

  Database._();

  static final Database instance = Database._();

  Stream<User> streamUser(String uid) => _db
      .collection("users")
      .doc(uid)
      .snapshots()
      .map((snap) => (snap != null) ? User.fromJson(snap.data()) : null);

  Stream<Group> streamGroup(String groupId) =>
      _db.collection("groups").doc(groupId).snapshots().map((snap) {
        print("snap = ${snap}");
        print("snap.data() = ${snap.data()}");
        if (snap == null || snap?.data() == null) return null;
        Map<String, dynamic> json = snap.data();
        //json['userId'] = _db.collection('users').doc(json['userId']);
        return (snap != null) ? Group.fromJson(json) : null;
      });

  Stream<DocumentSnapshot> streamDoc(model, docId) => _db
      .collection("${model.runtimeType.toString().toLowerCase()}s")
      .doc(docId)
      .snapshots()
      .map((json) => model.fromJson(json));

  Stream<List<Group>> get streamGroupList => _db
      .collection('groups')
      .snapshots()
      .map((groups) => (groups == null) ? null : groups.docs.map((g) => Group.fromJson(g.data())));

  Future<Group> getGroup(String groupId) async {
    var snap = await _db.collection('groups').doc(groupId).get();
    return Group.fromJson(snap.data());
  }

  Future<bool> userExists(String uid) async {
    var snap = await db.collection('users').doc(uid).get();
    return snap.exists;
  }

  Future<User> createUser(fa.User authUser) async {
    DocumentSnapshot userDoc;
    QuerySnapshot userQuery;
    String email = authUser.email;
    String uid = authUser.uid;
    Map<String, dynamic> newUser = {"email": email, "uid": uid, "groups": [], "currentGroup": null};
    try {
      userQuery = await _db.collection("users").where('email', isEqualTo: email).get();
      if (userQuery.size > 0) {
        userDoc = userQuery.docs[0];
        print("(userQuery > 0) userDoc.data() = ${userDoc.data()}");
      } else {
        await _db.collection("users").doc(uid).set(newUser);
        userDoc = await _db.collection("users").doc(uid).get();
        print("(set) userDoc.data() = ${userDoc.data()}");
      }
      _user = User.fromJson(userDoc.data());
      return _user;
    } catch (e) {
      print("error creating user: $e");
      return null;
    }
  }

  Future<void> changeGroup(User user, String groupId) async {
    _db.collection("users").doc(user.uid).update({"currentGroup": groupId});
  }

  Future<bool> createGroup(String name, String focus, String admin) async {
    String gid = Uuid().v1().replaceAll("-", "");
    String domain = name.replaceAll(" ", "-").toLowerCase();
    Map group = {
      "admin": admin,
      "name": name,
      "domain": domain,
      "focus": focus,
      "gid": gid,
      "img": "",
      "leaders": [admin],
      "members": [admin],
    };
    try {
      await _db.collection("groups").doc(gid).set(group);
      return true;
    } catch (e) {
      print("error creating group: $e");
      return false;
    }
  }

  Future<void> addGroup(Map user, Map newGroup) async {
    try {
      var ref = await _db.collection("groups").add(newGroup);
      var group = await ref.get();
      var joinedGroups = user["joinedGroups"].add(group.data());
      return _db.collection("users").doc(user["uid"]).update({"joinedGroups": joinedGroups});
    } catch (err) {
      print("error = $err");
    }
  }

  Future<bool> signInToGroups(Map user, List active) async {
    try {
      var snap = await _db.collection("users").doc(user['uid']).get();
      List groups = snap.data()['groups'].map((g) {
        if (active.contains(g['gid'])) {
          g['active'] = true;
          if (active[0] == g['gid']) {
            g['currentGroup'] = g['gid'];
          }
        } else {
          g['active'] = false;
        }
        return g;
      }).toList();
      _db.collection("users").doc(user["uid"]).update({"groups": groups});
      return true;
    } catch (err) {
      print("error = $err");
      return false;
    }
  }

  List<Map> getGenerations() {
    return [
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
  }

  Map getPeers() {
    return {
      'data': [
        {'name': 'Texas', 'x': 100, 'y': 300},
        {'name': 'China', 'x': 800, 'y': 300},
        {'name': 'Japan', 'x': 550, 'y': 100},
        {'name': 'India', 'x': 550, 'y': 500}
      ],
      'links': [
        {'source': 'Texas', 'target': 'China'},
        {'source': 'Texas', 'target': 'Japan'},
        {'source': 'Japan', 'target': 'China'},
        {'source': 'China', 'target': 'India'},
        {'source': 'Texas', 'target': 'India'}
      ]
    };
  }

  FirebaseFirestore get db => _db;
  User get user => _user;
  Group get group => _group;
  //JoinedModel get joined => _joined;
}

class SignupInfo {
  final String fullName;
  final String displayName;
  final String password;
  final bool subscribe;

  const SignupInfo({this.fullName, this.displayName, this.password, this.subscribe});

  Map toJson() {
    return {
      "fullName": this.fullName,
      "displayName": this.displayName,
      "password": this.password,
      "subscribe": this.subscribe.toString()
    };
  }
}
