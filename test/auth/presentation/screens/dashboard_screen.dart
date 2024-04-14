
import 'package:equipo/src/features/auth/presentation/screens/splash_screen.dart';
import 'package:equipo/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../domain/repositories/auth_repository.dart';

class DashboardScreen extends StatelessWidget {
  final String userName;
  const DashboardScreen({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                    children:[
                      Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child:Container(
                                height:50,
                                width:50,
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  // color:Colors.grey.shade400,
                                ),
                                child:Image(
                                  image: AssetImage('assets/women.jpg',),
                                  fit: BoxFit.cover,
                                  height: 70.0,
                                  width: 70.0,),
                              ),),
                              SizedBox(width:10),
                              Column(mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Hello,",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
                                      Text(" $userName,",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  Text("Lets check lab & health reports"),
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SplashScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                        color:Colors.blue.shade50),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Icon(Icons.power_settings_new_sharp),
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                              color:Colors.blue.shade50),
                          child:Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Get tested at your home in",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16,)),
                                    SizedBox(height: 5,),
                                    Text("60 MINUTES",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),),
                                    SizedBox(height: 5,),
                                    MaterialButton(onPressed: (){},
                                      height: 40,
                                      minWidth: 120,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60),),
                                      color: MyColors.constantColor,
                                      child: Text("Order a test",style: TextStyle(fontSize: 16,color: Colors.white),),)
                                  ],
                                ),
                                Spacer(),
                                MaterialButton(onPressed: (){},
                                    height: 60,
                                    minWidth: 60,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60),),
                                    color: Colors.white,
                                    child: Icon(Icons.location_on_rounded))
                              ],
                            ),
                          )
                      ),
                      SizedBox(height: 20,),
                      Container(
                          height: 210,
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                              color:MyColors.cardBackground),
                          child:Padding(
                              padding: const EdgeInsets.all(18),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Fullbody Checkup",style: TextStyle(
                                          fontWeight: FontWeight.bold,fontSize: 25,
                                          color: MyColors.cardColor)),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),
                                              color: Colors.deepPurple.shade50,),
                                            child: Icon(Icons.accessibility_new_outlined,color: Colors.deepPurple.shade400,size: 18),
                                          ),
                                          SizedBox(width: 10,),
                                          Text("78 parameters",style: TextStyle(
                                            fontWeight: FontWeight.w500,fontSize: 16,)),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),
                                              color: Colors.deepPurple.shade50,),
                                            child: Icon(Icons.sticky_note_2_outlined,color: Colors.deepPurple.shade400,size: 18,),
                                          ),
                                          SizedBox(width: 10,),
                                          Text("Report in 6 Hours",style: TextStyle(
                                            fontWeight: FontWeight.w500,fontSize: 16,)),
                                        ],
                                      ),
                                      Spacer(),
                                      MaterialButton(onPressed: (){},
                                        height: 40,
                                        minWidth: 120,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60),),
                                        color: MyColors.constantColor,
                                        child: Text("Book Now",style: TextStyle(fontSize: 16,color: Colors.white),),)
                                    ],),
                                  Spacer(),

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      width: 130,
                                      height: double.infinity,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),),
                                      child:Image(
                                        image: AssetImage('assets/lab.jpg',),fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,),
                                    ),
                                  ),

                                ],
                              )
                          )
                      ),
                      SizedBox(height: 15,),
                      Align(alignment: Alignment.centerLeft,
                          child: Text("Recent Consultation",style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18,))),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                        child:  Container(
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color:Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top:20,bottom: 20,left: 10,right: 10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    height:50,
                                    width:50,
                                    decoration:BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      color:Colors.grey.shade400,
                                    ),
                                    child:Image(
                                      image: AssetImage('assets/docter.jpg',),fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,),
                                  ),
                                ),
                                SizedBox(width:10),
                                Column(mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Dr. Andrew Grey",style: TextStyle(
                                          fontWeight: FontWeight.bold,fontSize: 18,)),
                                        SizedBox(width: 5,),
                                        Container(width: 10,height: 10,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(60),color: Colors.green),)
                                      ],
                                    ),
                                    Text("Psychologist, Ph.D",style: TextStyle(
                                        color: Colors.grey.shade400)),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("10:30",style: TextStyle(
                                          fontWeight: FontWeight.bold,fontSize: 18,)),
                                        SizedBox(width: 6),
                                        Container(decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.grey.shade300
                                        ),child: Padding(
                                          padding: const EdgeInsets.only(left:10,right: 10,top: 6,bottom: 6),
                                          child: Text("am",style: TextStyle(color: Colors.black,fontSize: 16),),
                                        ),),
                                        SizedBox(width: 10,),
                                        Container(decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: MyColors.constantColor
                                        ),child: Padding(
                                          padding: const EdgeInsets.only(left:10,right: 10,top: 6,bottom: 6),
                                          child: Text("15 Sept.22",style: TextStyle(color: Colors.white,fontSize: 16),),
                                        ),)
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                MaterialButton(onPressed: (){},
                                    height: 60,
                                    minWidth: 60,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60),),
                                    color: Colors.black,
                                    child: Icon(Icons.video_call_outlined,color: Colors.white,))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Align(alignment: Alignment.centerLeft,
                          child: Text("Report details",style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18,))),
                      SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Heart rate",style: TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 18,)),
                                  SizedBox(height: 3,),
                                  Text("Heart rate status & count report"),
                                ],
                              ),
                              Spacer(),
                              Text("87",style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 30,color: Colors.green)),
                              Text(" bpm",style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 18,)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Blood pressure",style: TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 18,)),
                                  SizedBox(height: 3,),
                                  Text("Blood pressure status & count report"),
                                ],
                              ),
                              Spacer(),
                              Text("120",style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 30,color: Colors.orange)),
                              Text(" bpm",style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 18,)),
                            ],
                          ),
                        ),
                      )
                    ]
                ),
              ),
            ),
          )
      );

  }
}
