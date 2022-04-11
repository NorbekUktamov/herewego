import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fb = FirebaseDatabase.instance;
  var l;
  var g;
  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('posts');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Posts',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              AuthService().signOut();
            },
            icon: Icon(Icons.exit_to_app,color: Colors.white,),
          ),
        ],
        backgroundColor: Colors.red,
      ),
      body: FirebaseAnimatedList(
        query: ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          var v =
          snapshot.value.toString(); // {subtitle: webfun, title: subscribe}

          g = v.replaceAll(
              RegExp("{|}|firstname: |lastname: |content: |data: "), ""); // webfun, subscribe
          g.trim();

          l = g.split(','); // [webfun,  subscribe}]

          return GestureDetector(
            onTap: () {
              var c = snapshot.value.toString();
              print(c);
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      child: Column(

                        children: [
                          Row(
                            children: [
                              Text(l[0],style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),),
                              SizedBox(width: 5,),
                              Text(l[3],style: TextStyle(
                                fontSize: 25,fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              Text(l[2],style: TextStyle(
                                fontSize: 25,
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              Text(l[1],style: TextStyle(
                                fontSize: 25,
                              ),),
                            ],
                          ),



                        ],
                      ),
                    ),
                  ],
                ),

              ),
            ),
          );
        },
      ),
    );
  }


}