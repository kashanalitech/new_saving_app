// note_database.dart
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../model/note.dart';
import 'note_dao.dart';

part 'note_database.g.dart';

@Database(
  version: 2,
  entities: [NoteEntity],
)
abstract class NoteDatabase extends FloorDatabase {
  NoteDao get noteDao;

  // static  migration1to2 = Migration(1, 2, (database) async {
  //   await database.execute('ALTER TABLE NoteEntity ADD COLUMN position INTEGER');
  // });
}
