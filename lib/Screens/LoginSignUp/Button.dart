import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {

  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({Key? key,
    required this.title,

    required this.onTap,
    this.loading= false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(5),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [



                Colors.blueAccent,
                Colors.blueAccent,



              ],
            )
        ),

        child: Center(
          child: loading? const CircularProgressIndicator(strokeWidth: 3,color: Colors.black,):
          Text(title,style: const TextStyle(fontSize: 15,color: Colors.white),),
        ),
      ),
    );
  }
}
