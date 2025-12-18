import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../domain/entities/mocked_swagger_entity.dart';
import '../utils/uri_builder.dart';

class EndpointTestResult {
  final Uri uri;
  final String method;
  final String? requestBody;
  final Map<String, String> headers;
  final http.Response response;

  const EndpointTestResult({
    required this.uri,
    required this.method,
    required this.requestBody,
    required this.headers,
    required this.response,
  });
}

/// Shared service that performs an actual HTTP call against a mocked endpoint.
///
/// UI concerns (loading state, SnackBars, formatting) should live in widgets.
class EndpointTestService {
  const EndpointTestService();

  Future<EndpointTestResult> testEndpoint({
    required String baseUrl,
    required MockedEndpointsEntity endpoint,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final uri = UriBuilder.buildUriWithQueryParams(
      baseUrl,
      endpoint.path,
      endpoint.parameters.query,
    );

    final method = endpoint.method.toUpperCase();
    final methodHasBody = method == 'POST' || method == 'PUT' || method == 'PATCH';

    final contentType = endpoint.requestBody.contentTypes.isNotEmpty
        ? endpoint.requestBody.contentTypes.keys.first
        : null;

    final example = _pickRequestBodyExample(endpoint);
    final requestBody = example == null ? null : _serializeRequestBody(example);

    final headers = <String, String>{};
    if (methodHasBody) {
      headers['Content-Type'] = contentType ?? 'application/json';
    }

    final http.Response response;
    switch (method) {
      case 'GET':
        response = await http.get(uri, headers: headers).timeout(timeout);
        break;
      case 'POST':
        response = await http
            .post(
              uri,
              headers: headers,
              body: requestBody ?? '{}',
            )
            .timeout(timeout);
        break;
      case 'PUT':
        response = await http
            .put(
              uri,
              headers: headers,
              body: requestBody ?? '{}',
            )
            .timeout(timeout);
        break;
      case 'PATCH':
        response = await http
            .patch(
              uri,
              headers: headers,
              body: requestBody ?? '{}',
            )
            .timeout(timeout);
        break;
      case 'DELETE':
        response = await http.delete(uri, headers: headers).timeout(timeout);
        break;
      default:
        response = await http.get(uri, headers: headers).timeout(timeout);
    }

    return EndpointTestResult(
      uri: uri,
      method: method,
      requestBody: requestBody,
      headers: headers,
      response: response,
    );
  }

  dynamic _pickRequestBodyExample(MockedEndpointsEntity endpoint) {
    if (endpoint.requestBody.contentTypes.isNotEmpty) {
      final firstContentType = endpoint.requestBody.contentTypes.keys.first;
      final contentTypeInfo =
          endpoint.requestBody.contentTypes[firstContentType];
      if (contentTypeInfo?.generatedExample != null) {
        return contentTypeInfo!.generatedExample;
      }
    }

    return endpoint.requestBody.example;
  }

  String _serializeRequestBody(dynamic example) {
    if (example is String) return example;
    return jsonEncode(example);
  }
}


