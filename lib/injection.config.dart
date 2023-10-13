// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:wings_technical_test/core/injectable/register_module.dart'
    as _i9;
import 'package:wings_technical_test/features/auth/infrastructure/auth_repository.dart'
    as _i6;
import 'package:wings_technical_test/features/auth/presentation/store/provider_auth.dart'
    as _i8;
import 'package:wings_technical_test/features/checkout/infrastructure/checkout_repository.dart'
    as _i7;
import 'package:wings_technical_test/features/product-list/infrastructure/product_list_repository.dart'
    as _i4;
import 'package:wings_technical_test/features/product-list/presentation/store/provider_product_list.dart'
    as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i4.ProductListRepository>(
        () => _i4.ProductListRepository(gh<_i3.FirebaseFirestore>()));
    gh.factory<_i5.ProviderProductList>(
        () => _i5.ProviderProductList(gh<_i4.ProductListRepository>()));
    gh.lazySingleton<_i6.AuthRepository>(
        () => _i6.AuthRepository(gh<_i3.FirebaseFirestore>()));
    gh.lazySingleton<_i7.CheckoutRepository>(
        () => _i7.CheckoutRepository(gh<_i3.FirebaseFirestore>()));
    gh.factory<_i8.ProviderAuth>(
        () => _i8.ProviderAuth(gh<_i6.AuthRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i9.RegisterModule {}
