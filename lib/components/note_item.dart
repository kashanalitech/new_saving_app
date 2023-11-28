// // note_item.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:new_saving_app/constants/helper.dart';
// import '../bloc/note_bloc.dart';
// import '../bloc/note_event.dart';
// import '../constants/custom_text_styles.dart';
// import '../model/note.dart';
//
// class NoteItem extends StatefulWidget {
//   final String title;
//   final DateTime date;
//   final String content;
//   // final NoteEntity note;
//   // final Function(NoteEntity)? onSelected;
//
//
//
//   NoteItem({
//     required this.title,
//     required this.date,
//     required this.content,
//     // required this.note,
//     // required this.onSelected,
//   });
//
//   @override
//   State<NoteItem> createState() => _NoteItemState();
// }
//
// bool isSelected = false;
//
// class _NoteItemState extends State<NoteItem> {
//   @override
//   Widget build(BuildContext context) {
//     final noteBloc = BlocProvider.of<NoteBloc>(context);
//     return Padding(
//       padding: EdgeInsets.only(bottom: 10),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               spreadRadius: 1,
//               blurRadius: 4,
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   DateFormat('MM-dd-yyyy').format(widget.date),
//                   style: CustomTextStyle.mediumGrey(context),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: Text(
//                     widget.title,
//                     style: CustomTextStyle.mediumBlack(context),
//                   ),
//                 ),
//                 // const SizedBox(width: 8.0),
//                 const Icon(
//                   Icons.edit_note,
//                   size: 40,
//                   color: Colors.grey,
//                 ),
//               ],
//             ),
//             // const SizedBox(height: 8.0),
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 6),
//                       child: SizedBox(
//                         width: Helper.getWidth(context) /1.7,
//                         child: Text(
//                           widget.content,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                           // softWrap: false,
//                           style: CustomTextStyle.smallBlack(context),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: (){
//                         BlocProvider.of<NoteBloc>(context).add(MoveNoteToTop(note: noteEntity));
//                         // BlocProvider.of<NoteBloc>(context).add(ToggleFlagStatus(note: note));
//                         // setState(() {
//                         //   isSelected = !isSelected;
//                         // });
//                         // widget.onSelected!(NoteEntity(
//                         //   title: widget.title,
//                         //   date: widget.date,
//                         //   content: widget.content,
//                         // ));
//                         // widget.onSelected(this, isSelected);
//                       },
//                       child:  Icon(
//                         Icons.flag_circle_rounded,
//                         size: 40,
//                         color: isSelected ? Colors.black : Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
