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
  late final FakeSwaggerRepository _mockSwaggerRepository;
  late final GenerateSwaggerMockUsecase _generateSwaggerMockUseCase;

  setUp(() {
    _mockSwaggerRepository = FakeSwaggerRepository();
    _generateSwaggerMockUseCase = GenerateSwaggerMockUsecase(_mockSwaggerRepository);
  });

  test(
    'Should return a MockedSwaggerEntity instance when call GenerateSwaggerMockUsecase usecase with a valid link',
    () async {
      MockedSwaggerEntity mockedSwagger = MockedSwaggerEntity(
        mockedBaseUrl: 'https://mockedserver.com/api/',
        mockedEndpoints: ['a', 'b'],
      );

      when(
        () => _mockSwaggerRepository.generateSwaggerMockUseCase(validSwaggerLink),
      ).thenAnswer((_) async => Success(mockedSwagger));

      final result = await _generateSwaggerMockUseCase.call(validSwaggerLink);

      expect(result, isA<Success>().having((e) => e.data, 'data', isA<MockedSwaggerEntity>()));
    },
  );

  test(
    'Should return Failed result when call GenerateSwaggerMockUsecase usecase with an invalid link',
    () async {
      const invalidLink = "-";
      const errorMessage = "Swagger link was wrong!";
      when(
        () => _mockSwaggerRepository.generateSwaggerMockUseCase(invalidLink),
      ).thenAnswer((_) async => Failure(errorMessage));

      final result = await _generateSwaggerMockUseCase.call(invalidLink);

      expect(result, isA<Failure>().having((e) => e.message, 'message', errorMessage));
      verify(() => _mockSwaggerRepository.generateSwaggerMockUseCase(invalidLink)).called(1);
      verifyNoMoreInteractions(_mockSwaggerRepository);
    },
  );
}
