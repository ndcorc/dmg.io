// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';
import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

class Group {
  Group({
    this.leaders,
    this.gid,
    this.church,
    this.domain,
    this.img,
    this.name,
    this.admin,
    this.meetingSchedule,
    this.partners,
    this.members,
  });

  final List<Leader> leaders;
  final String gid;
  final String church;
  final String domain;
  final String img;
  final String name;
  final Admin admin;
  final MeetingSchedule meetingSchedule;
  final List<DocumentReference> partners;
  final List<DocumentReference> members;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        leaders: List<Leader>.from(json["leaders"].map((x) => Leader.fromJson(x))),
        gid: json["gid"],
        church: json["church"],
        domain: json["domain"],
        img: json["img"],
        name: json["name"],
        admin: Admin.fromJson(json["admin"]),
        meetingSchedule: MeetingSchedule.fromJson(json["meeting_schedule"]),
        partners: List<DocumentReference>.from(json["partners"]),
        members: List<DocumentReference>.from(json["members"]),
      );

  Map<String, dynamic> toJson() => {
        "leaders": List<dynamic>.from(leaders.map((x) => x.toJson())),
        "gid": gid,
        "church": church,
        "domain": domain,
        "img": img,
        "name": name,
        "admin": admin.toJson(),
        "meeting_schedule": meetingSchedule.toJson(),
        "partners": partners,
        "members": members,
      };

  Group copyWith({
    List<Leader> leaders,
    String gid,
    String church,
    String domain,
    String img,
    String name,
    Admin admin,
    MeetingSchedule meetingSchedule,
    List<String> partners,
    List<String> members,
  }) {
    return Group(
      leaders: leaders ?? this.leaders,
      gid: gid ?? this.gid,
      church: church ?? this.church,
      domain: domain ?? this.domain,
      img: img ?? this.img,
      name: name ?? this.name,
      admin: admin ?? this.admin,
      meetingSchedule: meetingSchedule ?? this.meetingSchedule,
      partners: partners ?? this.partners,
      members: members ?? this.members,
    );
  }
}

class Admin {
  Admin({
    this.userId,
    this.name,
  });

  final String userId;
  final String name;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        userId: json["userId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
      };

  Admin copyWith({
    String userId,
    String name,
  }) {
    return Admin(
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }
}

class Leader {
  Leader({
    this.userId,
    this.name,
  });

  final DocumentReference userId;
  final String name;

  factory Leader.fromJson(Map<String, dynamic> json) => Leader(
        userId: json["userId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
      };

  Leader copyWith({
    DocumentReference userId,
    String name,
  }) {
    return Leader(
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }
}

class MeetingSchedule {
  MeetingSchedule({
    this.day,
    this.location,
    this.time,
  });

  final String day;
  final String location;
  final String time;

  factory MeetingSchedule.fromJson(Map<String, dynamic> json) => MeetingSchedule(
        day: json["day"],
        location: json["location"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "location": location,
        "time": time,
      };

  MeetingSchedule copyWith({
    String day,
    String location,
    String time,
  }) {
    return MeetingSchedule(
      day: day ?? this.day,
      location: location ?? this.location,
      time: time ?? this.time,
    );
  }
}
