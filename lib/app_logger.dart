import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'database/log_record.dart';
import 'database/log_record_repo.dart';

class AppLogger extends GetxService {
  final _logger = Logger(filter: AppLogFilter(), printer: AppLogPrinter());

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.wtf(message, error, stackTrace);
  }
}

class AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

class AppLogPrinter extends PrettyPrinter {
  final _repo = Get.find<LogRecordRepo>();
  AppLogPrinter() : super(printTime: true, stackTraceBeginIndex: 2);

  @override
  List<String> log(LogEvent event) {
    try {
      final messageStr = stringifyMessage(event.message);
      String? stackTraceStr;
      if (event.stackTrace == null) {
        if (methodCount > 0) {
          stackTraceStr = formatStackTrace(StackTrace.current, methodCount);
        }
      } else if (errorMethodCount > 0) {
        stackTraceStr = formatStackTrace(event.stackTrace, errorMethodCount);
      }
      LogLevel level = LogLevel.values[event.level.index];

      final errorStr = event.error?.toString();

      final record = LogRecord(
          time: DateTime.now().toUtc(),
          level: level,
          message: messageStr,
          error: errorStr,
          stackTrace: stackTraceStr);
      _repo.addRecord(record);
    } catch (e) {
      print("無法寫入log到本地資料庫:$e");
    }
    return super.log(event);
  }
}
