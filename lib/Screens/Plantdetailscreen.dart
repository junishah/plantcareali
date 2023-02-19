import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PlantDetailScreen extends StatefulWidget {
  PlantDetailScreen({ Key? key,

    required this.Name,
    required this.Description,
    required this.Price,
    required this.Temprature,
    required this.image,
    required this.Humidity

  }) : super(key: key);
  final String Name;
  final String Description;
  String Price;
  String Temprature;
  String image;
  String Humidity;



  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {

  Future AddtoCart()async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    var CurrentUser = auth.currentUser;
    CollectionReference Collectionref = FirebaseFirestore.instance.collection("CartItems");
    return Collectionref.doc(CurrentUser!.email).collection("items").doc().set(
      {

        'Name': widget.Name,
        'price': widget.Price,
        'image': widget.image,
      }
    ).then((value) =>_onBasicAlertPressed(context) );
  }

  _onBasicAlertPressed(context) {
    Alert(
      context: context,
      title: "Alert",
      desc: "Yahooo!!! Added to Cart Sucessfully",
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
          backgroundColor: const Color.fromRGBO(197, 232, 183,1),

          body: SingleChildScrollView(
            child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.6,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: const [ BoxShadow(

                          color: Colors.white,
                          offset: Offset.zero,
                          blurRadius: 1,
                          spreadRadius: 3,


                        ),
                        ],
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)

                        )
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Container(
                                    height: 40,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(50),

                                    ),
                                    child: IconButton(onPressed: () {
                                      Navigator.pop(context);
                                    }, icon: const Icon(Icons.arrow_back_ios),
                                    ),
                                  )
                              ),
                              const Text('Plant Detail',
                                style: TextStyle(fontSize: 24),),
                              IconButton(onPressed: () {}, icon: const Icon(
                                  Icons.favorite))
                            ],
                          ),
                        ),
                        Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*.6,
                                   height: MediaQuery.of(context).size.height*0.4,
                                  decoration: const BoxDecoration(
                                    // borderRadius: BorderRadius.circular(50)

                                  ),
                                  child:Image.network(widget.image,

                                    ) ,
                                ),

                                Column(
                                  children: [
                                    const Text('Humidity',style: TextStyle( color: Colors.grey,fontSize:20),),
                                    Text(widget.Humidity,style: const TextStyle( color: Colors.green,fontSize:20),),
                                    const SizedBox(height: 20,),

                                    const Text('Temprature',style: TextStyle( color: Colors.grey,fontSize:20),),
                                    Text(widget.Temprature,style: const TextStyle( color: Colors.green,fontSize:20),)
                                  ],
                                ),


                              ],
                            ),

                       
                          ],
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:
                          [
                            Text(widget.Name,
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold,
                                  color: Colors.green),)
                          ],),

                        const SizedBox(height: 10,),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:
                          [
                            const Text('Price: ',style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold,
                                color: Colors.grey),),
                            Text(widget.Price,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold,
                                  color: Colors.green),)
                          ],),


                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [

                        Text('Overview', style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold,color: Color.fromRGBO(46, 182, 44,1)),)
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child:
                      ReadMoreText(
                        widget.Description,textAlign: TextAlign.justify,style: TextStyle(fontSize: 16,),
                        trimLines: 3,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.blueAccent),
                        lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.blueAccent),
                      )
                    // Text(
                    //     widget.overviewdata,textAlign: TextAlign.justify,
                    // ),
                  ),
                  SizedBox(height: 30,),


                  Container(
                    height: 50,
                    width: 200,

                    decoration: BoxDecoration(
                      color: Colors.green

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Icon(Icons.add_shopping_cart_outlined,color: Colors.white),
                      TextButton(
                          onPressed: (){

                        AddtoCart();
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadBook(bookk:widget.pth, bookname: widget.bookName,)));

                      }, child: Text('Add to Cart',style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.w600),)),
                    ],)
                  )



                ]
            ),
          )
      ),
    );
  }
}







