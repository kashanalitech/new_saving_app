// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:saving_app/components/barrel_image.dart';
// import 'package:saving_app/components/custom_button.dart';
// import 'package:saving_app/constants/helper.dart';
// import 'package:saving_app/constants/routes.dart';
// import 'package:saving_app/main.dart';
// import 'package:saving_app/models/model.dart';
// import 'package:saving_app/screens/create_new_sheet_screen.dart';

// import '../components/banner_text.dart';
// import '../constants/custom_text_styles.dart';
// import 'create_new_sheet_screen.dart';

// class NewSheetScreen extends StatefulWidget {
//   const NewSheetScreen({
//     super.key, this.savingSheetId = -1});

//   final int savingSheetId;

//   @override
//   State<NewSheetScreen> createState() => _NewSheetScreenState();
// }

// final amountController = TextEditingController();

// // SavingSheet? savingSheet;

// class _NewSheetScreenState extends State<NewSheetScreen> {
//   getTextInputData(int id) {
//     // average = sum of weeks/ activeWeekOrMonth
//     // Barrel savings = week*noOfWeekMonth + week2*noOfWeekMonth / activeWeekOrMonth
//     var amount = amountController.text;
//     if (amount.isNotEmpty) {
//       objectBox.updateSavingAmount(double.parse(amount), id);
//       setState(() {
//         amountController.clear();
//         // updateAverageSavings(
//         // 0.0,
//         // ModalRoute.of(context)!.settings.arguments as SavingSheet;
//         // (ModalRoute.of(context)?.settings.arguments as SavingSheet)
//         //     .id);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final arguments =
//         ModalRoute.of(context)!.settings.arguments as NewSheetScreen;
//     return StreamBuilder<SavingSheet>(
//         stream: objectBox.getSavingSheet(arguments.savingSheetId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data == null) {
//             return const Text('No data available');
//           } else {
//             var savingSheet = snapshot.data!;

//             return Scaffold(
//               body: SafeArea(
//                 top: Platform.isAndroid ? true : false,
//                 left: false,
//                 right: false,
//                 bottom: false,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             BannerText(
//                                 title: savingSheet.name, paddingbottom: 25),
//                             const Padding(
//                               padding: EdgeInsets.only(bottom: 15),
//                               child: BarrelImage(),
//                             ),
//                             customBox(context, Icons.emoji_flags_rounded,
//                                 savingSheet.barellSaving.toString()),
//                             averageText(context),
//                             averageBox(
//                                 context, savingSheet.averageSaving.toString()),
//                             inputText(context, savingSheet.isWeekly),
//                             enteramountWidget(context, arguments.savingSheetId),
//                           ],
//                         ),
//                       ),
//                       Column(
//                         children: [
//                           const Divider(
//                             height: 15,
//                             color: Colors.grey,
//                             thickness: 2,
//                           ),
//                           CustomButton(
//                               bottompadding: 0,
//                               toppadding: 5,
//                               horizontalpadding: 5,
//                               borderRadius: 12,
//                               title: 'Edit Saving',
//                               ontap: () {
//                                 Navigator.pushNamed(
//                                     context, RouteNames.editmenu);
//                               }),
//                           CustomButton(
//                               bottompadding: 0,
//                               toppadding: 0,
//                               horizontalpadding: 5,
//                               borderRadius: 12,
//                               title: 'Edit Milestones',
//                               ontap: () {
//                                 Navigator.pushNamed(
//                                     context, RouteNames.milestonesmenu);
//                               }),
//                           CustomButton(
//                               toppadding: 0,
//                               horizontalpadding: 5,
//                               borderRadius: 12,
//                               title: 'Settings',
//                               ontap: () {
//                                 Navigator.pushNamed(
//                                     context, RouteNames.settingmenu);
//                               }),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//         });
//   }

//   Widget customBox(BuildContext context, IconData? iconOne, String amount) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15),
//       child: Container(
//         width: Helper.getWidth(context),
//         padding: const EdgeInsets.all(4),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.4),
//               spreadRadius: 1,
//               blurRadius: 4,
//             ),
//           ],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               alignment: Alignment.centerLeft,
//               width: Helper.getWidth(context) * .35,
//               child: IconButton(
//                 alignment: Alignment.center,
//                 onPressed: () {},
//                 icon: Icon(
//                   iconOne,
//                   color: Colors.grey,
//                   size: 35,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: selectedCurrency!.currencySymbol,
//                       style: CustomTextStyle.largeBlack(context),
//                     ),
//                     TextSpan(
//                       text: double.parse(amount).toString(),
//                       style: CustomTextStyle.largeBlack(context),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // IconButton(
//             //   onPressed: () {
//             //     showDialog(
//             //       context: context,
//             //       builder: ((context) {
//             //         return AlertDialog(
//             //           content: const Text(
//             //             "This is your Average Savings. In order to reach the Barrel Savings figure above, you must save according to your average. But you can save more or less.",
//             //             textAlign: TextAlign.start,
//             //           ),
//             //           actions: [
//             //             TextButton(
//             //               child: const Text("Close"),
//             //               onPressed: () {
//             //                 Navigator.of(context).pop();
//             //               },
//             //             ),
//             //           ],
//             //         );
//             //       }),
//             //     );
//             //   },
//             //   icon: Icon(
//             //     iconTwo,
//             //     color: Colors.grey,
//             //     size: 35,
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget averageText(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20),
//       child: Text(
//         'Average Saving:',
//         style: CustomTextStyle.largeBlack(context),
//       ),
//     );
//   }

//   Widget averageBox(BuildContext context, String amount) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15),
//       child: Container(
//         width: Helper.getWidth(context),
//         padding: const EdgeInsets.all(4),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.4),
//               spreadRadius: 1,
//               blurRadius: 4,
//             ),
//           ],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           alignment: Alignment.center,
//           child: RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: selectedCurrency!.currencySymbol,
//                   style: CustomTextStyle.largeBlack(context),
//                 ),
//                 TextSpan(
//                   text: double.parse(amount).toString(),
//                   style: CustomTextStyle.largeBlack(context),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget inputText(BuildContext context, bool? isWeekly) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15, bottom: 20),
//       child: Text(
//         isWeekly! ? 'Input Weekly Savings:' : 'Input Monthly Savings:',
//         style: CustomTextStyle.largeBlack(context),
//       ),
//     );
//   }

//   Widget enteramountWidget(BuildContext context, int id) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15),
//             child: Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.3),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                   ),
//                 ],
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(11),
//               ),
//               child: TextFormField(
//                 controller: amountController,
//                 keyboardType: TextInputType.number,
//                 textAlign: TextAlign.start,
//                 style: CustomTextStyle.largeBlack(context),
//                 decoration: InputDecoration(
//                   prefixText: selectedCurrency!.currencySymbol,
//                   contentPadding: const EdgeInsets.all(10),
//                   prefixStyle: CustomTextStyle.largeBlack(context),
//                   labelStyle: CustomTextStyle.mediumBlack(context),
//                   border: InputBorder.none,
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter the amount';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ),
//         ),
//         const Padding(padding: EdgeInsets.only(left: 15)),
//         CustomButton(
//             verticalpadding: 13,
//             bottompadding: 0,
//             toppadding: 0,
//             title: 'Enter',
//             ontap: () {
//               getTextInputData(id);
//               // var id = objectBox.addWeeklyMonthlySaving(
//               //   amountController.text,
//               // );
//             })
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;


import 'constants/helper.dart';

class QuillEditorPage extends StatefulWidget {
  @override
  _QuillEditorPageState createState() => _QuillEditorPageState();
}

class _QuillEditorPageState extends State<QuillEditorPage> {
  final QuillController _controller = QuillController.basic();
  bool isBulletSelected = false;
  bool isNumberSelected = false;
  bool isCheckSelected = false;
  bool isColorChanged = false;
  bool isUndoSelected = false;
  bool isRedoSelected = false;



  void toggleBulletPoints() {
    setState(() {
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              QuillProvider(
                configurations: QuillConfigurations(
                  controller: _controller,
                  sharedConfigurations: const QuillSharedConfigurations(),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: Helper.getHeight(context) * .3,
                      child: QuillEditor(
                        configurations: const QuillEditorConfigurations(
                          readOnly: false,
                        ), focusNode: FocusNode(),
                        scrollController: ScrollController(),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          color: isBulletSelected ? Colors.black : Colors.grey,
                          icon: const Icon(Icons.format_list_bulleted),
                          onPressed: () {
                            toggleBulletPoints();
                          },
                        ),
                        IconButton(
                          color: isNumberSelected ? Colors.black : Colors.grey,
                          icon: const Icon(Icons.format_list_numbered),
                          onPressed: () {
                            toggleNumber();
                          },
                        ),
                        IconButton(
                          color: isCheckSelected ? Colors.black : Colors.grey,
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            toggleCheck();
                          },
                        ),
                        IconButton(
                          color: isUndoSelected ? Colors.black : Colors.grey,
                          icon: const Icon(Icons.undo),
                          onPressed: () {
                            setState(() {
                              toggleUndo();
                              // isRedoSelected = false;
                              // isUndoSelected = !isUndoSelected;
                            });
                          },
                        ),
                        IconButton(
                          color: isRedoSelected ? Colors.black : Colors.grey,
                          icon: const Icon(Icons.redo),
                          onPressed: () {
                            setState(() {
                              toggleRedo();
                              // isUndoSelected = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}