import 'dart:convert';

import 'package:mock_api_generator/data/models/swagger_json_response.dart';
import 'package:mock_api_generator/data/remote_datasources/swagger_remote_datasource.dart';
import 'package:http/http.dart' as http;

import '../../core/exception/exceptions.dart';

class SwaggerRemoteDatasourceImpl implements SwaggerRemoteDataSource {
  final http.Client _client;

  SwaggerRemoteDatasourceImpl(this._client);

  @override
  Future<SwaggerJsonResponse> getSwaggerLinkJsonData(link) async {
    try {
      final result = await _client.get(Uri.parse(link));

      if (result.statusCode == 200) {
        return SwaggerJsonResponse.fromJson(jsonDecode(result.body));
      } else if (result.statusCode == 400) {
        throw RequestExceptions(message: 'Invalid link');
      } else {
        final m = result.body.toString();

        throw JsonParsingException(message: m);
      }
    } catch (e) {
      throw JsonParsingException(message: e.toString());
    }
  }
}
