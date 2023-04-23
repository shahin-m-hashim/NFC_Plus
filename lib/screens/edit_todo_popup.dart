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
      title: Text('Edit Todo'),
      content: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: 'Enter new name for todo',
        ),
        onChanged: (value) => currentName.value = value,
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Save'),
          onPressed: () {
            onSave(currentName.value);
            print(
                'Todo updated successfully with new title: ${currentName.value}');
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
