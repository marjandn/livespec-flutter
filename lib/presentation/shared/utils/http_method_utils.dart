import 'package:flutter/material.dart';

/// Utility class for HTTP method-related operations
class HttpMethodUtils {
  static Color getMethodColor(String method) {
    switch (method.toUpperCase()) {
      case 'GET':
        return Colors.green;
      case 'POST':
        return Colors.blue;
      case 'PUT':
        return Colors.orange;
      case 'PATCH':
        return Colors.amber;
      case 'DELETE':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static IconData getMethodIcon(String method) {
    switch (method.toUpperCase()) {
      case 'GET':
        return Icons.download;
      case 'POST':
        return Icons.add_circle;
      case 'PUT':
        return Icons.edit;
      case 'PATCH':
        return Icons.build;
      case 'DELETE':
        return Icons.delete;
      default:
        return Icons.http;
    }
  }

  static Color getStatusCodeColor(String code) {
    if (code == '200' || code == '201' || code == '204') {
      return Colors.green;
    } else if (code == '400' || code == '401' || code == '403' || code == '404') {
      return Colors.red;
    } else if (code == '500' || code == '502' || code == '503') {
      return Colors.red[900]!;
    } else {
      return Colors.orange;
    }
  }
}

