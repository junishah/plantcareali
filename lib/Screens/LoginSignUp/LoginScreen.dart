import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantcareali/Home_UI.dart';
import 'package:plantcareali/Screens/LoginSignUp/Button.dart';
import 'package:plantcareali/Screens/LoginSignUp/SignUP.dart';
import 'package:plantcareali/Screens/LoginSignUp/utils.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  bool loading= false;
  final _formKey= GlobalKey<FormState>();
  final emailController= TextEditingController();
  final passwordController= TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(
        email:emailController.text,
        password: passwordController.text).then((value){
      utils().toastMessage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      setState(() {
        loading=false;
      });

    }).onError((error, stackTrace){
      utils().toastMessage(error.toString());
      setState(() {
        loading=false;
      });

    });

  }
  @override

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;

      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login Screen'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: Column(
              children: [
                Image.asset('AssetsDirectory/Images/login3.png',
                height: MediaQuery.of(context).size.height*.25,
                width:MediaQuery.of(context).size.height*.25, ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller:emailController ,
                            decoration: const InputDecoration
                              (
                              hintText: 'plant@gmail.com',
                              labelText: 'Email',
                              helperText: 'plant@gmail.com',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email_outlined),

                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                        ,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(

                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            obscureText: true,

                            decoration: InputDecoration(

                              labelText: 'Password',
                              hintText: 'Password',

                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter Password';
                              }
                              return null;
                            },

                          ),
                        )
                      ],

                    )),
                SizedBox(height: 20,),
                RoundButton(title: 'login',
                  loading: loading,
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      login();


                    };
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));



                  },),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account ',style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));

                    }, child:Text('Sign up')),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
