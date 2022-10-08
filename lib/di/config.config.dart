// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/repository/note_repository.dart' as _i4;
import '../domain/interactor/note_interactor.dart' as _i3;
import '../ui/pages/notes_page/notes_page_store.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.NoteInteractor>(
      () => _i3.NoteInteractor(userId: get<String>()));
  gh.singleton<_i4.NoteRepository>(_i4.NoteRepository());
  gh.factory<_i5.NotesStore>(() => _i5.NotesStore(get<String>()));
  return get;
}
