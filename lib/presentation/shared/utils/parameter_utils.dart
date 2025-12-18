import 'package:flutter/material.dart';
import '../../../domain/entities/mocked_swagger_entity.dart';

/// Utility class for parameter-related operations
class ParameterUtils {
  static Color getParameterLocationColor(String inType) {
    switch (inType.toLowerCase()) {
      case 'query':
        return Colors.blue;
      case 'path':
        return Colors.purple;
      case 'header':
        return Colors.teal;
      case 'cookie':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  static String generateExampleValue(ParametersEntity param) {
    // If there's an enum, use the first value
    if (param.schema.enumValues.isNotEmpty) {
      return param.schema.enumValues.first.toString();
    }

    // Generate based on type
    switch (param.type.toLowerCase()) {
      case 'string':
        if (param.format == 'uuid') {
          return '00000000-0000-0000-0000-000000000000';
        } else if (param.format == 'date-time') {
          return DateTime.now().toIso8601String();
        } else if (param.format == 'date') {
          return DateTime.now().toIso8601String().split('T')[0];
        }
        return 'example_string';
      case 'integer':
      case 'int32':
      case 'int64':
        return '123';
      case 'number':
      case 'double':
      case 'float':
        return '123.45';
      case 'boolean':
        return 'true';
      default:
        return 'example_value';
    }
  }
}

