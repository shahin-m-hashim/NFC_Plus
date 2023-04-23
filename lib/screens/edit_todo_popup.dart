import 'package:flutter/material.dart';

class EditTodoPopup extends StatefulWidget {
  final String currentName;
  final Function(String) onSave;

  EditTodoPopup({required this.currentName, required this.onSave});

  @override
  _EditTodoPopupState createState() => _EditTodoPopupState();
}

class _EditTodoPopupState extends State<EditTodoPopup> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Todo'),
      content: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: 'Enter new name for todo',
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Save'),
          onPressed: () {
            widget.onSave(_textEditingController.text);
            print(
                'Todo updated successfully with new title: ${_textEditingController.text}');
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
