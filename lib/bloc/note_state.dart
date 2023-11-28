// note_state.dart
import 'package:equatable/equatable.dart';
import 'package:new_saving_app/model/note.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<NoteEntity> notes;

  const NoteLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}

class NoteError extends NoteState {
  final String message;

  const NoteError({required this.message});

  @override
  List<Object> get props => [message];
}
