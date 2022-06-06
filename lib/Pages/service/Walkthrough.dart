import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:morphing_text/morphing_text.dart';
import 'package:tezz_driver_app/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 10),()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const LoginPage())));
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children:[
          Positioned(
            left: -100,
            top: 0,
            child: Container(
              width: 200,
              height: 100,
              decoration:  BoxDecoration(
                  color: Colors.pink.withOpacity(.8),

                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(200))
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: -100,
            child: Container(
              width: 200,
              height: 100,
              decoration:  BoxDecoration(
                  color: Colors.pink.withOpacity(.8),

                  borderRadius: BorderRadius.only(topLeft: Radius.circular(200))
              ),
            ),
          ),
          Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                child: Container(
                  width: 500,
                  height: 250,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("images/Brand.png"),
                    )
                  ),
                ),
              ),
            ),
            Center(
            child:Lottie.asset("images/animatecar.json"),


          ),

            const ScaleMorphingText(

              texts: [
                "Welcome to",
                "Tezz Driver",

              ],

              loopForever: true,
              textStyle: TextStyle(fontSize: 25),

            ),

          ],
        ),],
      ),
    );
  }
}