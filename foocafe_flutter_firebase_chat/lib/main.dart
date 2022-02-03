import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foocafe_flutter_firebase_chat/screens/chat_screen.dart';
import 'package:foocafe_flutter_firebase_chat/screens/login_screen.dart';
import 'helpers/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const ChatScreen(),
    );
  }
}
