import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';


class DetailPage extends StatefulWidget {
  static final String id = "detail_page";

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final fb = FirebaseDatabase.instance;
  var isLoading = false;
  var lastnameController = TextEditingController();
  var contentController = TextEditingController();
  var firstnameController=TextEditingController();
  var dataController=TextEditingController();

  _addPost() async {
    String lastname = lastnameController.text.toString();
    String content = contentController.text.toString();
    String firstname =firstnameController.text.toString();
    String data =dataController.text.toString();

    if (lastname.isEmpty || data.isEmpty) return;
    var rng = Random();
    var k = rng.nextInt(10000);
    setState(() {
      isLoading = false;
    });
    final ref = fb.ref().child('posts/$k');
    ref.set({
      "firstname": firstnameController.text,
      "lastname": lastnameController.text,
      "content": contentController.text,
      "data": dataController.text,
    }).asStream();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomePage()));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: firstnameController,
                    decoration: InputDecoration(
                      hintText: "Firstname",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: lastnameController,
                    decoration: InputDecoration(
                      hintText: "Lastname",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      hintText: "Content",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: dataController,
                    decoration: InputDecoration(
                      hintText: "Data",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    child: FlatButton(
                      onPressed: _addPost,
                      color: Colors.red,
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          isLoading? Center(
            child: CircularProgressIndicator(),
          ): SizedBox.shrink(),
        ],
      ),
    );
  }
}