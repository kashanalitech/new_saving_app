// // note_bloc.dart
// import 'package:bloc/bloc.dart';
// import 'package:new_saving_app/bloc/note_event.dart';
// import 'package:new_saving_app/bloc/note_state.dart';
// import 'package:new_saving_app/model/note.dart';
//
// import '../note_repository.dart';
//
// class NoteBloc extends Bloc<NoteEvent, NoteState> {
//   final NoteRepository noteRepository;
//
//   NoteBloc({required this.noteRepository}) : super(NoteInitial());
//
//   @override
//   Stream<NoteState> mapEventToState(NoteEvent event) async* {
//     if (event is LoadNotes) {
//       try {
//         final notes = await noteRepository.getNotes();
//         yield NoteLoaded(notes: notes);
//       } catch (e) {
//         yield NoteError(message: 'Failed to load notes $e');
//       }
//     } else if (event is AddNote) {
//       try {
//         await noteRepository.saveNote(event.note);
//         final updatedNotes = await noteRepository.getNotes();
//         yield NoteLoaded(notes: updatedNotes);
//       } catch (e) {
//         yield NoteError(message: 'Failed to add note $e');
//       }
//     } else if (event is SearchNotes) {
//       try {
//         final query = event.query;
//         final allNotes = await noteRepository.getNotes(); // Assuming this gets all notes
//         final filteredData = allNotes.where((notes) {
//           final propertyToSearch = notes.title.toString();
//           return propertyToSearch.toLowerCase().contains(query.toLowerCase());
//         }).toList();
//         yield NoteLoaded(notes: filteredData);
//       } catch (e) {
//         yield NoteError(message: 'Failed to search notes $e');
//       }
//     }
//   }
// }

// note_bloc.dart
// import 'package:bloc/bloc.dart';
// import 'package:new_saving_app/bloc/note_event.dart';
// import 'package:new_saving_app/bloc/note_state.dart';
//
// import '../note_repository.dart';
//
// class NoteBloc extends Bloc<NoteEvent, NoteState> {
//   final NoteRepository noteRepository;
//
//   NoteBloc({required this.noteRepository}) : super(NoteInitial());
//
//   @override
//   Stream<NoteState> mapEventToState(NoteEvent event) async* {
//     if (event is LoadNotes) {
//       try {
//         final notes = await noteRepository.getNotes();
//         yield NoteLoaded(notes: notes);
//       } catch (e) {
//         yield NoteError(message: 'Failed to load notes.');
//       }
//     } else if (event is AddNote) {
//       try {
//         await noteRepository.saveNote(event.note);
//         final updatedNotes = await noteRepository.getNotes();
//         yield NoteLoaded(notes: updatedNotes);
//       } catch (e) {
//         yield NoteError(message: 'Failed to add note.');
//       }
//     } else if (event is SearchNotes) {
//       try {
//         final query = event.query;
//         final searchResults = await noteRepository.searchNotes(event.query);
//         yield NoteLoaded(notes: searchResults);
//       } catch (e) {
//         yield NoteError(message: 'Failed to search notes.');
//       }
//     }
//   }
// }

// note_bloc.dart
// note_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:new_saving_app/bloc/note_event.dart';
import 'package:new_saving_app/bloc/note_state.dart';
import 'package:new_saving_app/note_repository.dart';
import 'package:new_saving_app/model/note.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;

  NoteBloc({required this.noteRepository}) : super(NoteInitial());

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is LoadNotes) {
      // yield NoteLoading();
      try {
        final notes = await noteRepository.getNotes();
        yield NoteLoaded(notes: notes);
      } catch (e) {
        yield NoteError(message: 'Failed to load notes: $e');
      }
    } else if (event is AddNote) {
      try {
        await noteRepository.saveNote(event.note);
        final updatedNotes = await noteRepository.getNotes();
        yield NoteLoaded(notes: updatedNotes);
      } catch (e) {
        yield NoteError(message: 'Failed to add note: $e');
      }
    } else if (event is SearchNotes) {
      try {
        final query = event.query;
        final allNotes = await noteRepository.getNotes();
        final filteredData = allNotes.where((notes) {
          final propertyToSearch = notes.title.toString();
          return propertyToSearch.toLowerCase().contains(query.toLowerCase());
        }).toList();
        yield NoteLoaded(notes: filteredData);
      } catch (e) {
        yield NoteError(message: 'Failed to search notes: $e');
      }
    // }
    // else if (event is ToggleFlagStatus) {
    //   final notes = await noteRepository.getNotes();
    //   // Toggle the flag status for the note
    //   final updatedNotes = NoteLoaded(notes: notes).notes.map((note) {
    //     if (note.id == event.note.id) {
    //       return NoteEntity(
    //         id: note.id,
    //         title: note.title,
    //         date: note.date,
    //         content: note.content,
    //         isFlagged: !note.isFlagged,
    //       );
    //     } else {
    //       return note;
    //     }
    //   }).toList();
    //   yield NoteLoaded(notes: updatedNotes);
    } else if (event is MoveNoteToTop) {
      try {
        final notes = await noteRepository.getNotes();
        final List<NoteEntity> updatedNotes = List.from(notes);

        // Find the index of the selected note
        final index = updatedNotes.indexWhere((note) => note.id == event.note.id);

        if (index != -1) {
          // Move the note to the top
          final movedNote = updatedNotes.removeAt(index);
          movedNote.isFlagged = !movedNote.isFlagged;
          movedNote.position = DateTime.now().millisecondsSinceEpoch;
          updatedNotes.insert(0, movedNote);
        }
        // Sort the notes based on position in descending order
        updatedNotes.sort((a, b) => b.position!.compareTo(a.position!));

        // Update the position for all notes and save them
        // for (final updatedNote in updatedNotes) {
          await noteRepository.saveNotes(updatedNotes);
        // }


        yield NoteLoaded(notes: updatedNotes);
        // await noteRepository.saveNotes(updatedNotes);
      } catch(e){
        yield NoteError(message: 'Failed to move note to top: $e');
      }

    } else if (event is UpdateNoteTitle) {
      if (state is NoteLoaded) {
        final updatedNotes = (state as NoteLoaded).notes.map((note) {
          if (note == event.note) {
            return NoteEntity(
              id: note.id,
              title: event.newTitle, // Update the title
              date: note.date,
              content: note.content,
              isFlagged: note.isFlagged,
            );
          } else {
            return note;
          }
        }).toList();
        yield NoteLoaded(notes: updatedNotes);

        await noteRepository.updateNoteTitle(event.note.id, event.newTitle);

      }
    }
  }
}


