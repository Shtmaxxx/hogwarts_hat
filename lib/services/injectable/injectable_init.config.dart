// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../core/api_manager.dart' as _i3;
import '../../repositories/character_repository.dart' as _i4;
import '../../screens/details/cubit/details_cubit.dart' as _i6;
import '../../screens/main/cubit/characters_cubit.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// an extension to register the provided dependencies inside of [GetIt]
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of provided dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.ApiManager>(_i3.ApiManager());
    gh.factory<_i4.CharacterRepositoryI>(
        () => _i4.CharacterRepositoryImpl(get<_i3.ApiManager>()));
    gh.factory<_i5.CharactersCubit>(
        () => _i5.CharactersCubit(get<_i4.CharacterRepositoryI>()));
    gh.factory<_i6.DetailsCubit>(
        () => _i6.DetailsCubit(get<_i4.CharacterRepositoryI>()));
    return this;
  }
}
