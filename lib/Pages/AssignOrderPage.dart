import 'package:flutter/material.dart';
class AssignOrderPage extends StatefulWidget {
  const AssignOrderPage({Key? key}) : super(key: key);

  @override
  _AssignOrderPageState createState() => _AssignOrderPageState();
}

class _AssignOrderPageState extends State<AssignOrderPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:ListView.builder(
          itemCount: 20,
          itemBuilder: (context,index){
            return Card(child: ListTile(title: Text("$index")));
          }),
    );
  }
}
