import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseHelper {
  static Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == 'user-not-found') {
        print("Unknown user");
      } else if (e.code == 'wrong-password') {
        print("Wrong password");
      }
    } catch (e) {
      print("Unknown error");
    }
    return false;
  }

  static Future<bool> signUp(
      String email, String password, String username) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser?.updateDisplayName(username);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        print('Invalid email address.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/invalid-email') {
        print('Invalid email');
      }
      print(e);
    }
  }

  static Future<void> write (String note) async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) return;
    final ref = FirebaseDatabase.instance.ref("notes/$id");
    await ref.push().set(note);
  }

  static Stream<DatabaseEvent> getNotes() {
    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) return const Stream.empty();
    final ref = FirebaseDatabase.instance.ref("notes/$id");
    return ref.onValue;
  }
  static void removeNote(int noteIdx) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final notes = await FirebaseDatabase.instance.ref("notes/$userId").get();
    final note = notes.children.elementAt(noteIdx);
    note.ref.remove();
  }
  static Future<void> updateNote(int noteIdx, String newNote) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final notes = await FirebaseDatabase.instance.ref("notes/$userId").get();
    final note = notes.children.elementAt(noteIdx);
        note.ref.remove();
        note.ref.set(newNote);
  }
  static Future<bool> isProMode() async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) return false;
    final ref = FirebaseDatabase.instance.ref("subscriptions/$id/enable");
    final snapshot = await ref.get();
    return snapshot.value as bool? ?? false;
  }

  static Future enableProMode() async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) return false;
    final ref = FirebaseDatabase.instance.ref("subscriptions/$id/enable");
    await ref.set(true);
  }
}
