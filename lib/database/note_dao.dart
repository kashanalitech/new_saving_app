// note_dao.dart

import 'package:floor/floor.dart';

import '../model/note.dart';

@dao
abstract class NoteDao {
  // @Query('SELECT * FROM NoteEntity')
  @Query('SELECT * FROM NoteEntity ORDER BY position DESC')
  Future<List<NoteEntity>> getNotes();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveNote(NoteEntity note);

  // @Query('UPDATE NoteEntity SET title = :newTitle WHERE id = :noteId')
  // Future<void> updateNoteTitle(int noteId, String newTitle);

  @Query('DELETE FROM NoteEntity WHERE id = :noteId')
  Future<void> deleteNoteById(int noteId);
  //
  // @Query('UPDATE NoteEntity SET isFlagged = :isFlagged WHERE id = :noteId')
  // Future<void> updateFlagStatus(int noteId, bool isFlagged);
  //
  // @Query('UPDATE NoteEntity SET position = :position WHERE id = :noteId')
  // Future<void> updateNotePosition(int noteId, int position);
  //
  // @update
  // Future<void> updateNote(NoteEntity note);
}



  // @delete
  // Future<void> deleteNote(NoteEntity note);

// }
