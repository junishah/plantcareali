import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantcareali/Screens/LoginSignUp/Button.dart';
import 'package:plantcareali/Screens/LoginSignUp/LoginScreen.dart';
import 'package:plantcareali/Screens/LoginSignUp/utils.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen ({Key? key}) : super(key: key);

  @override
  State<SignUpScreen > createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen > {


  bool loading= false;
  final _formKey= GlobalKey<FormState>();
  final emailController= TextEditingController();
  final NameController= TextEditingController();
  final passwordController= TextEditingController();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void signup(){
    setState( () {
      loading=true;
    });
    _auth.createUserWithEmailAndPassword(
        email:emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
      setState(() {
        loading= false;
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
    return Scaffold(
      appBar: AppBar(

        title: const Text('SignUp Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset('AssetsDirectory/Images/SignUp4.png',
                      height: MediaQuery.of(context).size.height*.2,),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller:NameController ,
                        decoration: const InputDecoration
                          (
                          hintText: 'Full Name',
                          labelText: 'Name',
                          helperText: 'Plant care',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.account_circle),

                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
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
                      const SizedBox(
                        height: 20,
                      )
                      ,
                      TextFormField(
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

                      )
                    ],

                  )),
              const SizedBox(height: 20,),
              RoundButton(title: 'SignUp ',
                loading: loading,
                onTap: (){
                  if(_formKey.currentState!.validate()) {
                    signup();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }},),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account '),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                  }, child:const Text('Login')),
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
