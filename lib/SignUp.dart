import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_materials/ReuseAble_code.dart';
class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  bool loading=false;
   late String name,email,password;
   var formKey=GlobalKey<FormState>();
   final nameController=TextEditingController();
   final emailController=TextEditingController();
   final passworController=TextEditingController();
   final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BCS Computer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,

                decoration:InputDecoration(
                  hintText: "Name",
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
                validator: (String? text){
                  if(text==null||text.isEmpty){
                    return "Enter name";
                  }else{
                    name=text.toString();
                  }
                },
              ),
             Box(height: 30.0),
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
              RoundButton(title: "Sign up", onTap: (){
               SignUp();
              }, loading: loading)

            ],
          ),
        ),
      ),
    );
  }
  //Sign Up function
  void SignUp(){
    if(formKey.currentState!.validate()){
      setState(() {
        loading=true;
      });
      _auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passworController.text.toString()).then((value){
        setState(() {
          loading=false;
        });

      }).onError((error, stackTrace){
        Utils().toastMessage(error.toString());
        setState(() {
          loading=false;
        });

      });

    }
  }
}
