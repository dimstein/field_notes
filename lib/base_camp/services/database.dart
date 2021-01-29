import 'package:field_notes/base_camp/models/note.dart';
import 'package:field_notes/base_camp/services/firestore_service.dart';
import 'package:field_notes/base_camp/services/api_path.dart';
import 'package:flutter/material.dart';

abstract class Database {

  Stream<List<Note>> noteStream({@required String noteURK});

  Stream<List<Note>> notesStream();

  Stream<List<Note>> filterNoteStream({@required List<String> searchURK});

  Future<void> setNote(Note note);

  Future<void> logOut();

  Future<String> lastURK();
}

class FirestoreDatabase implements Database{
  final _service = FirestoreService.instance;

  @override
  Stream<List<Note>> filterNoteStream({List<String> searchURK}) =>
      _service.filteredStream(
          path: APIPath.note(),
          builder: (data)=> Note.fromMap(data),
          searchedURKs: searchURK
      );

  @override
  Future<String> lastURK() async =>
      await _service.lastURK(
          path: APIPath.note()
      );

  @override
  Future<void> logOut()  async => await _service.logOut();

  @override
  Stream<List<Note>> notesStream() => _service.collectionStream(
      path: APIPath.note(),
      builder: (data)=> Note.fromMap(data),
  );

  @override
  Future<void> setNote(Note note) async =>
      await _service.setNotes(
          path: 'note/${note.urk}',
          data: note.toMap(),
      );

  @override
  Stream<List<Note>> noteStream({String noteURK}) =>
      _service.docStream(
          path: APIPath.note(),
          builder: (data) => Note.fromMap(data),
          docURK: noteURK);



}