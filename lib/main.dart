import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezz_driver_app/LoginPage.dart';
import 'package:tezz_driver_app/MyHomePage.dart';
import 'package:tezz_driver_app/registerPreactice.dart';
late String data;
bool flag=false;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp().then((value) => print("Firebase Connected ${value.isAutomaticDataCollectionEnabled}"));
 SharedPreferences preferences=await SharedPreferences.getInstance();
  data=preferences.getString("key").toString();
  if(data!=null){
    flag=true;
    print("Token of sharedPreferences $flag");
    print("Coming started data with main $data");
  }

   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home:data==null?LoginPage():MyHomePage(token: data),
      routes: {
        LoginPage.id:(context)=>const LoginPage(),
       // RegisterPage.id:(context)=>RegisterPage(),
        MyHomePage.id:(context)=>const MyHomePage(token: '',),
        RegisterPageAuth.id:(context)=>const RegisterPageAuth(),
      }
    );
  }
}

