// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/core_module.dart' as _i1039;
import 'core/di/auth/auth_module.dart' as _i858;
import 'core/di/auth/auth_module_impl.dart' as _i903;
import 'core/di/auth/auth_module_stub.dart' as _i908;
import 'core/di/configuration/configuration.dart' as _i459;
import 'core/di/configuration/configuration_dev.dart' as _i404;
import 'core/di/configuration/configuration_integration.dart' as _i711;
import 'core/di/configuration/configuration_preprod.dart' as _i575;
import 'core/di/configuration/configuration_prod.dart' as _i658;
import 'core/di/configuration/configuration_recette.dart' as _i593;
import 'core/di/configuration/configuration_test.dart' as _i595;
import 'core/di/di_module.dart' as _i268;
import 'core/di/network/api_module_impl.dart' as _i1022;
import 'core/di/network/api_module_stub.dart' as _i763;
import 'data/data_module.dart' as _i947;
import 'data/repositories/auth_repository.dart' as _i593;
import 'data/repositories/auth_repository_impl.dart' as _i145;
import 'domain/domain_module.dart' as _i230;
import 'domain/usecases/auth/reset_password_use_case.dart' as _i697;
import 'domain/usecases/auth/sign_in_use_case.dart' as _i784;
import 'domain/usecases/auth/sign_out_use_case.dart' as _i360;
import 'domain/usecases/auth/sign_up_use_case.dart' as _i977;
import 'domain/usecases/auth/watch_auth_state_use_case.dart' as _i955;
import 'ui/auth/auth_interactor.dart' as _i893;
import 'ui/auth/auth_module.dart' as _i57;
import 'ui/router.dart' as _i766;

const String _dev = 'dev';
const String _test = 'test';
const String _prod = 'prod';
const String _integration = 'integration';
const String _recette = 'recette';
const String _preprod = 'preprod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i459.Configuration>(
      () => _i404.ConfigurationDev(),
      registerFor: {_dev},
    );
    gh.singleton<_i459.Configuration>(
      () => _i595.ConfigurationDev(),
      registerFor: {_test},
    );
    gh.singleton<_i459.Configuration>(
      () => _i658.ConfigurationDev(),
      registerFor: {_prod},
    );
    gh.singleton<_i459.Configuration>(
      () => _i711.ConfigurationDev(),
      registerFor: {_integration},
    );
    gh.singleton<_i459.Configuration>(
      () => _i593.ConfigurationDev(),
      registerFor: {_recette},
    );
    gh.singleton<_i459.Configuration>(
      () => _i575.ConfigurationDev(),
      registerFor: {_preprod},
    );
    gh.singleton<_i858.AuthModule>(
      () => _i908.AuthModuleStub(),
      registerFor: {_test},
    );
    gh.singleton<_i268.ApiModule>(
      () => _i763.ApiModuleImpl(gh<_i268.Configuration>()),
      registerFor: {_test},
    );
    gh.singleton<_i858.AuthModule>(
      () => _i903.AuthModuleImpl(),
      registerFor: {_dev, _integration, _recette, _preprod, _prod},
    );
    gh.singleton<_i766.AppRouter>(
      () => _i766.AppRouter(gh<_i1039.AuthModule>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i593.AuthRepository>(
      () => _i145.AuthRepositoryImpl(gh<_i1039.AuthModule>()),
    );
    gh.singleton<_i57.AuthUiModule>(
      () => _i57.AuthUiModule(gh<_i766.AppRouter>()),
    );
    gh.singleton<_i268.ApiModule>(
      () => _i1022.ApiModuleImpl(gh<_i268.Configuration>()),
      registerFor: {_dev, _integration, _recette, _preprod, _prod},
    );
    gh.singleton<_i697.ResetPasswordUseCase>(
      () => _i697.ResetPasswordUseCase(gh<_i947.AuthRepository>()),
    );
    gh.singleton<_i784.SignInUseCase>(
      () => _i784.SignInUseCase(gh<_i947.AuthRepository>()),
    );
    gh.singleton<_i360.SignOutUseCase>(
      () => _i360.SignOutUseCase(gh<_i947.AuthRepository>()),
    );
    gh.singleton<_i977.SignUpUseCase>(
      () => _i977.SignUpUseCase(gh<_i947.AuthRepository>()),
    );
    gh.singleton<_i955.WatchAuthStateUseCase>(
      () => _i955.WatchAuthStateUseCase(gh<_i947.AuthRepository>()),
    );
    gh.singleton<_i893.AuthInteractor>(
      () => _i893.AuthInteractor(
        gh<_i230.SignUpUseCase>(),
        gh<_i230.SignInUseCase>(),
        gh<_i230.ResetPasswordUseCase>(),
        gh<_i230.SignOutUseCase>(),
        gh<_i230.WatchAuthStateUseCase>(),
      ),
    );
    return this;
  }
}
