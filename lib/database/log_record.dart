import 'package:isar/isar.dart';

part 'log_record.g.dart';

@collection
class LogRecord {
  LogRecord(
      {required this.time,
      required this.level,
      this.message,
      this.error,
      this.stackTrace});

  Id id = Isar.autoIncrement;

  final DateTime time;

  @enumerated
  final LogLevel level;

  final String? message;

  final String? error;

  final String? stackTrace;
}

enum LogLevel { verbose, debug, info, warning, error, fatal }
