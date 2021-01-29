import 'package:field_notes/base_camp/models/tab_pages.dart';
import 'package:flutter/material.dart';

class NoteList extends StatelessWidget {

  final TabPages tabPage;

  const NoteList({Key key, this.tabPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('NoteList Pages'),);
  }
}
