import 'package:injectable/injectable.dart';
import 'package:mock_api_generator/core/result/result.dart';
import 'package:mock_api_generator/core/usecase/usecase.dart';
import 'package:mock_api_generator/domain/entities/mocked_swagger_entity.dart';
import 'package:mock_api_generator/domain/repositories/swagger_repository.dart';

@injectable
class GenerateSwaggerMockUsecase extends UseCase<Result<MockedSwaggerEntity>, String> {
  final SwaggerRepository _swaggerRepository;

  GenerateSwaggerMockUsecase(this._swaggerRepository);

  @override
  Future<Result<MockedSwaggerEntity>> call(String link) =>
      _swaggerRepository.generateSwaggerMock(link);
}
