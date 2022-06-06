import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezz_driver_app/MyHomePage.dart';
import 'package:tezz_driver_app/Pages/service/CurrentLocation.dart';
import 'package:tezz_driver_app/Pages/service/Walkthrough.dart';

late String data;
bool flag=false;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences=await SharedPreferences.getInstance();
  data=preferences.getString("key").toString();
  Fluttertoast.showToast(msg: "$data");

   await Firebase.initializeApp().then((value) => print("Firebase Connected ${value.isAutomaticDataCollectionEnabled}"));

   runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 @override
  void initState() {
 // Future.delayed(Duration(seconds: 5),()=>Navigator.pushReplacement(context, newRoute)),
  setState(() {
    if(data=="null"){
      flag=false;
      print("Token of sharedPreferences $flag");

    }
    else{
      flag=true;
      print("Coming started data with main $data");
    }

  });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrentLocation>(
      create: (_)=>CurrentLocation(),
      child: GetMaterialApp(
        title: 'Tezz Driver',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          fontFamily: 'Bitter',
          primarySwatch: Colors.deepOrange,

        ),
        home:flag==false?const SplashScreen():MyHomePage(token: "$data"),

      ),
    );
  }
}

