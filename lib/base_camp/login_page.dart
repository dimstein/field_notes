import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailTEC, passwordTEC;

  @override
  void dispose() {
    emailTEC.dispose();
    passwordTEC.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.lock_sharp),
      title: Text('Field Notes Login'),
        actions: [
          Icon(Icons.logout)
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Spacer(),
            CircleAvatar(
              radius: 42,
              backgroundColor: Color(0xffffd700),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('images/duck.png'),

              ),
            ),
            TextFormField(
              //controller: emailTEC,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Login Email',
                labelText: 'email'
              ),
              onSaved: (String value){},
              // validator: (String value){
              //   return value.contains('@') ? 'Not a email address' : null;
              // },

            ),
            TextFormField(
              controller: passwordTEC,
                decoration: InputDecoration(
                    icon: Icon(Icons.cake),
                    hintText: 'Login Password',
                    labelText: 'password'
                )
            ),
            RaisedButton.icon(
                onPressed: (){},
                icon: Icon(Icons.login_rounded),
                label: Text('Login')),
            Spacer(),

          ],
        )
        ,
      ),
    );
  }
}
