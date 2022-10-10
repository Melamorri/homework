class NoteModel {
  final String? userId;
  final String text;
  final String id;

  NoteModel({
    required this.userId,
    required this.text,
    required this.id,
  });

  NoteModel.create({
    this.id = '',
    required this.userId,
    required this.text,
  });
}