import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezz_driver_app/Controller/SignInController.dart';
import 'package:tezz_driver_app/OtpScreen.dart';
import 'package:tezz_driver_app/RegisterPage.dart';

import 'constant.dart';
class LoginPage extends StatefulWidget {

  static String id= "loginPage";
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
GlobalKey<FormState> _formKey=GlobalKey<FormState>();
class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle( fontSize: 20.0);
  SignInController signInController=Get.put(SignInController());
  TextEditingController phoneNo=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Image.asset("images/taxi2.jpg"),
              SizedBox(
                height: 50,
              ),
              Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Scolor),),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:  EdgeInsets.only(left: 30.0,right: 30),
                child: Container(
                 // width: 250,
                    child: TextFormField(
                      controller: phoneNo,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      validator: (val){
                        if(val!.isEmpty){
                          return "Please enter your mobile number";
                        }
                        else{
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 12),

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Mobile Number",
                        // border:
                        // OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    if(_formKey.currentState!.validate()){
                      signInController.fetchSignIn(phoneNo.text, "false", context);

                      _formKey.currentState!.save();
                    }
                  });
                },
                child: Container(
                  height: 40,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Scolor
                  ),
                  child: Center(child: Text("Login",style: TextStyle(color: Colors.white))),
                ),              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?"),
                  TextButton(onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterPage()));

                  }, child: Text("Register",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Scolor),))
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
