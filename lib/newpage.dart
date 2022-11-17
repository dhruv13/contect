import 'package:contect/DbHelper.dart';
import 'package:contect/formpage.dart';
import 'package:contect/updatepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {

  List<Map<String, Object?>> l = List.empty(growable: true);
  bool status = false;
  Database? db;

  bool search = false;
  final ImagePicker _picker= ImagePicker();
  String path= "";
  List<Map> temp = [];


  @override
  void initState() {
    super.initState();

    l.sort(
          (a, b) => a['name'].toString().compareTo(b['name'].toString()),
    );

    temp = l;
    getdata();

  }

  getdata() async {
    db = await DbHelper().createDatabase();
    String qry = "select * from dr";
    List<Map<String, Object?>> l1 = await db!.rawQuery(qry);
    l.addAll(l1);
    setState(() {
      status = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: search
          ? AppBar(
        title: TextField(
          onChanged: (value) {
            print(value);

            temp = [];
            if (value.isEmpty)
            {
              temp = l;
            }
            else
            {
              for (int i = 0; i < l.length; i++) {
                if (l[i]['name']
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                    l[i]['contact'].toString().contains(value)) {
                  temp.add(l[i]);
                }
              }
            }

            setState(() {});
          },
          autofocus: true,
          decoration: InputDecoration(
              prefix: Icon(Icons.search),
              suffix: IconButton(
                  onPressed: () {
                    search = false;
                    setState(() {});
                  },
                  icon: Icon(Icons.close))),
        ),
      )
          : AppBar(
        title: Text("Contact"),
        actions: [
          IconButton(
              onPressed: () {
                search = true;
                setState(() {});
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: status
          ? (l.length > 0
          ? ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          Map m = l[index];
          return ListTile(
            leading: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.greenAccent, shape: BoxShape.circle),
              child:
              Text("${m['id']}"),
            ),


          onTap: () async {

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return updatepage(m);
              },));
            },
            onLongPress: () {
              showDialog(
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Delete"),
                      content: Text(
                          "are you sure want to delete this user permentally"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              int id = m['id'];
                              String qry = "delete from dr where id = $id";
                              db!.rawDelete(qry).then((value) {
                                setState(() {
                                  l.removeAt(index);
                                });
                              });
                            },
                            child: Text("yes")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, child: Text("No"))
                      ],
                    );
                  }, context: context);
            },
            title: Text("${m['name']}"),
            subtitle: Text("${m['contact']}"),
          );
        },
      )

          : Center(child: Text("NO data Found")))
          : Center(child: CircularProgressIndicator()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return formpage();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
