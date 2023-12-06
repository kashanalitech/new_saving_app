import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
// import 'package:quill_delta/quill_delta.dart';
// import 'package:quill_flutter/quill_flutter.dart';
// import 'package:zefyr/zefyr.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: QuillScaffold(), // Use QuillScaffold instead of QuillProvider directly
          ),
        ),
      ),
    );
  }
}

class QuillScaffold extends StatefulWidget {
  @override
  _QuillScaffoldState createState() => _QuillScaffoldState();
}

class _QuillScaffoldState extends State<QuillScaffold> {
  late QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
  }

  @override
  Widget build(BuildContext context) {
    return QuillProvider(
      // Use the controller initialized in initState
      configurations: QuillConfigurations(
        controller: _controller,
        sharedConfigurations: const QuillSharedConfigurations(),
      ),
      child: Column(
        children: [
          QuillBaseToolbar(
            configurations: QuillBaseToolbarConfigurations(
              toolbarSize: 15 * 2,
              multiRowsDisplay: false,
              childrenBuilder: (context) {
                final controller = context.requireQuillController;
                return [
                  QuillToolbarHistoryButton(
                    controller: _controller,
                    options: const QuillToolbarHistoryButtonOptions(
                      isUndo: true,
                    ),
                  ),
                  // Add other toolbar buttons
                ];
              },
            ),
          ),
          Expanded(
            child: QuillEditor.basic(
              configurations: const QuillEditorConfigurations(
                readOnly: false,
                placeholder: 'Write your notes',
                padding: EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
