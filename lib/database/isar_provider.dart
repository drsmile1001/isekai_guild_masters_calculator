import 'package:get/get.dart';
import 'package:isar/isar.dart';

import 'log_record.dart';

class IsarProvider extends GetxService {
  late final Isar isar;

  Future<IsarProvider> init() async {
    isar = await Isar.open([LogRecordSchema]);
    return this;
  }

  @override
  void onClose() {
    isar.close();
    super.onClose();
  }
}
