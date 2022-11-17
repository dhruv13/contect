import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: demo(),
    debugShowCheckedModeBanner: false,
  ));
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  List<Map> l = [
    {"name": "Suresh", "contact": "9876541230"},
    {"name": "Mahesh", "contact": "7894561230"},
    {"name": "Jay", "contact": "5412987630"},
    {"name": "Jayesh", "contact": "9841230765"},
    {"name": "Naresh", "contact": "9412308765"},
    {"name": "Sanjay", "contact": "9412387650"},
    {"name": "Ajay", "contact": "8765412930"},
    {"name": "Ganesh", "contact": "8765491230"},
    {"name": "Vijay", "contact": "9654187230"},
    {"name": "Haresh", "contact": "9873065412"},
  ];

  bool search = false;

  List<Map> temp = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    l.sort(
          (a, b) => a['name'].toString().compareTo(b['name'].toString()),
    );

    temp = l;
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
        title: Text("ContactBook"),
        actions: [
          IconButton(
              onPressed: () {
                search = true;
                setState(() {});
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: search
          ? ListView.builder(
        itemCount: temp.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.pink, shape: BoxShape.circle),
              child:
              Text("${temp[index]['name'].toString().split("")[0]}"),
            ),
            title: Text("${temp[index]['name']}"),
            subtitle: Text("${temp[index]['contact']}"),
          );
        },
      )
          : ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFF288824), shape: BoxShape.circle),
              child: Text("${l[index]['name'].toString().split("")[0]}"),
            ),
            title: Text("${l[index]['name']}"),
            subtitle: Text("${l[index]['contact']}"),
          );
        },
      ),
    );
  }
}
