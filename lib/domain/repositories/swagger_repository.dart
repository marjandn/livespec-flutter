import 'package:mock_api_generator/domain/entities/mocked_swagger_entity.dart';

import '../../core/result/result.dart';
import '../entities/swagger_entity.dart';

abstract class SwaggerRepository {
  Future<Result<SwaggerEntity>> getSwaggerLinkJsonData(String swaggerLink);
  Future<Result<MockedSwaggerEntity>> generateSwaggerMock(String swaggerLink);
}
