// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// void main()
// {
//   runApp(MaterialApp(home: camera(),));
// }
//
// class camera extends StatefulWidget {
//   const camera({Key? key}) : super(key: key);
//
//   @override
//   State<camera> createState() => _cameraState();
// }
//
// class _cameraState extends State<camera> {
//   final ImagePicker _picker= ImagePicker();
//   String path= "";
//
//   TextEditingController tname = TextEditingController();
//   TextEditingController tcontact=TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("ContactBook"),centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           InkWell(
//               onTap: () {
//                 showDialog(builder: (context) {
//                   return SimpleDialog(
//                     title: Text("Select Picture"),
//                     children: [
//                       ListTile(
//                         onTap: () async {
//                           final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//                           if(photo != null)
//                           {
//                             path=photo.path;
//                             setState((){});
//                           }
//                         },
//                         title: Text("Canera"),
//                         leading: Icon(Icons.camera_alt),
//                       ),
//                       ListTile(
//                         onTap: () async {
//                           final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//                           if(image != null)
//                           {
//                             path=image.path;
//                             setState((){});
//                           }
//                         },
//                         title: Text("Gallery"),
//                         leading: Icon(Icons.browse_gallery),
//                       ),
//                     ],
//                   );
//                 },context: context);
//               },
//               child: path.isEmpty
//                   ? Image.asset(
//                   "myimages/user-free-icon-font.png",
//                   height: 100,
//                   width: 100,
//                   fit: BoxFit.fill)
//                   : Image.file(
//                 File(path),
//                 height: 100,
//                 width: 100,
//                 fit: BoxFit.fill,
//               )),
//
//           TextField(controller: tname,),
//           TextField(controller: tcontact,),
//           ElevatedButton(onPressed: () async {
//
//             String name= tname.text;
//             String contact=tcontact.text;
//
//             List<String> l=path.split("/");
//
//             String imagename=l.last;
//
//           }, child: Text("dhruv"))
//         ],
//       ),
//     );
//   }
// }
