import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_mobile/src/models/user.dart' as Local;
import 'package:dmg_mobile/src/providers/index.dart';
import 'package:dmg_mobile/src/services/index.dart';

final groupProvider = StreamProvider((ref) {
  final firestore = ref.read(databaseProvider);
  final user = ref.watch(userProvider)?.data?.value;
  return firestore.streamGroup(user?.currentGroup);
  //return (user != null) ? firestore.streamGroup(user.currentGroup) : null;
});
