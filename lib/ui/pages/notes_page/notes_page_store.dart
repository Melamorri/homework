import 'package:firebase/domain/model/note_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import '../../../domain/interactor/note_interactor.dart';

part 'notes_page_store.g.dart';

@injectable
class NotesStore = _NotesStore with _$NotesStore;

abstract class _NotesStore with Store {
  late final NoteInteractor _notesInteractor;

  @observable
  List<NoteModel> value = [];

  @action
  getData() {
    _notesInteractor.streamNotes.listen((notes) {
      value = notes;
    });
  }

  Future addNote(NoteModel note) => _notesInteractor.addNote(note);

  Future deleteNote(NoteModel note) => _notesInteractor.deleteNote(note);

  Future updateNote(NoteModel note, NoteModel newNote) =>
      _notesInteractor.updateNote(note, newNote);

  _NotesStore(String userId) {
    _notesInteractor = NoteInteractor(userId: userId);
  }
}
