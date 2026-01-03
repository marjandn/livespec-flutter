import '../models/mocked_swagger_response.dart';

abstract class SwaggerLocalDatasource {
  Future<void> saveMockedSwaggerModel(MockedSwaggerResponse mockedSwaggerResponse);
}