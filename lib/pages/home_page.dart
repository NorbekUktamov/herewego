
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../service/auth_service.dart';
import '../service/hive_DB.dart';
import '../service/rtdb_service.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List<Post> list = [];
  bool isLoading = false;

  Future<void> _openDetailPage() async {
    bool? saveButtonIsPressed = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const DetailPage()));
    if(saveButtonIsPressed != null && saveButtonIsPressed){
      loadData();
    }
  }

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    String id = await HiveDB.getUser();  // To get the user's ID
    RealtimeDB.GET(id).then((value) {
      setState(() {
        list = value;
        isLoading = false;
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loadData();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemRed,
        title: const Text('Posts'),

        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: (){
                AuthenticationService.signOut(context);
              }
          )
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index){
              return post(index);
            },
          ),
          isLoading ? const Center(
            child:  CircularProgressIndicator(color: CupertinoColors.systemRed),
          ) : const SizedBox(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 30,
        child: const Icon(Icons.add),
        onPressed: (){
          _openDetailPage();
        },
      ),
    );
  }

  Card post(int index){
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        // margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                // clipBehavior: Clip.antiAlias,
                // decoration: const BoxDecoration(
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(20),
                //     topRight: Radius.circular(20),
                //   ),
                // ),
                child: list[list.length - 1 - index].imageURL == 'no image'
                    ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                   child: Image.asset('assets/images/ic_default.png', ),
                )
                    : Image.network(list[list.length - 1 - index].imageURL, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 50.0),
              child: Text(list[list.length - 1 - index].title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 50.0),
              child: Text(list[list.length - 1 - index].content, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Text(list[list.length - 1 - index].date),
            ),
          ],
        ),
      ),
    );
  }
}