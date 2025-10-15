import '../models/swagger_json_response.dart';

abstract class SwaggerRemoteDataSource {
  Future<SwaggerJsonResponse> getSwaggerLinkJsonData(link);
}
