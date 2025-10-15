import 'package:mock_api_generator/core/result/result.dart';
import 'package:mock_api_generator/domain/entities/swagger_entity.dart';
import 'package:mock_api_generator/domain/repositories/swagger_repository.dart';

import '../remote_datasources/swagger_remote_datasource.dart';

class SwaggerRepositoryImpl extends SwaggerRepository {
  final SwaggerRemoteDataSource _swaggerRemoteDataSource;

  SwaggerRepositoryImpl(this._swaggerRemoteDataSource);

  @override
  Future<Result<SwaggerEntity>> getSwaggerLinkJsonData(String link) async {
    final result = await _swaggerRemoteDataSource.getSwaggerLinkJsonData(link);

    return Success(result.toEntity());
  }
}
