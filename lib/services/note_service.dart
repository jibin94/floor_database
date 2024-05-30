
import 'package:floor_database/database/app_database.dart';
import 'package:floor_database/models/note.dart';

class NoteService {
  final AppDatabase database;

  NoteService(this.database);

  Future<List<Note>> getNotes() async {
    return await database.noteDao.findAllNotes();
  }

  Future<void> addNote(Note note) async {
    await database.noteDao.insertNote(note);
  }

  Future<void> updateNote(Note note) async {
    await database.noteDao.updateNote(note);
  }

  Future<void> deleteNote(Note note) async {
    await database.noteDao.deleteNote(note);
  }
}
