import 'package:field_notes/base_camp/note_form.dart';
import 'package:field_notes/base_camp/note_list_page.dart';
import 'package:flutter/material.dart';

class TabPages {
  final String title;
  final IconData icon;
  final MaterialColor color;
  final int index;
  final Widget page;
  final String pageTitle;

  const TabPages(
      {this.title,
      this.icon,
      this.color,
      this.index,
      this.page,
      this.pageTitle});
}

const List<TabPages> allTabPages = <TabPages>[
  TabPages(
      index: 0,
      title: 'Entry',
      icon: Icons.home,
      color: Colors.red,
      page: NoteForm(),
      pageTitle: 'Form'),
  TabPages(
      index: 1,
      title: 'List',
      icon: Icons.business,
      color: Colors.cyan,
      page: NoteListPage(),
      pageTitle: 'List Basic')
];

class ViewNavigatorObserver extends NavigatorObserver {
  final VoidCallback onNavigation;

  ViewNavigatorObserver(this.onNavigation);

  void didPop(Route<dynamic> route, Route<dynamic> previousRoutes){
    onNavigation();
  }

  void didPush(Route<dynamic> route, Route<dynamic> previousRoutes){
    onNavigation();
  }
}

class TabView extends StatefulWidget {

  final TabPages tabPages;
  final VoidCallback onNavigation;

  const TabView({Key key, this.tabPages, this.onNavigation}) : super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lime[200],
      child: IndexedStack(
        sizing: StackFit.expand,
        index: widget.tabPages.index,
        children: [NoteForm(),NoteListPage()],
      ),
    );
  }
}

