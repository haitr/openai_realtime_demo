import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/storage.service.dart';

part 'storage.provider.g.dart';

@riverpod
Future<StorageService> storage(Ref ref) async {
  return StorageService.create();
}
