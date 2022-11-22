import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

import 'errors.dart';
import 'parser.dart';

class DotEnv {
  bool _isInitialized = false;
  final Map<String, String> _envMap = {};

  /// A copy of variables loaded at runtime from a file + any entries from mergeWith when loaded.
  Map<String, String> get env {
    if (!_isInitialized) {
      throw NotInitializedError();
    }
    return _envMap;
  }

  bool get isInitialized => _isInitialized;

  /// Clear [env]
  void clean() => _envMap.clear();

  String get(String name, {String? fallback}) {
    final value = maybeGet(name, fallback: fallback);
    assert(
        value != null, 'A non-null fallback is required for missing entries');
    return value!;
  }

  String? maybeGet(String name, {String? fallback}) => env[name] ?? fallback;

  /// Loads environment variables from the env file into a map
  Future<void> loadFromFile(
      {String fileName = '.env',
      Parser parser = const Parser(),
      bool optional = true}) async {
    try {
      final linesFromFile = await _getEntriesFromFile(fileName);
      final envEntries = parser.parse(linesFromFile);
      _envMap.addAll(envEntries);
      _isInitialized = true;
    } on FileNotFoundError {
      if (!optional) {
        throw "找不到環境檔 $fileName";
      }
    }
  }

  Future<void> loadFromMap({required Map<String, String> map}) async {
    _envMap.addAll(map);
    _isInitialized = true;
  }

  void loadFormString(
      {String fileInput = '',
      Parser parser = const Parser(),
      Map<String, String> mergeWith = const {}}) {
    final linesFromFile = fileInput.split('\n');
    final linesFromMergeWith = mergeWith.entries
        .map((entry) => "${entry.key}=${entry.value}")
        .toList();
    final allLines = linesFromMergeWith..addAll(linesFromFile);
    final envEntries = parser.parse(allLines);
    _envMap.addAll(envEntries);
    _isInitialized = true;
  }

  /// True if all supplied variables have nonempty value; false otherwise.
  /// Differs from [containsKey](dart:core) by excluding null values.
  /// Note [loadFromFile] should be called first.
  bool isEveryDefined(Iterable<String> vars) =>
      vars.every((k) => _envMap[k]?.isNotEmpty ?? false);

  Future<List<String>> _getEntriesFromFile(String filename) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      var envString = await rootBundle.loadString(filename);
      if (envString.isEmpty) {
        return [];
      }
      return envString.split('\n');
    } on FlutterError {
      throw FileNotFoundError();
    }
  }
}
