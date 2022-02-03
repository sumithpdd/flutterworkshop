import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foocafe_flutter_firebase_chat/screens/chat_screen.dart';
import 'package:foocafe_flutter_firebase_chat/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'helpers/app_constants.dart';
import 'models/user_data.dart';
import 'screens/attendees_screen.dart';
import 'services/auth_service.dart';
import 'services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserData(),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<DatabaseService>(
          create: (_) => DatabaseService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Widget _getScreenId() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data!.uid;
          return const AttendeesScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

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
      home: _getScreenId(),
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        AttendeesScreen.id: (context) => const AttendeesScreen(),
      },
    );
  }
}
