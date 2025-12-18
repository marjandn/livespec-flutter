import 'dart:core';
import '../../../domain/entities/mocked_swagger_entity.dart';
import 'parameter_utils.dart';

/// Utility class for building URIs with query parameters
class UriBuilder {
  static Uri buildUriWithQueryParams(
    String baseUrl,
    String path,
    List<ParametersEntity> queryParams,
  ) {
    final uri = Uri.parse('$baseUrl$path');
    final queryParamsMap = <String, String>{};

    for (var param in queryParams) {
      final exampleValue = ParameterUtils.generateExampleValue(param);
      queryParamsMap[param.name] = exampleValue;
    }

    return uri.replace(queryParameters: queryParamsMap);
  }
}

