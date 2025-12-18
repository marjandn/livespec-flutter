import '../models/mocked_swagger_response.dart';
import '../models/swagger_json_response.dart';

abstract class SwaggerRemoteDataSource {
  Future<SwaggerJsonResponse> getSwaggerLinkJsonData(link);
  Future<MockedSwaggerResponse> generateSwaggerMock(link);
}
