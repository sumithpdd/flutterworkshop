import 'package:flutter/material.dart';

import 'helpers/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foocafe Flutter workshop',
      theme: ThemeData(
        primarySwatch: AppConstants.colorToMaterialColor(
            AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR)),
        primaryColor: AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR),
        backgroundColor:
            AppConstants.hexToColor(AppConstants.APP_BACKGROUND_COLOR),
        primaryColorLight:
            AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR_LIGHT),
        dividerColor:
            AppConstants.hexToColor(AppConstants.APP_BACKGROUND_COLOR_GRAY),
        textTheme: TextTheme(
          caption: TextStyle(
              color: AppConstants.hexToColor(
                  AppConstants.APP_PRIMARY_FONT_COLOR_WHITE)),
        ),
      ),
      home: const MyHomePage(title: 'Foocafe Flutter workshops'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;
  final nameController = TextEditingController();
  String name = "";
  void _printLatestValue() {
    setState(() {
      name = nameController.text;
    });
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    nameController.addListener(_printLatestValue);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                'assets/images/logo-withtext-color.png',
                width: 150,
              ),
            ),
            Text('Foocafe Flutter workshop'),
            Text(
              '😍 ${name.isEmpty ? "I" : name} love this workshop😍',
            ),
            Text(
              '$_counter times',
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your name',
                ),
                controller: nameController,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Like',
        child: const Icon(Icons.favorite, color: Colors.red),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
