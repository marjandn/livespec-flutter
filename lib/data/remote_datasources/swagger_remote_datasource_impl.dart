import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mock_api_generator/data/models/mocked_swagger_response.dart';
import 'package:mock_api_generator/data/models/swagger_json_response.dart';
import 'package:mock_api_generator/data/remote_datasources/swagger_remote_datasource.dart';
import 'package:http/http.dart' as http;

import '../../core/exception/exceptions.dart';

@LazySingleton(as: SwaggerRemoteDataSource)
class SwaggerRemoteDatasourceImpl implements SwaggerRemoteDataSource {
  final http.Client _client;

  SwaggerRemoteDatasourceImpl(this._client);

  @override
  Future<SwaggerJsonResponse> getSwaggerLinkJsonData(link) async {
    final result = await _client.get(Uri.parse(link));

    if (result.statusCode == 200) {
      return SwaggerJsonResponse.fromJson(jsonDecode(result.body));
    } else if (result.statusCode == 400) {
      throw RequestExceptions(message: 'Invalid link');
    }
    throw JsonParsingException(message: result.body);
  }

  @override
  Future<MockedSwaggerResponse> generateSwaggerMock(link) async {
    final result = await _client.post(
      Uri.parse('https://mock-api-generator-server.onrender.com/load-swagger?page=1&limit=10'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"url": link}),
    );

    if (result.statusCode == 200) {
      return MockedSwaggerResponse.fromJson(jsonDecode(result.body));
    } else if (result.statusCode == 400) {
      throw JsonParsingException(message: result.body);
    }

    throw RequestExceptions(message: result.body);
  }
}
