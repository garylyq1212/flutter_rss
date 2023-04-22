import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<Box> openBox(String boxName) async {
    return await Hive.openBox(boxName);
  }

  void registerAdapter<T>(TypeAdapter<T> adapter) {
    Hive.registerAdapter(adapter);
  }
}
