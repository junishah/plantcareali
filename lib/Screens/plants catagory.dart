import 'package:flutter/material.dart';


class Plantscatagorycard extends StatelessWidget {
  final icon;
  final String catagoryName;
  const Plantscatagorycard({Key? key, required this.catagoryName,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 5),
      child: Container(

        padding: const EdgeInsets.all(8),

        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: Colors.black
            )

        ),
        child: Column(
          children: [
            Image.asset(icon,
              height: 50,
           ),
            const SizedBox(width: 8,),
            Text(catagoryName),
          ],
        ),
      ),
    );
  }
}

