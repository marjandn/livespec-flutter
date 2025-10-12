import 'package:mock_api_generator/core/usecase/usecase.dart';

import '../entities/swagger_entity.dart';
import '../repositories/swagger_repository.dart';

class GetSwaggerJsonUseCase extends UseCase<SwaggerEntity, String> {
  final SwaggerRepository _repository;

  GetSwaggerJsonUseCase(this._repository);

  @override
  Future<SwaggerEntity> call(String link) async {
    final result = await _repository.getSwaggerLinkJsonData(link);

    return result;
  }
}
