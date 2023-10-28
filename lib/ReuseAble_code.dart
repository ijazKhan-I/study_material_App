import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RoundButton extends StatelessWidget {
  late final String title;
  late final VoidCallback onTap;
  late bool loading;

  RoundButton({required this.title, required this.onTap, required this.loading,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: loading? const CircularProgressIndicator(strokeWidth: 3,color: Colors.white,):Text(title,style: const TextStyle(color: Colors.white)),),
      ),
    );
  }


}

class Utils{
  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}
class Box extends StatelessWidget{
  final height;
  Box({required this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,);
  }


}