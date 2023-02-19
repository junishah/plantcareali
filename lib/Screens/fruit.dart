import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantcareali/Screens/Plantdetailscreen.dart';

class FruitPlants extends StatefulWidget {
  const FruitPlants({Key? key}) : super(key: key);

  @override
  State<FruitPlants> createState() => _FruitPlantsState();
}

class _FruitPlantsState extends State<FruitPlants> {
  // List<Map> Herbs = [
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Apricot.jpg',
  //
  //   },
  //
  //
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Guava.jpg',
  //
  //   },
  //
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Peach.jpg',
  //
  //   },
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Apple.jpg',
  //
  //   },
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Litchi.jpg',
  //
  //   },
  //
  //
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Citrus.jpg',
  //
  //   },
  //
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Cherry.jpg',
  //
  //   },
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Mango.jpg',
  //
  //   },
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Orange.jpg',
  //
  //   },
  //
  //
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Melon.jpg',
  //
  //   },
  //
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Banana.jpg',
  //
  //   },
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Grapes.jpg',
  //
  //   },
  //   {
  //
  //     'image': 'AssetsDirectory/Images/Fig.jpg',
  //
  //   },
  //
  //
  //   // {
  //   //
  //   //   'image': 'AssetsDirectory/Images/t1.jpg',
  //   //
  //   // },
  //   //
  //   // {
  //   //
  //   //   'image': 'AssetsDirectory/Images/t1.jpg',
  //   //
  //   // },
  //   // {
  //   //
  //   //   'image': 'AssetsDirectory/Images/t1.jpg',
  //   //
  //   // },
  //
  //
  //
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit Plants'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // StreamBuilder(
            //   stream: FirebaseFirestore.instance.collection("Tooth")
            //       .orderBy("date", descending: false).snapshots() ,
            //
            //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            //
            //     if(snapshot.hasData)
            //     {
            //       return ListView.builder(
            //         itemCount: snapshot.data.docs.length,
            //         padding: const EdgeInsets.only( top: 20.0),
            //         itemBuilder: (BuildContext context, int index) {
            //           DocumentSnapshot ds = snapshot.data.docs[index];
            //         },
            //       );
            //     }
            //
            //   },
            // ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),

              ),

              height: MediaQuery.of(context).size.height*0.9,
              child: StreamBuilder<QuerySnapshot>(   //<QuerySnapshot>
                  stream: FirebaseFirestore.instance.collection('FruitPlant').snapshots(),

                  builder: (context, AsyncSnapshot snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting)
                      return CircularProgressIndicator();
                    if(snapshot.hasError)
                      return Text('Some Error');
                     final userSnapshot = snapshot.data?.docs;


                    return ListView.builder(

                      scrollDirection: Axis.vertical,
                      itemCount: userSnapshot?.length,

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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PlantDetailScreen(
                                        Name:userSnapshot[index]['Name'],
                                        Description: userSnapshot[index]['Description'],
                                        Price: userSnapshot[index]['price'],
                                        Temprature: userSnapshot[index]['Temprature'],
                                        image: userSnapshot[index]['image'],
                                        Humidity: userSnapshot[index]['Humidity'],


                                      ) ));
                                },
                                child: Card(
                                  //color: const Color(0xECFCD9),
                                 // color: Color.fromRGBO(216, 252, 216,.8),



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
                                            Text(userSnapshot[index]["Name"],
                                              style: TextStyle(fontWeight: FontWeight.w900,fontSize: 28,color: Colors.green),),
                                            SizedBox(height: 3,),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('Price :' ,style: TextStyle(fontSize: 24),),
                                                Text(userSnapshot[index]['price'],
                                                  style: TextStyle(color: Colors.green,fontSize: 18),)
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

          ],
        ),
      ),
    );
  }
}

