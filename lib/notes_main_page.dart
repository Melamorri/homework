import 'package:database/primarySwatch.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'note.dart';
import 'notes_repository.dart';

class NotesMainPage extends StatefulWidget {
  const NotesMainPage({Key? key}) : super(key: key);

  @override
  State<NotesMainPage> createState() => _NotesMainPageState();
}

class _NotesMainPageState extends State<NotesMainPage> {
  final _notesRepo = NotesRepository();
  late var _notes = <Note>[];

  @override
  void initState() {
    super.initState();
    _notesRepo.initDB().whenComplete(() {
      setState(() {
        _notes = _notesRepo.getNotes();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: ListView.separated(
        itemCount: _notes.length,
        itemBuilder: (_, i) => ListTile(
            title: Text(
              _notes[i].name,
            ),
            subtitle: Text(
              _notes[i].description,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    onPressed: () {
                        _showUpdateDialog(_notes[i]);
                    },
                    icon: Icon(Icons.edit, color: primarySwatchColorAccent,)),
                IconButton(
                    icon: Icon(Icons.delete, color: primarySwatchColorAccent,),
                    onPressed: () {
                      _notesRepo.deleteNote(_notes[i]);
                      setState(() {
                        _notes = _notesRepo.getNotes();
                      });
                    })
              ],
            )), separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 1.0, color: Colors.black,);
      },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primarySwatchColor,
        onPressed: () => _showDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future _showDialog() => showGeneralDialog(
        context: context,
        barrierDismissible: false,
        pageBuilder: (_, __, ___) {
          final nameController = TextEditingController();
          final descController = TextEditingController();
          return AlertDialog(
            title: const Text('New note'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await _notesRepo.addNote(
                    Note(
                      name: nameController.text,
                      description: descController.text,
                    ),
                  );
                  setState(() {
                    _notes = _notesRepo.getNotes();
                    Navigator.pop(context);
                  });
                },
                child: const Text('Add'),
              )
            ],
          );
        },
      );
  Future _showUpdateDialog(Note note) => showGeneralDialog(
        context: context,
        barrierDismissible: false,
        pageBuilder: (_, __, ___) {
          final nameController = TextEditingController();
          final descController = TextEditingController();
          return AlertDialog(
            title: const Text('Edit note'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                    final newNote = Note(name: nameController.text, description: descController.text);
                    _notesRepo.updateNote(note, newNote);
                  setState(() {
                    _notes = _notesRepo.getNotes();
                    Navigator.pop(context);
                  });
                },
                child: const Text('Edit'),
              )
            ],
          );
        },
      );
}
