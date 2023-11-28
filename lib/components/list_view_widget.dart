import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../constants/custom_text_styles.dart';
import '../constants/helper.dart';
import '../model/note.dart';

class ListViewWidget extends StatelessWidget {
  final List<NoteEntity> notes;

  ListViewWidget({
    required this.notes,
    // required this.onNoteSelected,
  });
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
          horizontal: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: notes.length,
      separatorBuilder: (context, index) =>
      const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final note = notes[index];
        return Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 4,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          DateFormat('MM-dd-yyyy')
                              .format(note.date),
                          style: CustomTextStyle
                              .mediumGrey(context),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            note.title,
                            style: CustomTextStyle
                                .mediumBlack(
                                context),
                          ),
                        ),
                        // const SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: (){
                            showEditDialog(context,note);
                          },
                          child: const Icon(
                            Icons.edit_note,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment .spaceBetween,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(right: 6),
                              child: SizedBox(
                                width:
                                Helper.getWidth(context) / 1.7,
                                child: Text(
                                  note.content,
                                  overflow:
                                  TextOverflow
                                      .ellipsis,
                                  maxLines: 1,
                                  // softWrap: false,
                                  style: CustomTextStyle
                                      .smallBlack(
                                      context),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<NoteBloc>(context).add(MoveNoteToTop(note: note));
                                // BlocProvider.of<NoteBloc>(context).add(ToggleFlagStatus(note: note));
                              },
                              child: Icon(
                                Icons
                                    .flag_circle_rounded,
                                size: 40,
                                color: note.isFlagged
                                    ? Colors.black
                                    : Colors.grey,
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
}
void showEditDialog(BuildContext context, NoteEntity note) {
  TextEditingController titleController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'New Title'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Perform the update logic here
                    String newTitle = titleController.text.trim();
                    if (newTitle.isNotEmpty) {
                      // Update the note title
                      // note.title = newTitle;

                      // Add your logic to update the note in the Bloc or repository
                      BlocProvider.of<NoteBloc>(context).add(UpdateNoteTitle(note: note, newTitle: newTitle));

                      Navigator.pop(context); // Close the dialog
                    } else {
                      // Show an error message or handle accordingly
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}