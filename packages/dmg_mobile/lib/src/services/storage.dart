import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final storageProvider = Provider((ref) => Storage.instance);

class Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Storage._();

  static final Storage instance = Storage._();

  Reference getRef(String path) => _storage.ref(path);

  Future<String> downloadUrl(String path) async => getRef(path).getDownloadURL();
}
