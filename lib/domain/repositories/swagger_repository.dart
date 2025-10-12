import '../../core/result/result.dart';
import '../entities/swagger_entity.dart';

abstract class SwaggerRepository {
  Future<Result<SwaggerEntity>> getSwaggerLinkJsonData(String link);
}
