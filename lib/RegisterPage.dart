import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezz_driver_app/Controller/RegistrationController.dart';
import 'package:tezz_driver_app/constant.dart';
class RegisterPage extends StatefulWidget {

  static String id = "Register";
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
RegistrationController registrationController=Get.put(RegistrationController());
late TextEditingController email;
late TextEditingController mobile;
late TextEditingController name;



final height = SizedBox(
  height: 10,
);
String? s;
refresh() async{

  name.clear();
  mobile.clear();
  email.clear();
}
class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
   setState(() {
     email=TextEditingController();
     mobile=TextEditingController();
     name=TextEditingController();
   });
    super.initState();
  }
  @override
  void dispose() {
    refresh();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Image.asset("images/taxi3.png"),
                SizedBox(height: 20,),
                Text(
                  "Register For Driver",
                  style: TextStyle(fontSize: 18,color: Scolor,fontWeight: FontWeight.bold),

                ),
                height,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val)=>val!.isEmpty?"Please Enter Name":null,
                    controller: name,
                    style: TextStyle(fontSize: 12),
                    decoration:
                    InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        hintText: "Name", contentPadding: EdgeInsets.all(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  TextFormField(
                    controller: mobile,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,

                    validator: (value){
                      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = RegExp(pattern);
                      if (value!.isEmpty) {
                        return 'Please enter mobile number';
                      }
                      else if (!regExp.hasMatch(value)) {
                        return 'Please enter valid mobile number';
                      }

                      return null;




                    },
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    onChanged: (val){
                      setState(() {
                       val=mobile.text;
                      });
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Mobile Number",
                      counterText: "",
                      prefixIcon: Icon(Icons.phone),

                    ),
                  ),
                ),
                height,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  TextFormField(
                      controller: email,
                      validator: (value){

                        if (value!.isEmpty) {
                          return 'This field is required';
                        }
                        if (!value.contains('@')) {
                          return "A valid email should contain '@'";
                        }
                        if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(value)) {
                          return "Please enter a valid email";
                        }


                      },
                      keyboardType: TextInputType.emailAddress,


                      decoration:
                      const InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline),
                          hintText: "Email", contentPadding: EdgeInsets.all(10))),
                ),
                height,
                InkWell(
                  onTap: () async{
                    if(_formKey.currentState!.validate()){
                       registrationController.postData(name.text, email.text, mobile.text,"false",context);
                      // debugPrint("status code ${registrationController.register.first.message}");
                      // print(registrationController.register.first.message);
                      //print("status code ${registrationController.registerError.first.message}");
                       //Fluttertoast.showToast(msg: registrationController.register.first.message);
                      print("main number ${mobile.text}");

                     // Navigator.push(context,MaterialPageRoute(builder: (context)=>OtpScreen(name.text, email.text,mobile.text, "+91")));
                      // refresh();

                      _formKey.currentState!.save();
                      //refresh();
                    }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Scolor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    height: 40,
                    width: 250,
                    child: Center(child: Text("Register",style: const TextStyle(color:Colors.white),)),
                    //color: Colors.cyan,
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
