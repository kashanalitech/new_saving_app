import 'package:flutter/widgets.dart';
import 'package:new_saving_app/screens/notes_screen.dart';

import '../demo.dart';
import '../screens/home_screen.dart';
import '../screens/note_pad.dart';
import '../screens/main_screen.dart';
import '../screens/register_screen.dart';
import '../screens/setting_screen.dart';


class RouteNames {
  RouteNames._();

  static const String main = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String home = '/home';
  static const String notes = '/notes';
  static const String demo = '/demo';
  static const String setting = '/setting';
}

final routes = <String, WidgetBuilder>{
  RouteNames.main: (_) => const MainScreen(),
  RouteNames.register: (_) => const RegisterScreen(),
  RouteNames.login: (_) =>  NotepadWidget(),
  RouteNames.home: (_) => const HomeScreen(),
  RouteNames.demo: (_) =>    QuillEditorPage(),
  RouteNames.notes: (_) =>     const NotesScreen(),
  RouteNames.setting: (_) =>  const SettingScreen(),
};
