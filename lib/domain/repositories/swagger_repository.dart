import '../entities/swagger_entity.dart';

abstract class SwaggerRepository {
  Future<SwaggerEntity> getSwaggerLinkJsonData(String link);
}
