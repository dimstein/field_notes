import 'package:field_notes/base_camp/models/tab_pages.dart';
import 'package:field_notes/base_camp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavHomePage extends StatefulWidget {

  final VoidCallback navSubmit;

  const NavHomePage({Key key, this.navSubmit}) : super(key: key);

  @override
  _NavHomePageState createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHomePage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(allTabPages[_currentIndex].pageTitle),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: (){
                db.logOut();
              }
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: IndexedStack(
              index: _currentIndex,
              children: allTabPages.map<Widget>((TabPages tabPages) {
                return tabPages.page;
    }
            ).toList(),
          ),
        ),
      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
          },
          items: allTabPages.map((TabPages tabPages) {
            return BottomNavigationBarItem(
            icon: Icon(tabPages.icon),
    backgroundColor: tabPages.color,
    label: tabPages.title
    );
    }
      ).toList(),
      ),
    );
  }
}
