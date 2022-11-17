import 'package:contect/DbHelper.dart';
import 'package:contect/newpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class updatepage extends StatefulWidget {
  Map<dynamic, dynamic> m;
  updatepage(this.m);



  @override
  State<updatepage> createState() => _updatepageState();
}

class _updatepageState extends State<updatepage> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();
  TextEditingController temail = TextEditingController();
  Database? db;


  @override
  void initState() {
    super.initState();
    tname.text = widget.m['name'];
    tcontact.text = widget.m['contact'];
    temail.text = widget.m['email'];

    DbHelper().createDatabase().then((value) => {
      db = value
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(title: Text("edit Contact"),leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return demo();
          },));
        }, icon: Icon(Icons.arrow_back_rounded)),actions: [
          TextButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return demo();},));
          }, child: Text("home"))
        ]),
        body: SafeArea(
          child: Column(
            children: [
              TextField(controller: tname,decoration: InputDecoration(hintText: "username")),
              TextField(controller: tcontact,decoration: InputDecoration(hintText: "mobail number"),keyboardType: TextInputType.phone),
              TextField(controller: temail,decoration: InputDecoration(hintText: "email"),keyboardType: TextInputType.emailAddress),
              ElevatedButton(onPressed: () {
                String name = tname.text;
                String contact = tcontact.text;
                String email = temail.text;
                int id = widget.m['id'];

                String qry = 'update dr set name = "$name",contact = "$contact",email = "$email" where id = "$id"';
                db!.rawUpdate(qry).then((value) => {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return demo();
                  },))
                });
              }, child: Text("UPDATE"))
            ],
          ),
        ),
      ),
      onWillPop: goback,);
  }
  Future<bool> goback()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return demo();
    },));
    return Future.value();
  }
}
