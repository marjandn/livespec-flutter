import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_api_generator/core/result/result.dart';
import 'package:mock_api_generator/domain/entities/mocked_swagger_entity.dart' show MockedSwaggerEntity;
import 'package:mock_api_generator/domain/repositories/swagger_repository.dart';
import 'package:mock_api_generator/domain/usecases/generate_swagger_mock_usecase.dart';
import 'package:mocktail/mocktail.dart';

class FakeSwaggerRepository extends Mock implements SwaggerRepository {}

void main() {
  const validSwaggerLink = 'https://swagger/v7.json';
  late final mockSwaggerRepository;

  setUpAll(() {
    mockSwaggerRepository = FakeSwaggerRepository();
  });

  test(
    'Should return a MockedSwaggerEntity instance when call GenerateSwaggerMockUsecase usecase with a valid link',
    () async {
      MockedSwaggerEntity mockedSwagger = MockedSwaggerEntity(
        mockedBaseUrl: 'https://mockedserver.com/api/',
        mockedEndpoints: ['a', 'b'],
      );

      final useCase = GenerateSwaggerMockUsecase(mockSwaggerRepository);
      when(
        () => mockSwaggerRepository.generateSwaggerMockUseCase(validSwaggerLink),
      ).thenAnswer((_) async => Success(mockedSwagger));

      final result = await useCase.call(validSwaggerLink);

      expect(result, isA<Success>().having((e) => e.data, 'data', isA<MockedSwaggerEntity>()));
    },
  );
}
