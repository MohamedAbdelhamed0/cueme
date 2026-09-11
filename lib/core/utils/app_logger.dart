import 'package:flutter/foundation.dart';

class AppLogger {
  static void debug(String tag, String message) {
    if (kDebugMode) {
      debugPrint('[$tag] $message');
    }
  }

  static void info(String tag, String message) {
    debugPrint('[$tag] INFO: $message');
  }

  static void warn(String tag, String message, [Object? error]) {
    debugPrint('[$tag] WARN: $message ${error != null ? "($error)" : ""}');
  }

  static void error(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('[$tag] ERROR: $message ${error != null ? "($error)" : ""}');
    if (stackTrace != null && kDebugMode) {
      debugPrint(stackTrace.toString());
    }
  }
}
