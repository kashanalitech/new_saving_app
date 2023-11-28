import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:new_saving_app/bloc/note_bloc.dart';
import 'package:new_saving_app/database/note_database.dart';
import 'package:new_saving_app/note_repository.dart';
import 'package:uuid/uuid.dart';

import '../bloc/note_event.dart';
import '../bloc/note_state.dart';
import '../components/custom_textfield.dart';
import '../constants/custom_text_styles.dart';
import '../constants/helper.dart';
import '../model/note.dart';

class NotepadWidget extends StatefulWidget {
  @override
  _NotepadWidgetState createState() => _NotepadWidgetState();
}

class _NotepadWidgetState extends State<NotepadWidget> {
  final QuillController _controller = QuillController.basic();
  final TextEditingController titleController = TextEditingController();
  List<NoteEntity> notes = [];
  late final QuillController controller;
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  bool _isStrikethrough = false;
  bool isBulletSelected = false;
  bool isNumberSelected = false;
  bool isCheckSelected = false;
  Color _selectedTextColor = Colors.black;
  bool _isJustify = false;
  bool _isLeft = false;
  bool _isRight = false;
  bool _isCenter = false;
  bool isUndoSelected = false;
  bool isRedoSelected = false;
  bool isCaseUpper = false; // Add this variable for case toggling
  Future<Color?> showColorPickerDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Text Color'),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: <Widget>[
                for (Color color in [
                  Colors.black,
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.purple,
                  Colors.yellowAccent,
                  Colors.orange,
                ])
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context,
                          color); // Close the dialog with the selected color
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      color: color,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addData(List<NoteEntity> notes, BuildContext context) {
    String title = titleController.text.toString();
    String content = _controller.document.toPlainText();
    DateTime date = DateTime.now();
    // final nextId = notes.isNotEmpty ? notes.map((note) => note.id).reduce(max) + 1 : 1;

    // Create a new NoteEntity instance without specifying the id
    NoteEntity newNote = NoteEntity(
      // id: nextId,
      title: title,
      date: date,
      content: content,
    );
    // print(Nextid);

    // Add the new note to the list
    // notes.add(newNote);


    // Access the NoteBloc
    final noteBloc = BlocProvider.of<NoteBloc>(context);

    // Add the new note to the bloc
    noteBloc.add(AddNote(newNote));

        Navigator.pop(context);


    // Return the new id (not needed anymore, you can remove this line)
    // return newId;
  }


  // int addData(
  // // final id = notes.isNotEmpty ? notes.map((note) => note.id).reduce(max) + 1 : 1;
  // String title,
  // // titleController.text.toString(); // Replace this with the actual title
  // String content,
  // // _controller.document.toPlainText(); // Get the content from Quill
  // DateTime date ,
  // ) {
  //   NoteEntity newNote = NoteEntity(
  //     title: title,
  //     content: content,
  //     date: date,
  //   );
  //   final noteBloc = BlocProvider.of<NoteBloc>(context);
  //   return noteRepository.saveNote(newNote);
  //
  //   // Add the new note to the list
  // // return  notes.add(newNote);
  //
  //   // You can also clear the Quill editor after saving if needed
  //   // _controller.document.clear();
  //   // return ;
  // }

  void toggleBulletPoints() {
    setState(() {
      isNumberSelected = false;
      // isBulletSelected = true;
      isCheckSelected = false;
      isBulletSelected = !isBulletSelected;
      if (isBulletSelected) {
        // _controller.formatSelection(Attribute.clone(Attribute.ul, false));
        _controller.formatSelection(Attribute.ul);
        // isBulletSelected = false; // Deselect the number format
      } else {
        _controller.formatSelection(Attribute.clone(Attribute.ul, null));
        // _controller.formatSelection(Attribute.ul);
      }
    });
  }

  void toggleNumber() {
    setState(() {
      // isNumberSelected = true;
      isBulletSelected = false;
      isCheckSelected = false;
      isNumberSelected = !isNumberSelected;
      // final style = _controller.getSelectionStyle();
      // final isBullet = style.attributes.containsKey(Attribute.ul.key);
      if (isNumberSelected) {
        // _controller.formatSelection(Attribute.clone(Attribute.ul, false));
        _controller.formatSelection(Attribute.ol);
        // isNumberSelected = false; // Deselect the number format
      } else {
        _controller.formatSelection(Attribute.clone(Attribute.ol, null));
        // _controller.formatSelection(Attribute.ul);
      }
    });
  }

  void toggleCheck() {
    setState(() {
      isNumberSelected = false;
      isBulletSelected = false;
      // isCheckSelected = true;
      isCheckSelected = !isCheckSelected;
      // final style = _controller.getSelectionStyle();
      // final isBullet = style.attributes.containsKey(Attribute.ul.key);
      if (isCheckSelected) {
        // _controller.formatSelection(Attribute.clone(Attribute.ul, false));
        _controller.formatSelection(Attribute.checked);
      } else {
        _controller.formatSelection(Attribute.clone(Attribute.checked, null));
        // _controller.formatSelection(Attribute.ul);
      }
    });
  }

  void toggleBold() {
    setState(() {
      _isBold = !_isBold;
      if (_isBold) {
        _controller.formatSelection(Attribute.bold);
      } else {
        _controller.formatSelection(Attribute.clone(Attribute.bold, null));
      }
    });
  }

  void toggleIsItalic() {
    setState(() {
      _isItalic = !_isItalic;
      if (_isBold) {
        _controller.formatSelection(Attribute.italic);
      } else {
        _controller.formatSelection(Attribute.clone(Attribute.italic, null));
      }
    });
  }

  void toggleUnderline() {
    setState(() {
      _isUnderline = !_isUnderline;
      if (_isBold) {
        _controller.formatSelection(Attribute.underline);
      } else {
        _controller.formatSelection(Attribute.clone(Attribute.underline, null));
      }
    });
  }

  void toggleStrikeThrough() {
    setState(() {
      _isStrikethrough = !_isStrikethrough;
      if (_isStrikethrough) {
        _controller.formatSelection(Attribute.strikeThrough);
      } else {
        _controller
            .formatSelection(Attribute.clone(Attribute.strikeThrough, null));
      }
    });
  }

  void changeTextColor(Color color) {
    setState(() {
      _selectedTextColor = color;
    });
  }

  void toggleUndo() {
    setState(() {
      isUndoSelected = !isUndoSelected;
      if (isUndoSelected) {
        // Perform the undo action
        _controller.undo();
      }
    });
  }

  void toggleRedo() {
    setState(() {
      isRedoSelected = !isRedoSelected;
      if (isRedoSelected) {
        // Perform the redo action
        _controller.redo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
        // stream: null,
        builder: (context, snapshot) {
      return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              child: Column(
                children: [
                  customField(
                    controller: titleController,
                    text: 'Title',
                  ),
                  QuillProvider(
                    configurations: QuillConfigurations(
                      controller: _controller,
                      sharedConfigurations: const QuillSharedConfigurations(),
                    ),
                    child: Container(
                      height: Helper.getHeight(context) * .65,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  buildCustomIcon(
                                    icon: Icons.check,
                                    // onTap: toggleCheck,
                                    onTap: () {
                                      toggleCheck();
                                      // _controller.formatSelection(Attribute.checked);
                                    },
                                    color: isCheckSelected
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                  buildCustomIcon(
                                    icon: Icons.format_list_bulleted,
                                    onTap: () {
                                      toggleBulletPoints();
                                      //   _controller.formatSelection(Attribute.ul);
                                    },
                                    color: isBulletSelected
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                  buildCustomIcon(
                                    icon: Icons.format_list_numbered,
                                    onTap: () {
                                      toggleNumber();
                                      //   _controller.formatSelection(Attribute.ol);
                                    },
                                    color: isNumberSelected
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                  buildCustomIcon(
                                    icon: Icons.format_color_text,
                                    onTap: () async {
                                      setState(() async {
                                        Color? selectedColor =
                                            await showColorPickerDialog(
                                                context);
                                        if (selectedColor != null) {
                                          changeTextColor(selectedColor);
                                          _controller
                                              .formatSelection(Attribute.color);
                                        }
                                      });
                                    },
                                    color: _controller
                                            .getSelectionStyle()
                                            .attributes
                                            .containsKey(Attribute.color.key)
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                  buildCustomIcon(
                                    icon: Icons.format_size,
                                    onTap: () {
                                      // toggleCase();
                                    },
                                    // onTap: (){
                                    //   _controller.formatSelection(Attribute.size);
                                    // },
                                    color: isCaseUpper
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  buildCustomIcon(
                                    icon: Icons.format_align_justify,
                                    onTap: () {
                                      setState(() {
                                        _isJustify = !_isJustify;
                                        _controller.formatSelection(
                                            Attribute.justifyAlignment);
                                      });
                                    },
                                    color:
                                        _isJustify ? Colors.black : Colors.grey,
                                  ),
                                  buildCustomIcon(
                                    icon: Icons.format_align_left,
                                    onTap: () {
                                      // _isLeft = !_isLeft;
                                      _isLeft = true;
                                      _isCenter = false;
                                      _isRight = false;
                                      // _controller.formatSelection(Attribute.leftAlignment);
                                      setState(() {
                                        _controller.formatSelection(
                                            Attribute.leftAlignment);
                                      });
                                    },
                                    color: _isLeft ? Colors.black : Colors.grey,
                                  ),
                                  buildCustomIcon(
                                    icon: Icons.format_align_center,
                                    onTap: () {
                                      setState(() {
                                        _isLeft = false;
                                        _isCenter = true;
                                        _isRight = false;
                                        // _isCenter = !_isCenter;
                                        _controller.formatSelection(
                                            Attribute.centerAlignment);
                                      });
                                    },
                                    color:
                                        _isCenter ? Colors.black : Colors.grey,
                                  ),
                                  buildCustomIcon(
                                    icon: Icons.format_align_right,
                                    onTap: () {
                                      setState(() {
                                        // _isRight = !_isRight;
                                        _isLeft = false;
                                        _isCenter = false;
                                        _isRight = true;
                                        _controller.formatSelection(
                                            Attribute.rightAlignment);
                                      });
                                    },
                                    color:
                                        _isRight ? Colors.black : Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  buildCustomIcon(
                                    icon: Icons.format_bold,
                                    onTap: () {
                                      toggleBold();
                                    },
                                    color: _isBold ? Colors.black : Colors.grey,
                                  ),
                                  buildCustomIcon(
                                    icon: Icons.format_italic,
                                    onTap: () {
                                      setState(() {
                                        // _controller.formatSelection(Attribute.italic);
                                        toggleIsItalic();
                                      });
                                    },
                                    color:
                                        _isItalic ? Colors.black : Colors.grey,
                                  ),
                                  buildCustomIcon(
                                    icon: Icons.format_underlined,
                                    onTap: () {
                                      setState(() {
                                        // _controller.formatSelection(Attribute.underline);
                                        toggleUnderline();
                                      });
                                    },
                                    color: _isUnderline
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                  buildCustomIcon(
                                    icon: Icons.strikethrough_s,
                                    onTap: () {
                                      setState(() {
                                        // _controller.formatSelection(Attribute.strikeThrough);
                                        toggleStrikeThrough();
                                      });
                                    },
                                    color: _isStrikethrough
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  buildCustomIcon(
                                    icon: Icons.undo,
                                    onTap: toggleUndo,
                                    color: isUndoSelected
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                  buildCustomIcon(
                                    icon: Icons.redo,
                                    onTap: toggleRedo,
                                    color: isRedoSelected
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(thickness: 2, color: Colors.black54),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: Helper.getHeight(context) * 0.4,
                            child: QuillEditor(
                              // controller: _controller,
                              scrollController: ScrollController(),
                              configurations: const QuillEditorConfigurations(
                                readOnly: false,
                              ),
                              focusNode: FocusNode(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(15)),
                  GestureDetector(
                    onTap: () async {
                      // int maxId = notes.isNotEmpty ? notes.map((note) => note.id).reduce(max) : 0;
                      // int newId = maxId + 1;
                      // addData(notes,context);
                      // var id = addData(titleController.text, _controller.document.toPlainText(), DateTime.now());

                      // final newId = notes.isNotEmpty ? notes.map((note) => note.id).reduce(max) + 1 : 1;
                      // Save the note using the BLoC
                        if (titleController.text.isNotEmpty) {
                          NoteEntity newNote = NoteEntity(
                            // id: newId,
                            title: titleController.text,
                            date: DateTime.now(),
                            content: _controller.document.toPlainText(),
                          );

                          // Access the NoteBloc
                          final noteBloc = BlocProvider.of<NoteBloc>(context);

                          // Add the new note to the bloc
                          noteBloc.add(AddNote(newNote));

                          // Navigate back to the previous screen
                          Navigator.pop(context);
                        }
                    },
                    child: Text('Saved',
                        style: CustomTextStyle.largegrey(context)),
                  ),
                  Text('23-10.03', style: CustomTextStyle.largegrey(context)),
                  Text('5"54pm', style: CustomTextStyle.mediumGrey(context)),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildCustomIcon({
    required IconData icon,
    required Function() onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Icon(
          icon,
          color: color,
          size: 25,
        ),
      ),
    );
  }
}
