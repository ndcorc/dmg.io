// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.uid,
    this.email,
    this.groups,
    this.currentGroup,
  });

  final String uid;
  final String email;
  final List<Membership> groups;
  final String currentGroup;

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        email: json["email"],
        groups: List<Membership>.from(
          json["groups"].map((x) => Membership.fromJson(x)),
        ),
        currentGroup: json["currentGroup"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
        "currentGroup": currentGroup,
      };

  User copyWith({
    final String uid,
    final String email,
    final List<Membership> groups,
    final String currentGroup,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      groups: groups ?? this.groups,
      currentGroup: currentGroup ?? this.currentGroup,
    );
  }
}

class Membership {
  Membership({
    this.displayName,
    this.preferences,
    this.avatar,
    this.active,
    this.timeZone,
    this.phoneNumber,
    this.directMessages,
    this.drafts,
    this.doNotDisturb,
    this.notifications,
    this.gid,
    this.bio,
    this.savedItems,
    this.fullName,
    this.channels,
    this.muted,
    this.groupName,
    this.threads,
    this.password,
    this.mentions,
    this.starred,
  });

  final String displayName;
  final Preferences preferences;
  final Avatar avatar;
  final bool active;
  final String timeZone;
  final String phoneNumber;
  final List<DirectMessage> directMessages;
  final List<dynamic> drafts;
  final bool doNotDisturb;
  final Notifications notifications;
  final String gid;
  final String bio;
  final List<dynamic> savedItems;
  final String fullName;
  final List<Channel> channels;
  final bool muted;
  final String groupName;
  final List<dynamic> threads;
  final String password;
  final List<dynamic> mentions;
  final bool starred;

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        displayName: json["displayName"],
        preferences: Preferences.fromJson(json["preferences"]),
        avatar: Avatar.fromJson(json["avatar"]),
        active: json["active"],
        timeZone: json["timeZone"],
        phoneNumber: json["phoneNumber"],
        directMessages: List<DirectMessage>.from(
          json["directMessages"].map((x) => DirectMessage.fromJson(x)),
        ),
        drafts: List<dynamic>.from(json["drafts"].map((x) => x)),
        doNotDisturb: json["doNotDisturb"],
        notifications: Notifications.fromJson(json["notifications"]),
        gid: json["gid"],
        bio: json["bio"],
        savedItems: List<dynamic>.from(json["savedItems"].map((x) => x)),
        fullName: json["fullName"],
        channels: List<Channel>.from(json["channels"].map((x) => Channel.fromJson(x))),
        muted: json["muted"],
        groupName: json["groupName"],
        threads: List<dynamic>.from(json["threads"].map((x) => x)),
        password: json["password"],
        mentions: List<dynamic>.from(json["mentions"].map((x) => x)),
        starred: json["starred"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "preferences": preferences.toJson(),
        "avatar": avatar.toJson(),
        "active": active,
        "timeZone": timeZone,
        "phoneNumber": phoneNumber,
        "directMessages": List<dynamic>.from(directMessages.map((x) => x.toJson())),
        "drafts": List<dynamic>.from(drafts.map((x) => x)),
        "doNotDisturb": doNotDisturb,
        "notifications": notifications.toJson(),
        "gid": gid,
        "bio": bio,
        "savedItems": List<dynamic>.from(savedItems.map((x) => x)),
        "fullName": fullName,
        "channels": List<dynamic>.from(channels.map((x) => x.toJson())),
        "muted": muted,
        "groupName": groupName,
        "threads": List<dynamic>.from(threads.map((x) => x)),
        "password": password,
        "mentions": List<dynamic>.from(mentions.map((x) => x)),
        "starred": starred,
      };

  Membership copyWith({
    String displayName,
    Preferences preferences,
    Avatar avatar,
    bool active,
    String timeZone,
    String phoneNumber,
    List<DirectMessage> directMessages,
    List<dynamic> drafts,
    bool doNotDisturb,
    Notifications notifications,
    String gid,
    String bio,
    List<dynamic> savedItems,
    String fullName,
    List<Channel> channels,
    bool muted,
    String groupName,
    List<dynamic> threads,
    String password,
    List<dynamic> mentions,
    bool starred,
  }) {
    return Membership(
      displayName: displayName ?? this.displayName,
      preferences: preferences ?? this.preferences,
      avatar: avatar ?? this.avatar,
      active: active ?? this.active,
      timeZone: timeZone ?? this.timeZone,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      directMessages: directMessages ?? this.directMessages,
      drafts: drafts ?? this.drafts,
      doNotDisturb: doNotDisturb ?? this.doNotDisturb,
      notifications: notifications ?? this.notifications,
      gid: gid ?? this.gid,
      bio: bio ?? this.bio,
      savedItems: savedItems ?? this.savedItems,
      fullName: fullName ?? this.fullName,
      channels: channels ?? this.channels,
      muted: muted ?? this.muted,
      groupName: groupName ?? this.groupName,
      threads: threads ?? this.threads,
      password: password ?? this.password,
      mentions: mentions ?? this.mentions,
      starred: starred ?? this.starred,
    );
  }
}

class Avatar {
  Avatar({
    this.secondaryColor,
    this.url,
    this.primaryColor,
  });

  final String secondaryColor;
  final String url;
  final String primaryColor;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        secondaryColor: json["secondaryColor"],
        url: json["url"],
        primaryColor: json["primaryColor"],
      );

  Map<String, dynamic> toJson() => {
        "secondaryColor": secondaryColor,
        "url": url,
        "primaryColor": primaryColor,
      };

  Avatar copyWith({
    String secondaryColor,
    String url,
    String primaryColor,
  }) {
    return Avatar(
      secondaryColor: secondaryColor ?? this.secondaryColor,
      url: url ?? this.url,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}

class Channel {
  Channel({
    this.channelId,
    this.pinned,
    this.lastRead,
    this.name,
  });

  final String channelId;
  final List<String> pinned;
  final String lastRead;
  final String name;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        channelId: json["channelId"],
        pinned: List<String>.from(json["pinned"].map((x) => x)),
        lastRead: json["lastRead"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "pinned": List<dynamic>.from(pinned.map((x) => x)),
        "lastRead": lastRead,
        "name": name,
      };

  Channel copyWith({
    String channelId,
    List<String> pinned,
    String lastRead,
    String name,
  }) {
    return Channel(
      channelId: channelId ?? this.channelId,
      pinned: pinned ?? this.pinned,
      lastRead: lastRead ?? this.lastRead,
      name: name ?? this.name,
    );
  }
}

class DirectMessage {
  DirectMessage({
    this.messages,
    this.recipient,
    this.lastRead,
    this.pinned,
  });

  final List<String> messages;
  final String recipient;
  final String lastRead;
  final List<String> pinned;

  factory DirectMessage.fromJson(Map<String, dynamic> json) => DirectMessage(
        messages: List<String>.from(json["messages"].map((x) => x)),
        recipient: json["recipient"],
        lastRead: json["lastRead"],
        pinned: List<String>.from(json["pinned"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x)),
        "recipient": recipient,
        "lastRead": lastRead,
        "pinned": List<dynamic>.from(pinned.map((x) => x)),
      };

  DirectMessage copyWith({
    List<String> messages,
    String recipient,
    String lastRead,
    List<String> pinned,
  }) {
    return DirectMessage(
      messages: messages ?? this.messages,
      recipient: recipient ?? this.recipient,
      lastRead: lastRead ?? this.lastRead,
      pinned: pinned ?? this.pinned,
    );
  }
}

class Notifications {
  Notifications({
    this.onMobile,
    this.sound,
    this.includePreview,
    this.schedule,
    this.threadNotify,
    this.inAppNotify,
    this.notifyWhen,
  });

  final String onMobile;
  final String sound;
  final bool includePreview;
  final Schedule schedule;
  final bool threadNotify;
  final bool inAppNotify;
  final String notifyWhen;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        onMobile: json["onMobile"],
        sound: json["sound"],
        includePreview: json["includePreview"],
        schedule: Schedule.fromJson(json["schedule"]),
        threadNotify: json["threadNotify"],
        inAppNotify: json["inAppNotify"],
        notifyWhen: json["notifyWhen"],
      );

  Map<String, dynamic> toJson() => {
        "onMobile": onMobile,
        "sound": sound,
        "includePreview": includePreview,
        "schedule": schedule.toJson(),
        "threadNotify": threadNotify,
        "inAppNotify": inAppNotify,
        "notifyWhen": notifyWhen,
      };

  Notifications copyWith({
    String onMobile,
    String sound,
    bool includePreview,
    Schedule schedule,
    bool threadNotify,
    bool inAppNotify,
    String notifyWhen,
  }) {
    return Notifications(
      onMobile: onMobile ?? this.onMobile,
      sound: sound ?? this.sound,
      includePreview: includePreview ?? this.includePreview,
      schedule: schedule ?? this.schedule,
      threadNotify: threadNotify ?? this.threadNotify,
      inAppNotify: inAppNotify ?? this.inAppNotify,
      notifyWhen: notifyWhen ?? this.notifyWhen,
    );
  }
}

class Schedule {
  Schedule({
    this.allowStart,
    this.allowDays,
    this.allowEnd,
  });

  final String allowStart;
  final String allowDays;
  final String allowEnd;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        allowStart: json["allowStart"],
        allowDays: json["allowDays"],
        allowEnd: json["allowEnd"],
      );

  Map<String, dynamic> toJson() => {
        "allowStart": allowStart,
        "allowDays": allowDays,
        "allowEnd": allowEnd,
      };

  Schedule copyWith({
    String allowStart,
    String allowDays,
    String allowEnd,
  }) {
    return Schedule(
      allowStart: allowStart ?? this.allowStart,
      allowDays: allowDays ?? this.allowDays,
      allowEnd: allowEnd ?? this.allowEnd,
    );
  }
}

class Preferences {
  Preferences({
    this.autosetTimeZone,
    this.optimizeImgUpload,
    this.collapseImages,
    this.markAsReadImmediately,
    this.displayFullName,
    this.language,
    this.displayTypingIndicator,
    this.use24Clock,
    this.webBrowser,
  });

  final bool autosetTimeZone;
  final bool optimizeImgUpload;
  final bool collapseImages;
  final bool markAsReadImmediately;
  final bool displayFullName;
  final String language;
  final bool displayTypingIndicator;
  final bool use24Clock;
  final String webBrowser;

  factory Preferences.fromJson(Map<String, dynamic> json) => Preferences(
        autosetTimeZone: json["autosetTimeZone"],
        optimizeImgUpload: json["optimizeImgUpload"],
        collapseImages: json["collapseImages"],
        markAsReadImmediately: json["markAsReadImmediately"],
        displayFullName: json["displayFullName"],
        language: json["language"],
        displayTypingIndicator: json["displayTypingIndicator"],
        use24Clock: json["use24clock"],
        webBrowser: json["webBrowser"],
      );

  Map<String, dynamic> toJson() => {
        "autosetTimeZone": autosetTimeZone,
        "optimizeImgUpload": optimizeImgUpload,
        "collapseImages": collapseImages,
        "markAsReadImmediately": markAsReadImmediately,
        "displayFullName": displayFullName,
        "language": language,
        "displayTypingIndicator": displayTypingIndicator,
        "use24clock": use24Clock,
        "webBrowser": webBrowser,
      };

  Preferences copyWith({
    bool autosetTimeZone,
    bool optimizeImgUpload,
    bool collapseImages,
    bool markAsReadImmediately,
    bool displayFullName,
    String language,
    bool displayTypingIndicator,
    bool use24Clock,
    String webBrowser,
  }) {
    return Preferences(
      autosetTimeZone: autosetTimeZone ?? this.autosetTimeZone,
      optimizeImgUpload: optimizeImgUpload ?? this.optimizeImgUpload,
      collapseImages: collapseImages ?? this.collapseImages,
      markAsReadImmediately: markAsReadImmediately ?? this.markAsReadImmediately,
      displayFullName: displayFullName ?? this.displayFullName,
      language: language ?? this.language,
      displayTypingIndicator: displayTypingIndicator ?? this.displayTypingIndicator,
      use24Clock: use24Clock ?? this.use24Clock,
      webBrowser: webBrowser ?? this.webBrowser,
    );
  }
}
