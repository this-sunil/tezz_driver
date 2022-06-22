import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/SearchModel.dart';
import 'package:tezz_driver_app/Pages/TripDetailPage.dart';
List<SearchModel> suggestionList=[];
class SearchWidget extends SearchDelegate{
  final String token;
  final String type;
  Future<List<SearchModel>> fetchData() async{
   //
    // Fluttertoast.showToast(msg: "Call the method");
    final res=await http.get(Uri.parse("${baseUrl}api/driverBookingsListApi/$type"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer 63|8WHPCYHyB7wArNAZu18kutjGkTJozGuRZNLEeXTD',
      },

    );
    print(type);
    final result=searchModelFromJson(res.body);
    print(result);
    if(res.statusCode==200){
      suggestionList.clear();
      for(int i=0;i<result.data.length;i++){
        suggestionList.add(result);
        print(suggestionList[i].data.first.from);
      }
    }
    return suggestionList;
  }
  SearchWidget({required this.token,required this.type});
  @override
  String get searchFieldLabel =>'Search from ,destination location';
  @override
  TextStyle get searchFieldStyle => const TextStyle(fontSize: 16,fontFamily: "Bitter");


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.highlight_off), onPressed: (){
        query='';
        showSuggestions(context);
      })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation),

        onPressed: (){
          Navigator.pop(context);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<SearchModel>>(
      future: fetchData(),
      builder: (context, snapShot){


        if(snapShot.hasData){
          print(suggestionList.length);
          print(query);
          final suggestion=query.isEmpty  || snapShot.data!.isEmpty?[]:suggestionList.first.data.where((element) => element.from.toLowerCase().startsWith(query.toLowerCase().substring(0,query.length))).toList();
          print(suggestion.length);
          return suggestion.isEmpty?Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/no-data.png"),
              const Text("No Data Found"),
            ],
          )):ListView.builder(
              itemCount: suggestion.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    onTap: (){
                      Fluttertoast.showToast(msg: token);
                      Fluttertoast.showToast(msg:suggestion[index].destination);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TripDetailPage(id:suggestion[index].id,token: "63|8WHPCYHyB7wArNAZu18kutjGkTJozGuRZNLEeXTD", origin: suggestion[index].from, destination: suggestion[index].destination)));
                    },
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(suggestion[index].from),
                    trailing: Text(suggestion[index].rideType),
                    subtitle: Text(suggestion[index].destination,style: const TextStyle(color: Colors.grey,fontSize: 10),),
                  ),
                );
              });
        }

        return const Center(child:CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {


   return FutureBuilder<List<SearchModel>>(
     future: fetchData(),
     builder: (context, snapShot){


        if(snapShot.hasData){
          print(suggestionList.length);
          print(query);
          final suggestion=query.isEmpty || snapShot.data!.isEmpty?[]:suggestionList.first.data.where((element) => element.from.toLowerCase().startsWith(query.toLowerCase().substring(0,query.length))).toList();
          print(suggestion.length);
          return query.isEmpty?Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/no-data.png"),
              const Text("No Data Found"),
            ],
          )):ListView.builder(
              itemCount: suggestion.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    onTap: (){
                      showResults(context);
                    },
                    leading: const Icon(Icons.location_on_outlined),
                    title: RichText(text: TextSpan(
                      text: suggestion[index].from.substring(0,query.length),
                      style:const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: suggestion[index].from.substring(query.length),
                          style:const TextStyle(color: Colors.grey),
                        ),
                      ],
                    )),
                    subtitle: Text(suggestion[index].destination,style: const TextStyle(color: Colors.grey,fontSize: 10),),

                  ),
                );
              });
        }

        return const Center(child:CircularProgressIndicator());
       },
     );
  }

}