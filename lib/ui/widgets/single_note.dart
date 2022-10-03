import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../domain/model/note_model.dart';

Widget singleNote(NoteModel currentNote, Future Function(NoteModel) onDelete,
    Future Function(NoteModel) onEdit) {
  return ListTile(
      title: Text(currentNote.text),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              onPressed: () => onEdit(currentNote),
              icon: const Icon(Icons.edit)),
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onDelete(currentNote))
        ],
      ));
}
