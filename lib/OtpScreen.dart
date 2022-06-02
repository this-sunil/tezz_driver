import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tezz_driver_app/Controller/RegistrationController.dart';
import 'package:tezz_driver_app/Controller/SignInController.dart';
import 'package:tezz_driver_app/MyHomePage.dart';

class OtpScreen extends StatefulWidget {

  final String name;
  final String email;
  final String phone;
  final String countryCode;
  const OtpScreen(this.name,this.email,this.phone,this.countryCode) : super();
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}
class _OtpScreenState extends State<OtpScreen> {
  late String verificationCode;
  int start = 30;
  bool wait = false;
  SignInController signInController=Get.put(SignInController());
  RegistrationController registrationController=Get.put(RegistrationController());
  String otpNo="";
  final firstDigit = TextEditingController();
  final secondDigit = TextEditingController();
  final thirdDigit = TextEditingController();
  final fourthDigit = TextEditingController();
  final fifthDigit=TextEditingController();
  final sixthDigit=TextEditingController();
  Timer startTimer() {
    const onsec = Duration(seconds: 1);
    Timer time = Timer.periodic(onsec, (timer) {
      if (start == 0) {

          timer.cancel();
          wait = false;

      } else {
          start--;
      }
    });
    return time;
  }
  @override
  void initState() {
    print("main number from otp ${widget.phone}");
    verificationCode="";
    setState(() {
      verifyNumber();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [

                const SizedBox(
                  height: 18,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'images/illustration-3.png',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Verification',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Enter your OTP code number",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 28,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _textFieldOTP(first: true, last: false,otp:firstDigit),
                          const SizedBox(width: 2),
                          _textFieldOTP(first: false, last: false,otp: secondDigit),
                          const SizedBox(width: 2),
                          _textFieldOTP(first: false, last: false,otp:thirdDigit),
                          const SizedBox(width: 2),
                          _textFieldOTP(first: false, last: false,otp: fourthDigit),
                          const SizedBox(width: 2),
                          _textFieldOTP(first: false, last: false,otp:fifthDigit),
                          const SizedBox(width: 2),
                          _textFieldOTP(first: false, last: true,otp: sixthDigit),
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async{
                           try{
                             await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
                                 verificationId: verificationCode,
                                 smsCode: otpNo)).then((value){
                               if(value.user!=null){

                                 //Navigator.push(context,MaterialPageRoute(builder: (context)=>MyHomePage(token: )));
                               }
                               else{
                                 Fluttertoast.showToast(msg: "Please try again later...");
                               }
                                 });
                           }
                           catch(e){

                            }


                            setState(() {
                              Fluttertoast.showToast(msg:firstDigit.text+secondDigit.text+thirdDigit.text+fourthDigit.text+fifthDigit.text+sixthDigit.text);
                             if(widget.name.isEmpty && widget.email.isEmpty){
                               signInController.fetchSignIn(widget.phone, "true", context);
                             }
                             else{
                               registrationController.postData(widget.name, widget.email, widget.phone, "true", context);
                               //Navigator.push(context,MaterialPageRoute(builder: (context)=>OtpScreen(widget.token,widget.name, widget.email,widget.phone, "+91")));
                             }
                            });

                          },
                          style: ButtonStyle(
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.purple),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: const Text(
                              'Verify',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Didn't you receive any code?",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 18,
                ),
                TextButton(
                  onPressed: (){
                    setState(() {
                      //wait=true;
                      verifyNumber();
                      //startTimer();
                    });
                  },
                  child:Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        wait==true? RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Send OTP again in ",
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                TextSpan(
                                  text: "00:$start",
                                  style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                                ),
                                TextSpan(
                                  text: " sec ",
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ],
                            )):Text("Resend new code",  style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),),
                        Icon(Icons.refresh),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  verifyNumber() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
     SmsAutoFill().listenForCode;
    await _auth.verifyPhoneNumber(
        phoneNumber: widget.countryCode+widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          var appSignatureId = await SmsAutoFill().getAppSignature;
          Map sendOtp = {
            "mobile_number": "${widget.countryCode+widget.phone}",
            "app_signature_id": appSignatureId,
          };
          setState(() {
            SmsAutoFill().getAppSignature.then((signature) {
              print(signature);
              });

            firstDigit.text=credential.smsCode!.substring(0,1);
            secondDigit.text=credential.smsCode!.substring(1,2);
            thirdDigit.text=credential.smsCode!.substring(2,3);
            fourthDigit.text=credential.smsCode!.substring(3,4);
            fifthDigit.text=credential.smsCode!.substring(4,5);
            sixthDigit.text=credential.smsCode!.substring(5,6);
            otpNo=firstDigit.text+secondDigit.text+thirdDigit.text+fourthDigit.text+fifthDigit.text+sixthDigit.text;
          });
          print(sendOtp);
        },
        verificationFailed: (FirebaseAuthException e) async {
          Navigator.pop(context);
          Fluttertoast.showToast(msg:"Please try again later");
        },
        codeSent: (String verificationId, int? resendeingToken) {

            verificationCode = verificationId;
            Fluttertoast.showToast(msg: "Verification Code sent on your phone number");
            startTimer();
        },
        codeAutoRetrievalTimeout: (String verificationId) async {
            verificationCode = verificationId;
            Fluttertoast.showToast(msg: "Verification Code expired");
        });

  }

  Widget _textFieldOTP({required bool first, last,required TextEditingController otp}) {
    return Flexible(

      flex: 4,
      child: TextField(
        controller: otp,
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.length == 0 && first == false) {
            FocusScope.of(context).previousFocus();
          }
          print(otp);
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.purple),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

}

