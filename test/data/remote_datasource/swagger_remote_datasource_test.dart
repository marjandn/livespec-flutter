import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mock_api_generator/core/exception/exceptions.dart';
import 'package:mock_api_generator/data/models/mocked_swagger_response.dart';
import 'package:mock_api_generator/data/remote_datasources/swagger_remote_datasource_impl.dart';

main() {
  const String validLink = 'https://swagger/v7.json';
  const String invalidLink = 'https://swagger/v.json';

  test('should return parsed Swagger model when getSwaggerLinkJsonData is called with valid link', () async {
    final json = jsonEncode({"openapi": "3.0.1", "title": "api Api"});
    final mockClient = MockClient((request) async => Response(json, 200));

    final swagerRemoteDataSource = SwaggerRemoteDatasourceImpl(mockClient);

    final result = await swagerRemoteDataSource.getSwaggerLinkJsonData(validLink);

    expect(result.openapi, "3.0.1");
  });

  test('should throw ParseException when getSwaggerLinkJsonData is called given invalid JSON data', () async {
    const errorMessage = 'Something went wrong';
    final mockClient = MockClient((request) async => Response(errorMessage, 500));
    final swagerRemoteDataSource = SwaggerRemoteDatasourceImpl(mockClient);

    try {
      await swagerRemoteDataSource.getSwaggerLinkJsonData(invalidLink);
    } catch (e) {
      expect(e, isA<JsonParsingException>().having((e) => e.message, 'message', errorMessage));
    }
  });

  test('should throw RequestExceptions when getSwaggerLinkJsonData is called with invalid link', () async {
    const errorMessage = 'Invalid link';
    final mockClient = MockClient((request) async => Response('Invalid link', 400));

    final swagerRemoteDataSource = SwaggerRemoteDatasourceImpl(mockClient);

    try {
      await swagerRemoteDataSource.getSwaggerLinkJsonData(invalidLink);
    } catch (e) {
      expect(e, isA<RequestExceptions>().having((e) => e.message, 'message', equals(errorMessage)));
    }
  });

  test(
    'should return MockedSwaggerResponse when generateSwaggerMockUseCase is called with valid link',
    () async {
      final response = jsonEncode({
        'mockedBaseUrl': 'https://sampleswagger.com',
        'mockedEndpoints': ['a', 'b'],
      });
      final mockClient = MockClient((request) async => Response(response, 200));
      final swaggerRemoteDatasource = SwaggerRemoteDatasourceImpl(mockClient);

      final result = await swaggerRemoteDatasource.generateSwaggerMockUseCase(validLink);

      expect(
        result,
        isA<MockedSwaggerResponse>().having((e) => e.mockedBaseUrl, 'Base URL', 'https://sampleswagger.com'),
      );
    },
  );

  test(
    'should throw RequestException when generateSwaggerMockUseCase is called with an invalid link',
    () async {
      const errorMessage = 'Invalid Link';
      final mockClient = MockClient((request) async => Response(errorMessage, 500));
      final swaggerRemoteDatasource = SwaggerRemoteDatasourceImpl(mockClient);

      try {
        await swaggerRemoteDatasource.generateSwaggerMockUseCase(invalidLink);
      } catch (e) {
        expect(e, isA<RequestExceptions>().having((e) => e.message, 'error Message', errorMessage));
      }
    },
  );
}
