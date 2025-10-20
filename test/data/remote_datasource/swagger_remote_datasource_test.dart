import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mock_api_generator/data/remote_datasources/swagger_remote_datasource_impl.dart';

main() {
  const String validLink = 'https://swagger/v7.json';

  test('should return parsed Swagger model when link is valid', () async {
    final json = jsonEncode({"openapi": "3.0.1", "title": "api Api"});
    final mockClient = MockClient((request) async => Response(json, 200));

    final swagerRemoteDataSource = SwaggerRemoteDatasourceImpl(mockClient);

    final result = await swagerRemoteDataSource.getSwaggerLinkJsonData(validLink);

    expect(result.openapi, "3.0.1");
  });
}
