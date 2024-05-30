import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floor_database/dao/note_dao.dart';
import 'package:floor_database/models/note.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

@Database(version: 1, entities: [Note])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
}
