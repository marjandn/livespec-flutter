import '../entities/swagger_entity.dart';
import '../repositories/swagger_repository.dart';

class GetSwaggerJsonUseCase {
  final SwaggerRepository _repository;

  GetSwaggerJsonUseCase(this._repository);

  Future<SwaggerEntity> call(String link) async {
    final result = await _repository.getSwaggerLinkJsonData(link);

    return result;
  }
}
