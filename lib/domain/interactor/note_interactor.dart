import 'package:injectable/injectable.dart';
import '../../data/repository/note_repository.dart';
import '../model/note_model.dart';

@injectable
class NoteInteractor {
  final NoteRepository _repository = NoteRepository();

  Stream<List<NoteModel>> get streamNotes =>
      _repository.getUserNotesStream(userId);

  Future addNote(NoteModel note) => _repository.create(note);

  Future deleteNote(NoteModel note) => _repository.delete(note);

  Future updateNote(NoteModel note, NoteModel newNote) =>
      _repository.update(note, newNote);

  final String userId;

  NoteInteractor({
    required this.userId,
  });
}
