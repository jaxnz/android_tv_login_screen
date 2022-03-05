import 'package:android_tv_login_screen/android_tv_login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AndroidTVLoginScreen(
        customExtensions: ['.co.nz', '.nz'],
        errorMessage: 'This is an error message',
        loginScreenBackgroundColor: Color(0xFF00AEEF),
        loginScreenBottomWidget: Container(
          height: 100,
          child: Image.asset('assets/logo.png')
        ),
        error: error,
        onLogin: (loginDetaiils){
          if(loginDetaiils != null){
            print(loginDetaiils.email);
            print(loginDetaiils.password);
            setState(() {
              error = true;
            });
          }
        },
      ),
    );
  }
}
