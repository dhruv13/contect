import 'package:contect/DbHelper.dart';
import 'package:contect/newpage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:io';

class formpage extends StatefulWidget {
  const formpage({Key? key}) : super(key: key);

  @override
  State<formpage> createState() => _formpageState();
}

class _formpageState extends State<formpage> {

  final ImagePicker _picker= ImagePicker();
  String path= "";

  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();
  TextEditingController temail = TextEditingController();
  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      DbHelper().createDatabase().then((value) {
         db = value;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Contact"),leading: IconButton(onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return demo();
        },));
      }, icon: Icon(Icons.arrow_back_rounded))),
      body: ListView(
        children: [
          InkWell(
              onTap: () {
                showDialog(builder: (context) {
                  return SimpleDialog(
                    title: Text("Select Picture"),
                    children: [
                      ListTile(
                        onTap: () async {
                          final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                          if(photo != null)
                          {
                            path=photo.path;
                            setState((){});
                          }
                        },
                        title: Text("Canera"),
                        leading: Icon(Icons.camera_alt),
                      ),
                      ListTile(
                        onTap: () async {
                          final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                          if(image != null)
                          {
                            path=image.path;
                            setState((){});
                          }
                        },
                        title: Text("Gallery"),
                        leading: Icon(Icons.browse_gallery),
                      ),
                    ],
                  );
                },context: context);
              },
              child: path.isEmpty
                  ? Image.asset(
                  "myimage/user-free-icon-font.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill)
                  : Image.file(
                File(path),
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              )),
          TextField(controller: tname,decoration: InputDecoration(hintText: "username",
                  prefixIcon: IconButton(onPressed: () {

                  }, icon: Icon(Icons.account_circle))
          )),


          TextField(controller: tcontact,decoration:
          InputDecoration(hintText: "mobail number",
          prefixIcon: IconButton(onPressed: () {

           }, icon: Icon(Icons.phone))
          )),

          TextField(controller: temail,decoration:
          InputDecoration(hintText: "enter email",
          prefixIcon: IconButton(onPressed: () {

          }, icon: Icon(Icons.email))
          )),

          ElevatedButton(onPressed: () async {
            String name = tname.text;
            String contact = tcontact.text;
            String email = temail.text;

            List<String> l=path.split("/");
            String imagename=l.last;

           String qry = "insert into dr (name,contact,email) values('$name','$contact','$email')";
           int a = await db!.rawInsert(qry);


           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
             return demo();
           },));

          }, child: Text("Save"))
        ],
      ),
    );
  }
}
