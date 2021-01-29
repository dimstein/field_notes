import 'dart:async';
import 'dart:ui';

import 'package:field_notes/base_camp/models/note.dart';
import 'package:field_notes/base_camp/models/tab_pages.dart';
import 'package:field_notes/base_camp/note_form_parts/notes_card.dart';
import 'package:field_notes/base_camp/note_form_parts/pictures_card.dart';
import 'package:field_notes/base_camp/note_form_parts/title_card.dart';
import 'package:field_notes/base_camp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:load_toast/load_toast.dart';
import 'package:provider/provider.dart';

class NoteForm extends StatefulWidget {

  final TabPages tabPages;

  const NoteForm({Key key, this.tabPages}) : super(key: key);

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {

  String nextURK = 'null';
  String _droppedValue = 'null';

  TextEditingController refTEC = TextEditingController();
  TextEditingController titleTEC = TextEditingController();
  TextEditingController clientTEC = TextEditingController();
  TextEditingController locationTEC = TextEditingController();
  TextEditingController authorTEC = TextEditingController();
  TextEditingController notesTEC = TextEditingController();
  TextEditingController picturesTEC = TextEditingController();

  @override
  void dispose() {
    refTEC.dispose();
    titleTEC.dispose();
    clientTEC.dispose();
    locationTEC.dispose();
    authorTEC.dispose();
    notesTEC.dispose();
    picturesTEC.dispose();
    super.dispose();
  }

  void clearTEC(){
    setState(() {
      refTEC.clear();
      titleTEC.clear();
      clientTEC.clear();
      locationTEC.clear();
      authorTEC.clear();
      notesTEC.clear();
      picturesTEC.clear();
      _droppedValue='null';
    });
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<Database>(context);

    final screenSize = MediaQuery.of(context).size;
    final myBar = AppBar().preferredSize.height;

    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Padding(
          padding: const EdgeInsets.all(1.0),
      child: Stack(
        children: [
          Container(
            width: screenSize.width,
            height: screenSize.height-myBar+5,
            color: Colors.blueGrey[200],
            child: Padding(
                padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey[400]
                  ),
                  width: screenSize.width*0.80,
                  child: Center(
                    child: StreamBuilder<List<Note>>(
                      stream: db.notesStream(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState==null){
                          return Container(
                            width: screenSize.width,
                              height: screenSize.height,
                            child: CircularProgressIndicator(),
                          );
                        }
                        if(snapshot.hasError){
                          print('Error from the Streambuilder');
                        }
                        if(snapshot.hasData){
                          var note = snapshot.data;
                          return DropdownButton<String>(
                            onChanged: (value){
                              setState(() {
                                _droppedValue=value;
                                var selected = note.firstWhere(
                                        (element) => element.urk.startsWith(value));
                                titleTEC.text=selected.title;
                                refTEC.text=selected.reference;
                                authorTEC.text=selected.author;
                                clientTEC.text=selected.client;
                                locationTEC.text=selected.location;
                                notesTEC.text=selected.note;
                                picturesTEC.text=selected.pictures[0];
                              });
                            },
                            icon: Icon(Icons.beach_access),
                            iconSize: 25,
                            style: TextStyle(color: Colors.indigo),
                            hint: _droppedValue=='null'
                              ? Text('Select or Enter New  ',
                                style: TextStyle(fontSize: 25))

                            : Text('$_droppedValue      ', style: TextStyle(fontSize: 25),
                            ),
                            elevation: 15,
                            items: note.isEmpty ? 'null' : note.toList()
                              .map((item) => item.urk)
                                .map<DropdownMenuItem<String>>(
                              (String value){
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value));
                              }
                            ).toList(),

                          );

                        }
                        return Container(
                          child: CircularProgressIndicator());
                        }),
                  ),
                ),
                SingleChildScrollView(
                  child: TitleCard(
                    titleTEC: titleTEC,
                    referenceTEC: refTEC,
                    authorTEC: authorTEC,
                    clientTEC: clientTEC,
                    locationTEC: locationTEC,
                  ),
                ),
                NotesCard(
                  notesTEC: notesTEC,
                ),
                PicturesCard(
                  picturesTEC: picturesTEC,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: inputPageFAB(db),
                )
              ],
            ),),
          )
        ],
      ),
      ),
    );
  }

 Row inputPageFAB(Database db) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: Icon(Icons.add),
            onPressed: (){
              db.lastURK().then((value){
                nextURK = ((int.parse(value))+1).toString();
                String urk = _droppedValue=='null' ? nextURK : _droppedValue;
                List<String> _zearch= [
                  refTEC.text,
                  titleTEC.text,
                  clientTEC.text,
                  authorTEC.text,
                  locationTEC.text,
                  notesTEC.text,
                  picturesTEC.text,
                  urk
                  ];
                List<String> _picture = ['a pic', 'an image'];
                print('This is urk: $urk or droppedValue $_droppedValue');

                db.setNote(Note(
                  title: titleTEC.text,
                  author: authorTEC.text,
                  client: clientTEC.text,
                  location: locationTEC.text,
                  note: notesTEC.text,
                  pictures: _picture,
                  reference: refTEC.text,
                  urk: urk,
                  zearch: _zearch
                ))
               .then((value) =>
                showLoadToast(
                  indicatorColor: Colors.green[900],
                  backgroundColor: Colors.green,
                  text: 'Saved')
                    .then((value) =>
                      Timer(Duration(seconds: 2), ()=>
                          hideLoadToastWithSuccess()))
                    .catchError((Object error)=>
                    showLoadToast(
                      indicatorColor: Colors.red[900],
                      backgroundColor: Colors.red,
                      text: 'Error')
                ));
                _droppedValue=urk;
              });
            }),
        SizedOverflowBox(
            size: Size(10,0),),
        FloatingActionButton(
            child: Icon(Icons.clear),
            onPressed: (){clearTEC();})
      ],
    );
 }
}