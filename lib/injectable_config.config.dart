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

import 'core/di/network_module.dart' as _i177;
import 'data/remote_datasources/swagger_remote_datasource.dart' as _i666;
import 'data/remote_datasources/swagger_remote_datasource_impl.dart' as _i315;
import 'data/repositories/swagger_repository_impl.dart' as _i37;
import 'domain/repositories/swagger_repository.dart' as _i317;
import 'domain/usecases/get_swagger_json_usecase.dart' as _i817;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i519.Client>(() => networkModule.client);
    gh.lazySingleton<_i666.SwaggerRemoteDataSource>(
      () => _i315.SwaggerRemoteDatasourceImpl(gh<_i519.Client>()),
    );
    gh.lazySingleton<_i317.SwaggerRepository>(
      () => _i37.SwaggerRepositoryImpl(gh<_i666.SwaggerRemoteDataSource>()),
    );
    gh.factory<_i817.GetSwaggerJsonUseCase>(
      () => _i817.GetSwaggerJsonUseCase(gh<_i317.SwaggerRepository>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i177.NetworkModule {}
