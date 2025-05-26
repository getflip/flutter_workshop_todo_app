// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/todo/data/datasources/todo_local_datasource.dart'
    as _i137;
import '../../features/todo/data/datasources/todo_remote_datasource.dart'
    as _i484;
import '../../features/todo/data/repositories/todo_repository.dart' as _i131;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i519.Client>(() => registerModule.httpClient);
    gh.factory<_i484.TodoRemoteDataSource>(
      () => _i484.TodoRemoteDataSource(gh<_i519.Client>()),
    );
    gh.factory<_i131.TodoRepository>(
      () => _i131.TodoRepository(gh<_i484.TodoRemoteDataSource>()),
    );
    gh.factory<_i137.TodoLocalDataSource>(
      () => _i137.TodoLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
