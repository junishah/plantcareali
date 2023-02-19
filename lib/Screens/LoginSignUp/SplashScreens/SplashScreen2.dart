import 'package:flutter/material.dart';
import 'package:plantcareali/Screens/LoginSignUp/Button.dart';
import 'package:plantcareali/Screens/LoginSignUp/LoginScreen.dart';
class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: SafeArea(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('AssetsDirectory/Images/splash1.jpg'),
            const SizedBox(height: 25,),
            const Text('Learn more about ',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                color: Colors.green
              ),
            ),
            const Text('plants ',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                color: Colors.green
              ),
            ),
            SizedBox(height: 20,),
            const Text('Read how to care for plants',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
              ),
            ),
            const Text('in our rich plant guide ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
              ),
            ),
            const SizedBox(height: 100,),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              }, icon: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)),
            ),

          ],
        ),
      ),
    );
  }
}

