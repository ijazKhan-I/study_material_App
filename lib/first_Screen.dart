import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:study_materials/Login_Screen.dart';
import 'package:file_picker/file_picker.dart';


class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {

  String id=DateTime.now().microsecond.toString().toString();
  final auth=FirebaseAuth.instance;
  bool loading=true;
  double per=0;
  Future<firebase_storage.UploadTask?> uploadFile(File file) async {
    setState(() {
      loading=false;
    });
    if (file == null) {
      return null;
    }

    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('playground')
        .child('/$id.zip');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/zip',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);

 uploadTask.snapshotEvents.listen((firebase_storage.TaskSnapshot taskSnapshot) {
   final progress=100*(taskSnapshot.bytesTransferred.toDouble()/taskSnapshot.totalBytes.toDouble());
   switch(taskSnapshot.state){
     case firebase_storage.TaskState.running:
       print(taskSnapshot.bytesTransferred/taskSnapshot.totalBytes);

       setState(() {
per=progress.toDouble();

       });
       print("uplode id $progress complete");
       break;
     case firebase_storage.TaskState.paused:
       print("uplode is paused");
       break;
     case firebase_storage.TaskState.canceled:
       print("uplode is canceled");
       break;
     case firebase_storage.TaskState.error:
       print("uplode is error");
       break;
       case firebase_storage.TaskState.success:
         Future.value(uploadTask).then((value){
           setState(() {
             loading=false;
           });
         });

         print("Uplode is success");
         break;
   }
 });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First SCreen"),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));
            });
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Container(
                 child:FloatingActionButton(
      onPressed: () async{
        final path = await FlutterDocumentPicker.openDocument();
        File file = File(path!);
        firebase_storage.UploadTask? task = await uploadFile(file);
      },
      backgroundColor: Colors.red,

                child: const Icon(Icons.add,color: Colors.white,),

    ),
      ),
          SizedBox(height: 50,

            width: 30,

          ),
            Center(
              child: (loading)?Container():CircularPercentIndicator(radius: 100,
              lineWidth: 5,
                percent: (per/100),
                backgroundColor: Colors.red,
                progressColor: Colors.blue,
                animation: true,
                center: Text("${per.toStringAsFixed(1)} %",style: TextStyle(
                  fontSize: 20,
                ),),

                  ),
            ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (contex)=>view()));
          }, child: Text("View pdf")),



        ],
      ),
    );
  }


}

