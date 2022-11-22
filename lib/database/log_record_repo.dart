import 'package:get/get.dart';
import 'package:isar/isar.dart';

import 'isar_provider.dart';
import 'log_record.dart';

class LogRecordRepo extends GetxService {
  final _isarProvider = Get.find<IsarProvider>();

  Future<void> addRecord(LogRecord record) async {
    await _isarProvider.isar.writeTxn(() async {
      await _isarProvider.isar.logRecords.put(record);
    });
  }

  Future<List<LogRecord>> findAll() {
    return _isarProvider.isar.logRecords.where().findAll();
  }
}
