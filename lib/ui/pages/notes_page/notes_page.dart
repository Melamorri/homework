import 'package:firebase/di/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../const/greeting_msg.dart';
import '../../../const/strings.dart';
import '../../../domain/model/note_model.dart';
import '../../../firebase/firebase_helper.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/single_note.dart';
import 'notes_page_store.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  User? user;
  var notes = <NoteModel>[];
  final nameController = TextEditingController();
  var proMode = false;
  var _viewModel = getIt<NotesStore>();

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Observer(builder: (_) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(
              height: 250,
              child: HeaderWidget(250, true, Icons.home_sharp),
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              greetingMessage(user?.displayName),
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
            ..._notes((NoteModel currentNote) async {
              _viewModel.deleteNote(currentNote);
            }, (NoteModel currentNote) async {
              _showDialog(Strings.editNote, Strings.newName, (newText) {
                final userId = FirebaseAuth.instance.currentUser?.uid;
                if (userId == null) {
                  return;
                }
                final noteModel =
                    NoteModel.create(userId: userId, text: newText);
                _viewModel.updateNote(currentNote, noteModel);
              }, Strings.editButton);
            }),
          ]);
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                  child: const Icon(Icons.logout_rounded),
                  onPressed: () async {
                    FirebaseHelper.logout();
                    Navigator.pushNamed(context, '/login');
                  }),
              FloatingActionButton(
                onPressed: () {
                  _showDialog(Strings.newNote, Strings.name, onPressedWrite,
                      Strings.addButton);
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ));
  }

  void _initData() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return;
    }
    _viewModel = NotesStore();
    _viewModel.getData();
  }

  Future _showDialog(String title, String name, void Function(String) onPressed,
          String buttonName) =>
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  title: Text(title),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(hintText: name),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        final note = nameController.text;
                        onPressed(note);
                        Navigator.pop(context);
                      },
                      child: Text(buttonName),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text(Strings.cancelButton),
                    )
                  ],
                )),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return const Text('data');
        },
      );

  onPressedWrite(String note) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return;
    }
    final noteModel = NoteModel.create(userId: userId, text: note);
    _viewModel.addNote(noteModel);
  }

  List<Widget> _notes(Future Function(NoteModel) onDelete,
          Future Function(NoteModel) onEdit) =>
      [
        Expanded(
          child: ListView.separated(
              itemBuilder: (_, i) {
                final currentNote = _viewModel.value[i];
                return singleNote(currentNote, onDelete, onEdit);
              },
              separatorBuilder: (context, index) => Divider(
                    color: Colors.blueGrey.shade900,
                  ),
              itemCount: _viewModel.value.length),
        ),
      ];
}
