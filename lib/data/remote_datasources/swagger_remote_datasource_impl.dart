import 'dart:convert';

import 'package:mock_api_generator/data/models/swagger_json_response.dart';
import 'package:mock_api_generator/data/remote_datasources/swagger_remote_datasource.dart';
import 'package:http/http.dart' as http;

class SwaggerRemoteDatasourceImpl implements SwaggerRemoteDataSource {
  final http.Client _client;

  SwaggerRemoteDatasourceImpl(this._client);

  @override
  Future<SwaggerJsonResponse> getSwaggerLinkJsonData(link) async {
    final result = await _client.get(Uri.parse(link));

    return SwaggerJsonResponse.fromJson(jsonDecode(result.body));
  }
}
