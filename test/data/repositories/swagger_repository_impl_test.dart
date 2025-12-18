import 'package:flutter_test/flutter_test.dart';
import 'package:mock_api_generator/core/exception/exceptions.dart';
import 'package:mock_api_generator/core/result/result.dart';
import 'package:mock_api_generator/data/models/mocked_swagger_response.dart';
import 'package:mock_api_generator/data/models/swagger_json_response.dart';
import 'package:mock_api_generator/data/remote_datasources/swagger_remote_datasource.dart';
import 'package:mock_api_generator/data/repositories/swagger_repository_impl.dart';
import 'package:mock_api_generator/domain/entities/mocked_swagger_entity.dart';
import 'package:mock_api_generator/domain/entities/swagger_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockSwaggerRemoteDataSource extends Mock
    implements SwaggerRemoteDataSource {}

void main() {
  late MockSwaggerRemoteDataSource mockSwaggerRemoteDataSource;
  late SwaggerRepositoryImpl swaggerRepositoryImpl;

  setUpAll(() {
    mockSwaggerRemoteDataSource = MockSwaggerRemoteDataSource();
    swaggerRepositoryImpl = SwaggerRepositoryImpl(mockSwaggerRemoteDataSource);
  });

  const String validLink = 'https://swagger/v7.json';
  const String invalidLink = 'https://swagger/v.json';

  test(
    'should return Swagger entity when getSwaggerLinkJsonData is called with valid link',
    () async {
      final response = SwaggerJsonResponse(openapi: "3.0.1", title: "apy API");
      when(
        () => mockSwaggerRemoteDataSource.getSwaggerLinkJsonData(validLink),
      ).thenAnswer((_) async => response);

      final result = await swaggerRepositoryImpl.getSwaggerLinkJsonData(
        validLink,
      );

      expect(result, isA<Success>());
      expect((result as Success<SwaggerEntity>).data?.openapi, '3.0.1');
      expect(result.data?.title, 'apy API');
      verify(
        () => mockSwaggerRemoteDataSource.getSwaggerLinkJsonData(validLink),
      ).called(1);
      verifyNoMoreInteractions(mockSwaggerRemoteDataSource);
    },
  );

  test(
    'should return Failure state when getSwaggerLinkJsonData is called with invalid link',
    () async {
      const errorMessage = 'something went wrong in parsing json';
      when(
        () => mockSwaggerRemoteDataSource.getSwaggerLinkJsonData(invalidLink),
      ).thenThrow(JsonParsingException(message: errorMessage));

      final result = await swaggerRepositoryImpl.getSwaggerLinkJsonData(
        invalidLink,
      );

      expect(result, isA<Failure>());
      expect((result as Failure).message, errorMessage);
      verify(
        () => mockSwaggerRemoteDataSource.getSwaggerLinkJsonData(invalidLink),
      ).called(1);
      verifyNoMoreInteractions(mockSwaggerRemoteDataSource);
    },
  );

  test(
    'should return MockedSwaggerEntity when generateSwaggerMockUseCase is called with valid link',
    () async {
      final MockedSwaggerResponse response = MockedSwaggerResponse(
        mockBaseUrl: 'https://mockedserver.com/api/',
      );
      when(
        () => mockSwaggerRemoteDataSource.generateSwaggerMock(validLink),
      ).thenAnswer((_) async => response);

      final result = await swaggerRepositoryImpl.generateSwaggerMock(validLink);

      expect(
        result,
        isA<Success>().having(
          (e) => e.data,
          'data',
          isA<MockedSwaggerEntity>(),
        ),
      );
      verify(
        () => mockSwaggerRemoteDataSource.generateSwaggerMock(validLink),
      ).called(1);
      verifyNoMoreInteractions(mockSwaggerRemoteDataSource);
      expect(
        (result as Success<MockedSwaggerEntity>).data?.mockedBaseUrl,
        'https://mockedserver.com/api/',
      );
    },
  );

  test(
    'should return Failure state when generateSwaggerMockUseCase is called with invalid link',
    () async {
      const errorMessage = "Invalid link";
      when(
        () => mockSwaggerRemoteDataSource.generateSwaggerMock(invalidLink),
      ).thenThrow(RequestExceptions(message: errorMessage));

      final result = await swaggerRepositoryImpl.generateSwaggerMock(
        invalidLink,
      );

      expect(
        result,
        isA<Failure>().having((e) => e.message, 'message', errorMessage),
      );
      verify(
        () => mockSwaggerRemoteDataSource.generateSwaggerMock(invalidLink),
      ).called(1);
      verifyNoMoreInteractions(mockSwaggerRemoteDataSource);
    },
  );
}
