import 'package:flutter/material.dart';
import 'package:herewego/service/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static final id ="home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child:Container(
          child:  ElevatedButton(
            onPressed: (){
              AuthService().signOut();
            },
            child: Text("Log Out",style: TextStyle(color: Colors.white60),),

          ),
        ),
      ),
    );
  }
}
