import 'package:injectable/injectable.dart';
import 'package:mock_api_generator/core/result/result.dart';
import 'package:mock_api_generator/domain/entities/mocked_swagger_entity.dart';
import 'package:mock_api_generator/domain/entities/swagger_entity.dart';
import 'package:mock_api_generator/domain/repositories/swagger_repository.dart';

import '../../core/exception/exceptions.dart';
import '../remote_datasources/swagger_remote_datasource.dart';

@LazySingleton(as: SwaggerRepository)
class SwaggerRepositoryImpl extends SwaggerRepository {
  final SwaggerRemoteDataSource _swaggerRemoteDataSource;

  SwaggerRepositoryImpl(this._swaggerRemoteDataSource);

  @override
  Future<Result<SwaggerEntity>> getSwaggerLinkJsonData(
    String swaggerLink,
  ) async {
    try {
      final result = await _swaggerRemoteDataSource.getSwaggerLinkJsonData(
        swaggerLink,
      );
      return Success(result.toEntity());
    } catch (e) {
      return switch (e) {
        JsonParsingException e => Failure(e.message),
        _ => Failure('unknown exception $e'),
      };
    }
  }

  @override
  Future<Result<MockedSwaggerEntity>> generateSwaggerMock(
    String swaggerLink,
  ) async {
    try {
      final result = await _swaggerRemoteDataSource.generateSwaggerMock(
        swaggerLink,
      );

      return Success(result.toEntity());
    } catch (e) {
      return switch (e) {
        JsonParsingException e => Failure(e.message),
        RequestExceptions e => Failure(e.message),
        _ => Failure('unknown exception $e'),
      };
    }
  }
}
