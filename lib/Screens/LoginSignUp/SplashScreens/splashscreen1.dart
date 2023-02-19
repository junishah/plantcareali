import 'package:flutter/material.dart';
import 'package:plantcareali/Screens/LoginSignUp/SplashScreens/SplashScreen2.dart';
class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: SafeArea(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('AssetsDirectory/Images/splash2.jpg'),

             const SizedBox(height: 10,),
            const Text('Plant a tree, Green',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                color: Colors.green
              ),
            ),
            Text('the Earth',style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green
            ),),
            SizedBox(height: 10,),
            Text('Find almost all types of ',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),),
            Text('plants that you like here',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),),
            const SizedBox(height: 100,),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(15),
            ),

            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen2()));
            },
                icon: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)),
          ),
          ],
        ),
      ),
    );
  }
}

