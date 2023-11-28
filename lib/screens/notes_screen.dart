import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_saving_app/constants/custom_text_styles.dart';
import 'package:new_saving_app/constants/helper.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';
import '../components/custom_textfield.dart';
import '../components/grid_view_widget.dart';
import '../components/list_view_widget.dart';
import '../components/note_item.dart';
import '../constants/routes.dart';
import '../model/note.dart';
import 'note_pad.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<NoteEntity> notes = [];
  bool isGridView = false;
  NoteEntity? selectedNote;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final noteBloc = BlocProvider.of<NoteBloc>(context);
    noteBloc.add(LoadNotes());
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // List<String> noteMonths = getNoteMonths(notes);
    List<String> noteMonths = getNoteMonths(notes);
    final noteBloc = BlocProvider.of<NoteBloc>(context);

    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NoteLoaded) {
        notes = state.notes;
        noteMonths = getNoteMonths(notes);
        // for (NoteEntity note in notes) {
        //   print('ID: ${note.id}');
        //   print('Title: ${note.title}');
        //   print('Date: ${note.date}');
        //   print('Content: ${note.content}');
        //   print('Is Flagged: ${note.isFlagged}');
        //   print('-----------------------');
        // }
        // if (searchController.text.isNotEmpty) {
        //   notes = allNotes
        //       .where((note) =>
        //           note.title
        //               .toLowerCase()
        //               .contains(searchController.text.toLowerCase()) ||
        //           note.content
        //               .toLowerCase()
        //               .contains(searchController.text.toLowerCase()))
        //       .toList();
        // } else {
        //   notes = allNotes;
        // }

        // noteMonths = getNoteMonths(notes);
      } else if (state is NoteError) {
        print("Error: ${state.message}");
      }
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Notes',
            style: CustomTextStyle.largeBlack(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: customField(
                        controller: searchController,
                        onChanged: (query) {
                          noteBloc.add(SearchNotes(query));
                        },
                        icon: const Icon(
                          color: Colors.grey,
                          Icons.manage_search_rounded,
                          size: 40,
                        ),
                        align: TextAlign.center,
                        text: 'Search Notes',
                      ),
                    ),
                    IconButton(
                      alignment: Alignment.center,
                      onPressed: () {
                        setState(() {
                          isGridView = !isGridView;
                        });
                      },
                      icon: Icon(
                        isGridView ? Icons.list_rounded : Icons.grid_view,
                        color: Colors.grey,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () async {
                    // Navigate to NotepadWidget and wait for result
                    final newNote = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotepadWidget(),
                      ),
                    );

                    // Check if the result is not null (i.e., a note was added)
                    if (newNote != null) {
                      noteBloc.add(AddNote(newNote));
                    }
                  },
                  icon: const Icon(
                    Icons.note_add,
                    color: Colors.grey,
                    size: 45,
                  ),
                  label: Text(
                    'Create New',
                    style: CustomTextStyle.largegrey(context),
                  ),
                ),
                const SizedBox(height: 5),
                // if (latestMonth.isNotEmpty)
                // Column(
                //   children: noteMonths.map((month) {
                //     return
                // Row(
                //   children: [
                //     const Icon(
                //       Icons.calendar_month,
                //       color: Colors.grey,
                //       size: 45,
                //     ),
                //     const SizedBox(width: 10),
                //     Text(
                //       latestMonth,
                //       style: CustomTextStyle.largeBlack(context),
                //     ),
                //   ],
                // ),
                // }).toList(),
                // ),
                const SizedBox(height: 10),
                Expanded(
                  child: isGridView
                      ? gridList(noteMonths)
                      : ListView.builder(
                          itemCount: noteMonths.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return const SizedBox(); // Placeholder for latest month
                            }

                            final month = noteMonths[index - 1];
                            final monthNotes = getNotesForMonth(month);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        color: Colors.grey,
                                        size: 45,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        month,
                                        style:
                                            CustomTextStyle.largeBlack(context),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListViewWidget( notes: monthNotes),
                              ],
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }


  Widget gridList(List<String> noteMonths) {
    return ListView.builder(
      itemCount: noteMonths.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(); // Placeholder for latest month
        }

        final month = noteMonths[index - 1];
        final monthNotes = getNotesForMonth(month);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.grey,
                  size: 45,
                ),
                const SizedBox(width: 10),
                Text(
                  month,
                  style: CustomTextStyle.largeBlack(context),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
                // height:400,
                color: Colors.transparent,
                child: GridViewWidget(
                  notes: monthNotes,
                )),
          ],
        );
      },
    );
  }

  List<NoteEntity> searchNotes(String query) {
    return notes
        .where((note) =>
            note.title.toLowerCase().contains(query.toLowerCase()) ||
            note.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Function to determine the latest month with notes
  List<String> getNoteMonths(List<NoteEntity> notes) {
    Set<String> uniqueMonths = {};
    for (var note in notes) {
      String month = DateFormat('MMMM yyyy').format(note.date);
      uniqueMonths.add(month);
    }
    List<String> sortedMonths = uniqueMonths.toList()..sort();
    return sortedMonths;
  }

  String getLatestMonth(List<NoteEntity> notes) {
    if (notes.isEmpty) {
      return '';
    }

    // Sort notes in ascending order by date
    notes.sort((a, b) => a.date.compareTo(b.date));

    // Format the latest note's date to get the month
    String latestMonth = DateFormat('MMMM yyyy').format(notes.last.date);

    return latestMonth;
  }

  List<NoteEntity> getNotesForMonth(String month) {
    return notes
        .where((note) => DateFormat('MMMM yyyy').format(note.date) == month)
        .toList();
  }
}
