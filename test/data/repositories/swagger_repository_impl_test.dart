import 'package:flutter_test/flutter_test.dart';
import 'package:mock_api_generator/core/result/result.dart';
import 'package:mock_api_generator/data/models/swagger_json_response.dart';
import 'package:mock_api_generator/data/remote_datasources/swagger_remote_datasource.dart';
import 'package:mock_api_generator/data/repositories/swagger_repository_impl.dart';
import 'package:mock_api_generator/domain/entities/swagger_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockSwaggerRemoteDataSource extends Mock implements SwaggerRemoteDataSource {}

void main() {
  late MockSwaggerRemoteDataSource mockSwaggerRemoteDataSource;
  late SwaggerRepositoryImpl swaggerRepositoryImpl;

  setUp(() {
    mockSwaggerRemoteDataSource = MockSwaggerRemoteDataSource();
    swaggerRepositoryImpl = SwaggerRepositoryImpl(mockSwaggerRemoteDataSource);
  });

  const String validLink = 'https://swagger/v7.json';
  final response = SwaggerJsonResponse(openapi: "3.0.1", title: "apy API");
  final entity = SwaggerEntity(openapi: "3.0.1", title: "apy API");

  test('Should return Swagger entity when remote datasource is called with a valid response', () async {
    when(
      () => mockSwaggerRemoteDataSource.getSwaggerLinkJsonData(validLink),
    ).thenAnswer((_) async => response);

    final result = await swaggerRepositoryImpl.getSwaggerLinkJsonData(validLink);

    expect(result, isA<Success>());
    expect((result as Success<SwaggerEntity>).data?.openapi, '3.0.1');
    expect(result.data?.title, 'apy API');
    verify(() => mockSwaggerRemoteDataSource.getSwaggerLinkJsonData(validLink)).called(1);
    verifyNoMoreInteractions(mockSwaggerRemoteDataSource);
  });
}
