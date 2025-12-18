import 'dart:convert';

/// Utility class for JSON formatting
class JsonFormatter {
  static String formatJson(dynamic json) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(json);
    } catch (e) {
      return json.toString();
    }
  }
}

