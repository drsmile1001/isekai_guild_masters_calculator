import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_env.dart';
import 'app_logger.dart';
import 'database/isar_provider.dart';
import 'database/log_record_repo.dart';
import 'pages/home.dart';
import 'utilities/dialogs.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    await initApp();
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      globalHandleError(details.exception, details.stack);
    };
    runApp(GetMaterialApp(
      title: "異世界公會長計算機",
      theme: ThemeData(
          textTheme: const TextTheme(
        caption: TextStyle(fontSize: 16),
        subtitle1: TextStyle(fontSize: 18),
        subtitle2: TextStyle(fontSize: 18),
        bodyText1: TextStyle(fontSize: 18),
        bodyText2: TextStyle(fontSize: 18),
        button: TextStyle(fontSize: 18),
      )),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ));
  }, (error, stack) {
    globalHandleError(error, stack);
  });
}

void globalHandleError(Object e, StackTrace? s) {
  final logger = Get.find<AppLogger>();
  logger.e("未處理的例外", e, s);
  if (e is FlutterError) return;
  errorSnackbar("程式運行發生未預期的錯誤", "請聯絡系統維護人員。\r\n$e");
}

Future<void> initApp() async {
  await Get.putAsync(() => AppEnv().init());
  await Get.putAsync(() => IsarProvider().init());
  Get.lazyPut(() => LogRecordRepo());
  Get.lazyPut(() => AppLogger());
  Get.lazyPut(() => HomeController());
}
