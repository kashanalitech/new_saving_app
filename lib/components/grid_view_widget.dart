import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_saving_app/bloc/note_event.dart';
import 'package:new_saving_app/constants/helper.dart';
import '../bloc/note_bloc.dart';
import '../constants/custom_text_styles.dart';
import '../model/note.dart';
import 'list_view_widget.dart';
import 'note_item.dart'; // Import the NoteItem widget

class GridViewWidget extends StatelessWidget {
  final List<NoteEntity> notes;

  GridViewWidget({
    required this.notes,
    // required this.onNoteSelected,
  });

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NoteBloc>(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // mainAxisSpacing: 2,
        crossAxisCount: 3,
        childAspectRatio: 0.5,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        String convertedContent = convertJsonToString(note);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    note.title,
                    style: CustomTextStyle.mediumBlack(context),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(DateFormat('yyyy-MM-dd').format(note.date)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: Helper.getHeight(context) * 0.19,
                // Adjust the height as needed
                width: Helper.getWidth(context) * 0.25,
                padding: const EdgeInsets.only(bottom: 5),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        convertedContent,
                        // note.content,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.smallBlack(context),
                        // style: const TextStyle(fontSize: 13.0),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // onNoteSelected(note);
                              // BlocProvider.of<NoteBloc>(context).add(MoveNoteToTop(note: note));
                              noteBloc.add(MoveNoteToTop(note: note));
                              // BlocProvider.of<NoteBloc>(context).add(ToggleFlagStatus(note: note));
                            },
                            child: Icon(
                              Icons.flag_circle_rounded,
                              size: 35,
                              color: note.isFlagged == 1
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                          PopupIcon(note: note, noteBloc: noteBloc),
                          // GestureDetector(
                          //   onTap: (){
                          //     // showEditDialog(context,note);
                          //   },
                          //   child: const Icon(
                          //     Icons.edit_note,
                          //     size: 35,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
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
