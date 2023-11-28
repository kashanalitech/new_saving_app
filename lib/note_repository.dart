// note_repository.dart

import 'database/note_database.dart';
import 'model/note.dart';

class NoteRepository {
  final NoteDatabase noteDatabase;

  NoteRepository({required this.noteDatabase});

  Future<void> saveNote(NoteEntity note) async {
    await noteDatabase.noteDao.saveNote(note);
  }

  Future<void> saveNotes(List<NoteEntity> notes) async {
    // Save a list of notes (if needed)
    for (var note in notes) {
      // await saveNote(note);
      await noteDatabase.noteDao.saveNote(note);
    }
  }

  // Future<List<NoteEntity>> getNotes() async {
  //   return await noteDatabase.noteDao.getNotes();
  // }
  Future<List<NoteEntity>> getNotes() async {
    try {
      final notes = await noteDatabase.noteDao.getNotes();
      return notes ?? []; // Return an empty list if notes is null
    } catch (e) {
      // Handle any errors appropriately
      print('Error fetching notes: $e');
      return [];
    }
  }

  Future<void> updateNoteTitle(int? noteId, String newTitle) async {
    try{
      await noteDatabase.noteDao.updateNoteTitle(noteId!, newTitle);
    }
    catch (e){
      print('not right now: $e');
    }
    }

  Future<void> updateNoteFlagStatus(int? noteId, bool isFlagged) async {
    await noteDatabase.noteDao.updateFlagStatus(noteId!, isFlagged);
  }

  Future<void> updateNotePosition(int? noteId, int position) async {
    await noteDatabase.noteDao.updateNotePosition(noteId!, position);
  }
}
  // Future<void> updateNoteTitle(NoteEntity note) async {
  //   await noteDatabase.noteDao.saveNote(note);
  // }



