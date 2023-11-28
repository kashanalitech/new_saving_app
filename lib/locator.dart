// setup_locator.dart

import 'package:get_it/get_it.dart';
import 'package:new_saving_app/bloc/note_bloc.dart';

import 'database/note_database.dart';
import 'note_repository.dart';


final locator = GetIt.instance;

 void setupLocator() async {
  final locator = GetIt.instance;
  final noteDatabase = await $FloorNoteDatabase.databaseBuilder('note_database.db').build();
  locator.registerSingleton<NoteDatabase>(noteDatabase);

  // final noteRepository = NoteRepository(noteDatabase: locator<NoteDatabase>());
  // locator.registerSingleton<NoteRepository>(noteRepository);
  locator.registerLazySingleton(() => NoteRepository( noteDatabase: locator<NoteDatabase>()));

  locator.registerLazySingleton(() => NoteBloc(noteRepository: locator<NoteRepository>()));


}
