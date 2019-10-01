import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'appTheme.dart';
import 'widgets/app_bottom_bar_view.dart';
import 'widgets/tab_icon.dart';
import 'package:flushbar/flushbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nice bottom bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: buildSplashScreen(context),
    );
  }

  Widget buildSplashScreen(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: MyHomePage(title: 'Nice bottom bar'),
      title: new Text(
        'Welcome In Nice bottom bar',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.network(
          'https://flutter.io/images/catalog-widget-placeholder.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
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
  static List<TabIconData> tabIconsList = [
    TabIconData(
        imagePath: 'assets/fitness_app/tab_1.png',
        selectedImagePath: 'assets/fitness_app/tab_1s.png',
        index: 0)
      ..selected(),
    TabIconData(
      imagePath: 'assets/fitness_app/tab_2.png',
      selectedImagePath: 'assets/fitness_app/tab_2s.png',
      index: 1,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/tab_3.png',
      selectedImagePath: 'assets/fitness_app/tab_3s.png',
      index: 2,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/tab_4.png',
      selectedImagePath: 'assets/fitness_app/tab_4s.png',
      index: 3,
    ),
  ];

  String _tabContent = "Tab 1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: <Widget>[
            Container(
              color: Colors.amberAccent,
              child: Center(
                child: Text(
                  _tabContent,
                  style: TextStyle(color: Colors.black45, fontSize: 30),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: AppBottomBar(
                  changeTabEvent: _changeTabEvent,
                  tabIcons: tabIconsList,
                  clickButtonEvent: () {
                    _clickButtonEvent(context);
                  }
              ),
            ),
          ],
        );
      }),
    );
  }

  void _changeTabEvent(int index) {
    setState(() {
      _tabContent = "Tab " + (index + 1).toString();
    });
  }

  void _clickButtonEvent(BuildContext context) {
    Flushbar(
      duration: Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      animationDuration: Duration(milliseconds: 300),
      icon: Icon(
          Icons.info,
          color: Colors.white,
      ),
      title: "Hey Guys",
      message: "I see you clicked my lovely button, right?",)..show(context);
  }
}
