import 'package:flutter_test/flutter_test.dart';
import 'package:mock_api_generator/core/result/result.dart';
import 'package:mock_api_generator/domain/entities/mocked_swagger_entity.dart' show MockedSwaggerEntity;
import 'package:mock_api_generator/domain/repositories/swagger_repository.dart';
import 'package:mock_api_generator/domain/usecases/generate_swagger_mock_usecase.dart';
import 'package:mocktail/mocktail.dart';

class FakeSwaggerRepository extends Mock implements SwaggerRepository {}

void main() {
  const validSwaggerLink = 'https://swagger/v7.json';
  late final FakeSwaggerRepository mockSwaggerRepository;
  late final GenerateSwaggerMockUsecase generateSwaggerMockUseCase;

  setUp(() {
    mockSwaggerRepository = FakeSwaggerRepository();
    generateSwaggerMockUseCase = GenerateSwaggerMockUsecase(mockSwaggerRepository);
  });

  test(
    'Should return a MockedSwaggerEntity instance when call GenerateSwaggerMockUsecase usecase with a valid link',
    () async {
      MockedSwaggerEntity mockedSwagger = MockedSwaggerEntity(
        mockedBaseUrl: 'https://mockedserver.com/api/',
        mockedEndpoints: ['a', 'b'],
      );

      when(
        () => mockSwaggerRepository.generateSwaggerMockUseCase(validSwaggerLink),
      ).thenAnswer((_) async => Success(mockedSwagger));

      final result = await generateSwaggerMockUseCase.call(validSwaggerLink);

      expect(result, isA<Success>().having((e) => e.data, 'data', isA<MockedSwaggerEntity>()));
      verify(() => mockSwaggerRepository.generateSwaggerMockUseCase(validSwaggerLink)).called(1);
      verifyNoMoreInteractions(mockSwaggerRepository);
    },
  );

  test(
    'Should return Failed result when call GenerateSwaggerMockUsecase usecase with an invalid link',
    () async {
      const invalidLink = "-";
      const errorMessage = "Swagger link was wrong!";
      when(
        () => mockSwaggerRepository.generateSwaggerMockUseCase(invalidLink),
      ).thenAnswer((_) async => Failure(errorMessage));

      final result = await generateSwaggerMockUseCase.call(invalidLink);

      expect(result, isA<Failure>().having((e) => e.message, 'message', errorMessage));
      verify(() => mockSwaggerRepository.generateSwaggerMockUseCase(invalidLink)).called(1);
      verifyNoMoreInteractions(mockSwaggerRepository);
    },
  );
}
