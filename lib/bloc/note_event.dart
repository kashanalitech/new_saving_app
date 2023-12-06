// // note_event.dart
// import 'package:equatable/equatable.dart';
// import 'package:new_saving_app/model/note.dart';
//
// abstract class NoteEvent extends Equatable {
//   const NoteEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class LoadNotes extends NoteEvent {}
//
// class AddNote extends NoteEvent {
//   final NoteEntity note;
//
//   const AddNote(this.note);
//
//   @override
//   List<Object?> get props => [note];
// }
//
// class SearchNotes extends NoteEvent {
//   final String query;
//
//   const SearchNotes(this.query);
//
//   @override
//   List<Object?> get props => [query];
// }
// note_event.dart
import 'package:equatable/equatable.dart';
import 'package:new_saving_app/model/note.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final NoteEntity note;

  AddNote(this.note);

  @override
  List<Object?> get props => [note];
}

class SearchNotes extends NoteEvent {
  final String query;

  SearchNotes(this.query);

  @override
  List<Object?> get props => [query];
}

class MoveNoteToTop extends NoteEvent {
  final NoteEntity note;
  final bool isSelected; // Add this property


  const MoveNoteToTop({
    required this.note,
    this.isSelected = true, // Default value assumes the note is selected
  });

  @override
  List<Object?> get props => [note];
}

class DeleteNoteById extends NoteEvent {
  final int noteId;

  DeleteNoteById({required this.noteId});

  @override
  List<Object?> get props => [noteId];
}

class EditNote extends NoteEvent {
  final NoteEntity editedNote;

  EditNote({required this.editedNote});

  @override
  List<Object> get props => [editedNote];
}

// class UpdateNoteTitle extends NoteEvent {
//   final NoteEntity note;
//   final String newTitle;
//
//   UpdateNoteTitle({
//     required this.note,
//     required this.newTitle,
//   });
// }
