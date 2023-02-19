import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantcareali/Screens/Cart.dart';
import 'package:plantcareali/Screens/Herb.dart';
import 'package:plantcareali/Screens/Indoor.dart';
import 'package:plantcareali/Screens/Plantdetailscreen.dart';
import 'package:plantcareali/Screens/fruit.dart';


import 'Screens/plants catagory.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,


      bottomNavigationBar:
      Container( color: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.white10,
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.green.shade500,
            padding: const EdgeInsets.all(12),
            tabs:  [
              const GButton(icon: Icons.home, text: 'Home',),
              const GButton(icon: Icons.cloud, text: 'Seasonal',),
              GButton(icon: Icons.favorite,
                text: 'Favourite',),
              const GButton(icon: Icons.account_circle_rounded,
                text: 'Profile',)
            ],
          ),
        ),
      ),
      // drawer: AppDrawer(),
      appBar: AppBar(
automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        elevation: 02,
        title: const Text('Home',
          style: TextStyle(
              color: Colors.black,
            fontSize: 24
          ),
        ),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right:18.0),
            child: IconButton(
                onPressed: (){
                  Navigator.push(context,
                     MaterialPageRoute(builder: (context)=>const CartScreen()));
                },
                icon: const Icon(Icons.add_shopping_cart_rounded))
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              padding: const EdgeInsets.only(top: 5,left: 2,right: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    width: size.width*0.95,
                    height: size.height*0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [

                        SizedBox(width: 10,),
                        Expanded(

                            child: TextField (

                                decoration: InputDecoration(

                                  prefixIcon: Icon(Icons.search,color: Colors.black,),
                                    border: OutlineInputBorder(

                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    labelText: 'Search',
                                    hintText: 'Search',


                                ),
                            ),
                        ),
                           SizedBox(width: 20,),

                      ],

                    ),



                    ),



                ],

              ),
            ),


            SizedBox(height: 15,),
            Padding(

              padding: const EdgeInsets.only(left: 20.0),

              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(

                      children: const [
                        Expanded(
                            child: Text('Categories',textAlign: TextAlign.center,
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 20,
                       ),
                        )
                        ),

                      ],
                    ),
                    const SizedBox(height: 15,),

                    Container(
                      height: 100,
                      decoration: const BoxDecoration(

                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:  [

                          InkWell(
                              onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Herbs()));
                          },
                              child: const Plantscatagorycard(catagoryName: 'Herb Plants', icon:'AssetsDirectory/Images/Herbss.jpg' ,)),
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const IndoorPlants()));
                              },
                              child: const Plantscatagorycard(catagoryName: 'Indoor plants', icon:'AssetsDirectory/Images/Indoorss.jpg' ,)),
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const FruitPlants()));
                              },
                              child: const Plantscatagorycard(catagoryName: 'Fruit plants', icon:'AssetsDirectory/Images/Fruits.jpg' ,))
                        ],


                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25,),
            Container(
              child: const Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 40),
                child: Text('New Plants', style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold,
                ),
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),

              ),
              height: MediaQuery.of(context).size.height*0.32,
//General Plants
              child: StreamBuilder(
                 stream: FirebaseFirestore.instance.collection('General Plants').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  if(snapshot.hasError)
                    return Text('Some Error');
                  // final userSnapshot = snapshot.data?.docs;



                  return ListView.builder(

                    scrollDirection: Axis.horizontal,
                    itemCount:  snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, index) {

                      return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)
                            ),
                            width: MediaQuery.of(context).size.width*0.45,
                            height: MediaQuery.of(context).size.height*0.2,
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PlantDetailScreen(
                                      Name:snapshot.data?.docs[index]['Name'],
                                      Description: snapshot.data?.docs[index]['Description'],
                                      Price: snapshot.data?.docs[index]['price'],
                                      Temprature: snapshot.data?.docs[index]['Temprature'],
                                      image: snapshot.data?.docs[index]['image'],
                                      Humidity: snapshot.data?.docs[index]['Humidity'],) ));
                              },
                              child: Card(
                                color: Color.fromARGB(100, 98, 241, 99),
                                //color: Colors.green,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),

                                ),
                                elevation: 4,
                                child: Column(
                                  children: [
                                    ClipRRect(

                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Image.network(snapshot.data?.docs[index]['image'],
                                        height: 120, fit: BoxFit.fill,),
                                    ),
                                    const SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data?.docs[index]["Name"],
                                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                          const SizedBox(height: 3,),

                                          Row(
                                            children: [
                                              Text(snapshot.data?.docs[index]['category'],
                                                style: const TextStyle(color: Colors.blueAccent,fontSize: 20),)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(snapshot.data?.docs[index]['price'],
                                                      style: const TextStyle(color: Colors.green,fontSize: 20,
                                                      fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),



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

          ],
        ),
      ),
    );
  }





}



