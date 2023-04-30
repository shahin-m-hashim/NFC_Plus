import 'package:flutter/material.dart';

class EditTodoPopup extends StatelessWidget {
  final ValueNotifier<String> currentName;
  final Function(String) onSave;

  EditTodoPopup({required this.currentName, required this.onSave});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController =
        TextEditingController(text: currentName.value);

    return AlertDialog(
      title: const Text('Edit Todo'),
      content: TextField(
        controller: _textEditingController,
        decoration: const InputDecoration(
          hintText: 'Enter new name for todo',
        ),
        onChanged: (value) => currentName.value = value,
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text('Save'),
          onPressed: () {
            onSave(_textEditingController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
