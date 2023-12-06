import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_saving_app/screens/note_pad.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../constants/custom_text_styles.dart';
import '../constants/helper.dart';
import '../model/note.dart';

class ListViewWidget extends StatelessWidget {
  final List<NoteEntity> notes;

  ListViewWidget({
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    // final json = jsonDecode(r'{"insert":"hello\n"}');
    final noteBloc = BlocProvider.of<NoteBloc>(context);

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: notes.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final note = notes[index];
        String convertedContent = convertJsonToString(note);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 4,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          DateFormat('MM-dd-yyyy').format(note.date),
                          style: CustomTextStyle.mediumGrey(context),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            note.title,
                            style: CustomTextStyle.mediumBlack(context),
                          ),
                        ),
                        PopupIcon(note: note, noteBloc: noteBloc),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: SizedBox(
                                width: Helper.getWidth(context) / 1.7,
                                child: Text(
                                  convertedContent,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: CustomTextStyle.smallBlack(context),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                noteBloc.add(MoveNoteToTop(note: note));
                              },
                              child: Icon(
                                Icons.flag_circle_rounded,
                                size: 40,
                                color: note.isFlagged == 1 ? Colors.black : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String convertJsonToString(NoteEntity note) {
     List<dynamic> parsedJson = jsonDecode(note.content);
    String resultString = '';

    for (var item in parsedJson) {
      if (item.containsKey('insert')) {
        resultString += item['insert'];
      }
    }
    return resultString;
  }
}

class PopupIcon extends StatelessWidget {
  const PopupIcon({
    super.key,
    required this.note,
    required this.noteBloc,
  });

  final NoteEntity note;
  final NoteBloc noteBloc;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        // Handle the selected option
        if (value == 'edit') {
          navigateToNotePadScreen(context,note);
          // showEditDialog(context, note);
        } else if (value == 'delete') {
          noteBloc.add(DeleteNoteById(noteId: note.id!));
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit_note),
              SizedBox(width: 8),
              Text('Edit title'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete),
              SizedBox(width: 8),
              Text('Delete Note'),
            ],
          ),
        ),
      ],
    );
  }
}

void showEditDialog(BuildContext context, NoteEntity note) {
  TextEditingController titleController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'New Title',
                  labelStyle: TextStyle(
                    color: Colors.black, // Change the color to your desired color
                  ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Change the color to your desired color
                ),
              ),
              cursorColor: Colors.black, // Change the cursor color
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Change the background color to white
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child:  Text('Cancel',style: CustomTextStyle.mediumBlack(context),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Change the background color to white
                  ),
                  onPressed: () {
                    // Perform the update logic here
                    // String newTitle = titleController.text.trim();
                    // if (newTitle.isNotEmpty) {
                    //   BlocProvider.of<NoteBloc>(context).add(UpdateNoteTitle(note: note, newTitle: newTitle));
                    //
                    //   Navigator.pop(context); // Close the dialog
                    // } else {
                    //   // Show an error message or handle accordingly
                    // }
                  },
                  child:  Text('Update',style: CustomTextStyle.mediumBlack(context),),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void navigateToNotePadScreen(BuildContext context, NoteEntity note) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NotepadWidget(note: note),
    ),
  );
}


