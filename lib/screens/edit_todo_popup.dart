import 'package:flutter/material.dart';

class EditTodoPopup extends StatelessWidget {
  final String id; // add the id parameter
  final ValueNotifier<String> currentName;
  final void Function(String newName, String id) onSave;

  EditTodoPopup({
    required this.id,
    required this.currentName,
    required this.onSave,
  });

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
            onSave(id, _textEditingController.text);
            // pass the id parameter here as well
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
