import 'package:mock_api_generator/core/usecase/usecase.dart';

import '../../core/result/result.dart';
import '../entities/swagger_entity.dart';
import '../repositories/swagger_repository.dart';

class GetSwaggerJsonUseCase extends UseCase<Result<SwaggerEntity>, String> {
  final SwaggerRepository _repository;

  GetSwaggerJsonUseCase(this._repository);

  @override
  Future<Result<SwaggerEntity>> call(String link) async {
    return _repository.getSwaggerLinkJsonData(link);
  }
}
