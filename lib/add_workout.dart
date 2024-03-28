import 'package:flutter/material.dart';
import 'home.dart';

class AddWorkoutDialog extends StatefulWidget {
  final Function(Workout) onWorkoutAdded;

  const AddWorkoutDialog({super.key, required this.onWorkoutAdded});

  @override
  _AddWorkoutDialogState createState() => _AddWorkoutDialogState();
}

class _AddWorkoutDialogState extends State<AddWorkoutDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _duration = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Workout'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Duration (minutes)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a duration';
                }
                return null;
              },
              onSaved: (value) {
                _duration = int.parse(value!);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Workout newWorkout = Workout(
                name: _name,
                duration: _duration,
                date: DateTime.now(),
              );
              widget.onWorkoutAdded(newWorkout);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}