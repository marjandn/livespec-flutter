import 'package:injectable/injectable.dart';
import 'package:mock_api_generator/data/local_datasource/swagger_local_datasource.dart'
    show SwaggerLocalDatasource;

import '../models/mocked_swagger_response.dart';

@LazySingleton(as: SwaggerLocalDatasource)
class SwaggerLocalDatasourceImpl implements SwaggerLocalDatasource {
  @override
  Future<void> saveMockedSwaggerModel(
    MockedSwaggerResponse mockedSwaggerResponse,
  ) async {
    
  }
} 
