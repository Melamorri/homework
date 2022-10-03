import 'package:firebase/domain/model/note_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class NoteRepository {
  Stream<List<NoteModel>> getUserNotesStream(String userId) async* {
    final ref = FirebaseDatabase.instance.ref("notes/$userId");
    await for (final event in ref.onValue) {
      final map = event.snapshot.value as Map<dynamic, dynamic>?;
      if (map != null) {
        final List<NoteModel> notes = [];
        map.forEach((key, value) {
          notes.add(NoteModel(userId: userId, text: value, id: key));
        });
        yield notes;
      }
    }
  }

  Future create(NoteModel noteModel) async {
    final userId = noteModel.userId;
    final ref = FirebaseDatabase.instance.ref("notes/$userId");
    await ref.push().set(noteModel.text);
  }

  Future update(NoteModel noteModel, NoteModel newNoteModel) async {
    delete(noteModel);
    create(newNoteModel);
  }

  Future delete(NoteModel noteModel) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final notes = await FirebaseDatabase.instance.ref("notes/$userId").get();
    final note = notes.child(noteModel.id);
    note.ref.remove();
  }
}
