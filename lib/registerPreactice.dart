import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tezz_driver_app/MyHomePage.dart';
import 'package:tezz_driver_app/OtpScreen.dart';
import 'package:http/http.dart'as http ;
import 'BaseUrl.dart';
import 'Model/RegistrationModel.dart';

class RegisterPageAuth extends StatefulWidget {
  static String id = "RegisterPractice";
  const RegisterPageAuth({Key? key}) : super(key: key);
  @override
  State<RegisterPageAuth> createState() => _RegisterPageAuthState();
}

 TextEditingController email=TextEditingController();
 TextEditingController phone=TextEditingController();
 TextEditingController name=TextEditingController();
final otpCOntroller = TextEditingController();
late String verificationId;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final height = SizedBox(
  height: 10,
);
final mobile = TextFormField(
  controller: phone,
 // validator: (value)=>value!.isEmpty?"plase add nuber":"",
  style: TextStyle(
    fontSize: 12,
  ),
  decoration: InputDecoration(
    contentPadding: EdgeInsets.all(10),
    hintText: "Mobile Number",
  ),
);
final Email = TextFormField(
  controller: email,
   // validator: (value)=>value!.isEmpty?"plase add email":"",
    style: TextStyle(fontSize: 12),
    decoration:
        InputDecoration(hintText: "Email", contentPadding: EdgeInsets.all(10)));
final Name = TextFormField(
  controller: name,
  //validator: (value)=>value!.isEmpty?"plase add name":"null",
  style: TextStyle(fontSize: 12),
  decoration:
      InputDecoration(hintText: "Name", contentPadding: EdgeInsets.all(10)),
);
// FirebaseAuth _auth = FirebaseAuth.instance;
 RegistrationModel? _user;



Future<RegistrationModel> registerModel (String email,String phone,String name,) async{
  RegistrationModel? registerUser;
  final response=await http.post(Uri.parse("${baseUrl}api/registerDriverApi"),body:{
    "name":name,
    "email":email,
    "mobile":mobile,
    "is_validated":"true",
  } );
  var jsonResponse= jsonDecode(response.body);
  registerUser=RegistrationModel.fromJson(jsonResponse);

  // if(response.statusCode==200){
  //   final String resSrtring=response.body;
  //   return  registrationModelFromJson(resSrtring);
  //
  // }else{
  //   print("error");
  // }
  return registerUser;
  // return registrationModelFromJson(response.body);


}



class _RegisterPageAuthState extends State<RegisterPageAuth> {
  @override
  void initState() {
    // email=TextEditingController();
    // phone=TextEditingController();
    // name=TextEditingController();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset("images/taxi3.png"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Register For Driver",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold),
                ),
                height,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Name,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: mobile,
                ),
                height,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Email,
                ),
                height,
                InkWell(
                  onTap: ()async {
                    print(email.text);
                    print(name.text);
                    print(phone.text);
                    final e=email.text;
                    final p=phone.text;
                    final n=name.text;
                    final RegistrationModel registers= await registerModel(e,p, n,);
                    setState(() {
                      _user=registers;
                    });

                    // print("error massege is here ${register.message.toString()}");
                    // print("error massege is here ${_user!.message.toString()}");
                    // Fluttertoast.showToast(msg: _user!.message.toString());
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => MyHomePage(
                    //         )));

                    // if(_formKey.currentState!.validate()){
                    //   //String is_validated="true";
                    //
                    //   _formKey.currentState!.save();
                    // }
                },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(10)),
                    height: 40,
                    width: 250,
                    child: Center(
                        child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    )),
                    //color: Colors.cyan,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
