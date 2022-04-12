import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signin_page.dart';
import 'package:herewego/pages/signup_page.dart';
import 'package:herewego/service/auth_service.dart';
import 'package:herewego/service/hive_DB.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox(HiveDB.nameDB);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget _startPage(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthenticationService.auth.authStateChanges(),
      builder: (context, value) {
        if (value.hasData) {
  
          HiveDB.putUser(value.data!);
          return const HomePage();
        } else {
     
          HiveDB.removeUser();
          return const SignIn();
        }
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: _startPage(context),
      routes: {
        HomePage.id: (context) => const HomePage(),
        SignIn.id: (context) => const SignIn(),
        SignUp.id: (context) => const SignUp(),
        DetailPage.id: (context) => const DetailPage()
      },
    );
  }
}
