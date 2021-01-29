import 'package:field_notes/base_camp/nav_home_page.dart';
import 'package:field_notes/base_camp/services/database.dart';
import 'package:field_notes/base_camp/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';



class LandingPage extends StatelessWidget {

  final String appTitle;

  const LandingPage({Key key, this.appTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.active){
            FirebaseUser user = snapshot.data;
            if(user == null){
              return SignInPage(appTitle: appTitle);
            }
            return Provider<Database>(
              create: (_)=> FirestoreDatabase(),
              child: NavHomePage()
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              )
            );
          }
        });
  }
}
