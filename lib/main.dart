import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_saving_app/screens/main_screen.dart';

import 'bloc/note_bloc.dart';
import 'constants/routes.dart';
import 'locator.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   // await
   setupLocator();

  // runApp(const MyApp());
  runApp(
    BlocProvider(
      create: (context) => locator<NoteBloc>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.main,
      routes: routes,
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const MainScreen(),
      ),
    );
  }
}
