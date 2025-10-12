import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mock_api_generator/core/result/result.dart';
import 'package:mock_api_generator/domain/entities/swagger_entity.dart';
import 'package:mock_api_generator/domain/repositories/swagger_repository.dart';
import 'package:mock_api_generator/domain/usecases/get_swagger_json_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockSwaggerRepository extends Mock implements SwaggerRepository {}

void main() {
  late MockSwaggerRepository mockSwaggerRepository;
  late GetSwaggerJsonUseCase swaggerJsonUseCase;

  setUp(() {
    mockSwaggerRepository = MockSwaggerRepository();
    swaggerJsonUseCase = GetSwaggerJsonUseCase(mockSwaggerRepository);
  });

  test('Should reutrn Swagger entity when call getSwaggerJsonUseCase with a valid link', () async {
    const String link = 'http://swagger/v7/swagger.json';
    final swaggerEntity = SwaggerEntity(openapi: "3.0.1", title: "apy API");
    final repoResult = Success<SwaggerEntity>(swaggerEntity);
    when(() => mockSwaggerRepository.getSwaggerLinkJsonData(link)).thenAnswer((_) async => repoResult);

    final result = await swaggerJsonUseCase(link);

    expect(result, isA<Success>());
    expect((result as Success<SwaggerEntity>).data, swaggerEntity);
    expect((result).data?.openapi, '3.0.1');
  });

  test('Should return Failure state when call getSwaggerJsonUseCase with an invalid link', () async {
    const String link = 'http://invalidlink';
    final failureState = Failure<SwaggerEntity>('Swagger link was wrong!');
    when(() => mockSwaggerRepository.getSwaggerLinkJsonData(link)).thenAnswer((_) async => failureState);

    final result = await swaggerJsonUseCase(link);

    expect(result, isA<Failure>());
    expect((result as Failure).message, 'Swagger link was wrong!');
  });
}
