import 'package:floor/floor.dart';

@entity
class Note {
  @primaryKey
  final int id;
  final String title;
  final String content;

  Note(this.id, this.title, this.content);
}
