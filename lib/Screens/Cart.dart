import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:plantcareali/Home_UI.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Cart"),),
      bottomNavigationBar: Container( color: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.white10,
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.green.shade500,
            padding: EdgeInsets.all(12),
            tabs:  [
              GButton(icon: Icons.home, text: 'Home',
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>HomePage()));
                },

              ),
              GButton(icon: Icons.cloud, text: 'Seasonal',),
              GButton(icon: Icons.favorite,
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>CartScreen()));
                },
                text: 'Cart',),
              GButton(icon: Icons.account_circle_rounded,
                text: 'Profile',)
            ],
          ),
        ),
      ),
      body: SafeArea(

        child:  StreamBuilder(   //<QuerySnapshot>
            stream:FirebaseFirestore.instance.collection("CartItems").doc
              (FirebaseAuth.instance.currentUser!.email).collection("items").snapshots(),

            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              if(snapshot.hasError);
              // final userSnapshot = snapshot.data?.docs;

              return ListView.builder(

                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.docs.length,

                itemBuilder: (context, index){
                  return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(


                        decoration: BoxDecoration(
                          // color: Colors.green,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        width: MediaQuery.of(context).size.width*0.40,
                        height: MediaQuery.of(context).size.height*0.28,
                        child: InkWell(
                          onTap: (){

                          },
                          child: Card(
                            //color: const Color(0xECFCD9),
                            //color: Color.fromRGBO(216, 252, 216,.8),



                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),


                            ),
                            elevation: 4,
                            child: Column(
                              children: [
                                ClipRRect(

                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),

                                  ),
                                  child: Image.network(snapshot.data?.docs[index]['image'],
                                    height: 120, fit: BoxFit.fill,),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(snapshot.data?.docs[index]["Name"],
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.green),),
                                      SizedBox(height: 3,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Price :' ,style: TextStyle(fontSize: 18),),
                                          Text(snapshot.data?.docs[index]['price'],
                                            style: TextStyle(color: Colors.green,fontSize: 18,
                                                fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          IconButton(onPressed: (){
                                            FirebaseFirestore.instance.collection("CartItems").
                                            doc(FirebaseAuth.instance.currentUser!.email).
                                            collection("items").doc(snapshot.data?.docs[index].id).delete();
                                          },
                                              icon: Icon(Icons.remove_shopping_cart, color: Colors.red,))
                                        ],
                                      )
                                    ],
                                  ),
                                )


                              ],
                            ),

                          ),
                        ),
                      )
                  );
                },
                //children: [


              );

            }
        ),
      ),
    );
  }
}
