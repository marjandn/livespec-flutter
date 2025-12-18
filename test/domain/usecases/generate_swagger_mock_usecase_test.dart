import 'package:flutter_test/flutter_test.dart';
import 'package:mock_api_generator/core/result/result.dart';
import 'package:mock_api_generator/domain/entities/mocked_swagger_entity.dart';
import 'package:mock_api_generator/domain/repositories/swagger_repository.dart';
import 'package:mock_api_generator/domain/usecases/generate_swagger_mock_usecase.dart';
import 'package:mocktail/mocktail.dart';

class FakeSwaggerRepository extends Mock implements SwaggerRepository {}

void main() {
  const validSwaggerLink = 'https://swagger/v7.json';
  late final FakeSwaggerRepository mockSwaggerRepository;
  late final GenerateSwaggerMockUsecase generateSwaggerMockUseCase;

  setUpAll(() {
    mockSwaggerRepository = FakeSwaggerRepository();
    generateSwaggerMockUseCase = GenerateSwaggerMockUsecase(
      mockSwaggerRepository,
    );
  });

  test(
    'should return a MockedSwaggerEntity instance when generateSwaggerMockUseCase is called with valid link',
    () async {
      MockedSwaggerEntity mockedSwagger = MockedSwaggerEntity(
        mockedBaseUrl: 'https://mockedserver.com/api/',
        mockedEndpoints: [],
      );

      when(
        () => mockSwaggerRepository.generateSwaggerMock(validSwaggerLink),
      ).thenAnswer((_) async => Success(mockedSwagger));

      final result = await generateSwaggerMockUseCase.call(validSwaggerLink);

      expect(
        result,
        isA<Success>().having(
          (e) => e.data,
          'data',
          isA<MockedSwaggerEntity>(),
        ),
      );
      verify(
        () => mockSwaggerRepository.generateSwaggerMock(validSwaggerLink),
      ).called(1);
      verifyNoMoreInteractions(mockSwaggerRepository);
    },
  );

  test(
    'should return Failed result when generateSwaggerMockUseCase is called with invalid link',
    () async {
      const invalidLink = "-";
      const errorMessage = "Swagger link was wrong!";
      when(
        () => mockSwaggerRepository.generateSwaggerMock(invalidLink),
      ).thenAnswer((_) async => Failure(errorMessage));

      final result = await generateSwaggerMockUseCase.call(invalidLink);

      expect(
        result,
        isA<Failure>().having((e) => e.message, 'message', errorMessage),
      );
      verify(
        () => mockSwaggerRepository.generateSwaggerMock(invalidLink),
      ).called(1);
      verifyNoMoreInteractions(mockSwaggerRepository);
    },
  );
}
