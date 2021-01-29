import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {

  final TextEditingController notesTEC;

  const NotesCard({Key key, this.notesTEC}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        controller: notesTEC,
        decoration: InputDecoration(labelText: 'Notes'),
      ),
    );
  }
}
