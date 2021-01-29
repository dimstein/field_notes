import 'package:field_notes/base_camp/models/note.dart';
import 'package:field_notes/base_camp/models/tab_pages.dart';
import 'package:field_notes/base_camp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteListPage extends StatelessWidget {

  final TabPages tabPages;
  final List<String> searchURK;

  const NoteListPage({Key key, this.tabPages, this.searchURK }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SearchTextForm(),
              NoteListWidget(searched: ['null'])
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTextForm extends StatefulWidget {

  final NoteListWidget noteListWidget = NoteListWidget();

  @override
  _SearchTextFormState createState() => _SearchTextFormState();
}

class _SearchTextFormState extends State<SearchTextForm> {

  TextEditingController searchURKTEC = TextEditingController();




  @override
  void dispose() {
    searchURKTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
            child: SizedBox(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search'),
                controller: searchURKTEC,
              ),
            ),
        ),
        Expanded(
            flex: 1,
            child: RaisedButton(
                onPressed: (){
                  //NoteListWidget(searchText: searchURKTEC.text);
                  NoteListWidget()._callMethod(context, searchURKTEC.text);


                  },

              child: Icon(Icons.search),
            ),
        )
      ],
    );
  }
}

class NoteListWidget extends StatefulWidget {

  final List<String> searched;
  final String searchText;


  const NoteListWidget({Key key, this.searched, this.searchText
      }) : super(key: key);

  _callMethod(BuildContext context, String txt) => createState().filterList(context, txt);



  @override
  _NoteListWidgetState createState() => _NoteListWidgetState();
}

class _NoteListWidgetState extends State<NoteListWidget> {

  String activeURK;
  List<String> activeSearched=['null'];

  void filterList(BuildContext context, String txt){
    print('filterList has been entered into: $activeSearched[0] ');
    activeSearched.clear();

      activeSearched.add(txt);

    print('filterList has been exited: $activeSearched[0] ');
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<Database>(context);
    final myBar = AppBar().preferredSize.height;
    Size screen = MediaQuery.of(context).size;
    return Material(
      child: StreamBuilder<List<Note>>(
        stream: activeSearched[0]=='null'
          ? db.notesStream()
          : db.filterNoteStream(searchURK: activeSearched),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var note = snapshot.data;
              return GestureDetector(
                onLongPress: (){
                  setState(() {
                    activeURK='null';
                  });
                },
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      width: screen.width,
                      height: screen.height-(myBar+5),
                      color: Colors.blueGrey[300],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: note.length,
                            itemBuilder: (context, count)=>
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))
                                    ),
                                    child: ListTile(
                                      title: Text('${note[count].client}'),
                                      leading: Text('${note[count].reference}'),
                                        subtitle: Text('${note[count].author}'),
                                        trailing: Text('${note[count].urk}'),
                                        onTap: (){
                                        setState(() {
                                          activeURK='${note[count].urk}';
                                        });
                                        },
                                    ),
                                  ),
                                  SizedBox(height: 2,)
                                ],
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              );

            }
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.2,
                  height: MediaQuery.of(context).size.height*0.1,
                color: Colors.white,
                child: CircularProgressIndicator(backgroundColor: Colors.blue,),
              ),
            );
          }
      ),
    );

  }
}


