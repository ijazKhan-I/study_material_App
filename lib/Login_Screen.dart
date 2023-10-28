import 'package:flutter/material.dart';
import 'package:study_materials/ReuseAble_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_materials/first_Screen.dart';
import 'SignUp.dart';
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
   late String email,password;
   bool loading=false;
  var formKey=GlobalKey<FormState>();
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final passworController=TextEditingController();
  final _auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
body: Form(
  key:formKey,
  child:   Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration:InputDecoration(
              hintText: "Email",
              labelText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              )
          ),
          validator: (String? text){
            if(text==null||text.isEmpty){
              return "Enter email";
            }else{
              email=text.toString();
            }
          },
        ),
        Box(height: 30.0),
        TextFormField(
          controller: passworController,
          decoration:InputDecoration(
              hintText: "password",
              labelText: "password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              )
          ),
          validator: (String? text){
            if(text==null||text.isEmpty){
              return "Enter password";
            }else{
              password=text.toString();
            }
          },

        ),
        Box(height: 30.0),
        RoundButton(title: "Sing in", onTap: (){
          SignIn();
        }, loading: loading),
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>signUp()));

        }, child: const Text("Sign Up"))
      ],
    ),
  ),
),
    );
  }
   void SignIn(){
     if(formKey.currentState!.validate()){
       setState(() {
         loading=true;
       });
       _auth.signInWithEmailAndPassword(
           email: emailController.text.toString(),
           password: passworController.text.toString()).then((value){
         setState(() {
           loading=false;
         });
         Utils().toastMessage(value.user!.email.toString());
         Navigator.push(context, MaterialPageRoute(builder: (context)=>First()));


       }).onError((error, stackTrace){
         Utils().toastMessage(error.toString());

         setState(() {
           loading=false;
         });

       });

     }
   }
}
