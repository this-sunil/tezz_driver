import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezz_driver_app/LoginPage.dart';
import 'package:tezz_driver_app/MyProfile.dart';
import 'package:tezz_driver_app/Pages/wallets%20pages/main_wallets.dart';

import 'Pages/wallets pages/withdraw_screen.dart';

class DrawerWidget extends StatefulWidget {
  final String token;
  final String username;
  final String email;
  final String contact;
  const DrawerWidget({Key? key,required this.token,required this.username,required this.email,required this.contact}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {


bool selected=false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("${widget.username}"),
          accountEmail: Text("${widget.email}"),
          currentAccountPicture: const CircleAvatar(
            backgroundImage: AssetImage("images/taxi1.jpg"),

          ),
          otherAccountsPictures: [
            IconButton(
                color: Colors.white,
                onPressed: () async{
              SharedPreferences pref=await SharedPreferences.getInstance();
              setState(() {
                print("TOke n"+pref.getString("key").toString());
                pref.remove("key");
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPage()));
              });
            }, icon: const Icon(Icons.logout)),
          ],
          decoration:const BoxDecoration(
            color: Colors.deepOrangeAccent,
          ),

        ),

        ListTile(
          title: const Text('My Profile',style: TextStyle(fontSize: 12),),
          leading: const Icon(Icons.account_circle),

          onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfileDetails(token: widget.token)));

          },
        ),
        ListTile(
          title: const Text('Orders',style:  TextStyle(fontSize: 12)),
          leading: const Icon(Icons.history),

          onTap: () {
           // Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
          },
        ),
        ListTile(
          title: const Text('Wallet',style: TextStyle(fontSize: 12)),
          leading: const Icon(Icons.wallet_travel),

          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletPage(token: widget.token, name: '${widget.username}', email: '${widget.email}', contact: '${widget.contact}')));
          },
        ),
        ListTile(
          title: const Text('Account Statement',style: TextStyle(fontSize: 12),),
          leading: const Icon(Icons.chat_bubble_sharp),
          onTap: () {
           // Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQ()));
          },
        ),
        ListTile(
          title: const Text('My Documents',style: const TextStyle(fontSize: 12)),
          leading: const Icon(Icons.auto_stories_sharp),
          //trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
           // Navigator.push(context, MaterialPageRoute(builder: (context)=>TermAndCondition()));
          },
        ),
        ListTile(
          title: const Text('History',style: const TextStyle(fontSize: 12)),
          leading: const Icon(Icons.attach_money_sharp),
        // trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsAdd()));
          },
        ),
        ListTile(
          title: const Text('About Us',style: TextStyle(fontSize: 12)),
          leading: const Icon(Icons.info),
          //trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
          },
        ),
        ListTile(
          title: const Text('Membership',style: const TextStyle(fontSize: 12) ),
          leading: const Icon(Icons.local_fire_department_rounded),
         // trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
           // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          },
        ),
        ListTile(
          title: const Text('Privacy policy'),
          leading: const Icon(Icons.policy),
          onTap: () {
           // Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQ()));
          },
         ),
        ListTile(
          title: const Text('Share'),
          leading: const Icon(Icons.share),
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQ()));
          },
        ),

      ],
    );
  }
}
