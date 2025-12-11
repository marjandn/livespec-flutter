// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mock_api_generator/core/di/network_module.dart' as _i434;
import 'package:mock_api_generator/data/remote_datasources/swagger_remote_datasource.dart'
    as _i1018;
import 'package:mock_api_generator/data/remote_datasources/swagger_remote_datasource_impl.dart'
    as _i801;
import 'package:mock_api_generator/data/repositories/swagger_repository_impl.dart'
    as _i654;
import 'package:mock_api_generator/domain/repositories/swagger_repository.dart'
    as _i955;
import 'package:mock_api_generator/domain/usecases/generate_swagger_mock_usecase.dart'
    as _i161;
import 'package:mock_api_generator/domain/usecases/get_swagger_json_usecase.dart'
    as _i563;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i519.Client>(() => networkModule.client);
    gh.lazySingleton<_i1018.SwaggerRemoteDataSource>(
      () => _i801.SwaggerRemoteDatasourceImpl(gh<_i519.Client>()),
    );
    gh.lazySingleton<_i955.SwaggerRepository>(
      () => _i654.SwaggerRepositoryImpl(gh<_i1018.SwaggerRemoteDataSource>()),
    );
    gh.factory<_i563.GetSwaggerJsonUseCase>(
      () => _i563.GetSwaggerJsonUseCase(gh<_i955.SwaggerRepository>()),
    );
    gh.factory<_i161.GenerateSwaggerMockUsecase>(
      () => _i161.GenerateSwaggerMockUsecase(gh<_i955.SwaggerRepository>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i434.NetworkModule {}
