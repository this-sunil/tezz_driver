//import 'dart:html';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:tezz_driver_app/Controller/WalletAPI/walletMainController.dart";
import 'package:http/http.dart'as http;
import 'package:tezz_driver_app/Pages/wallets%20pages/deposite_screen.dart';
import 'package:tezz_driver_app/Pages/wallets%20pages/withdraw_screen.dart';
import 'package:tezz_driver_app/constant.dart';
class WalletPage extends StatefulWidget {
  final String token;
  final String name;
  final String email;
  final String contact;
  const WalletPage({Key? key,required this.token,required this.name,required this.email,required this.contact}) : super(key: key);
  static String id = "walletPage";

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  var uri = 'https://idealcabs.in/api/getTransactionsListApi';
  var nexturl;
  List<Data> tempList = [];
  var loadCompleted = false;
  Future<List<Data>> getData(uri) async {
    final response = await http.get(Uri.parse(uri),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${widget.token}',
    });
    if (response.statusCode == 200) {
      var testJson = json.decode(response.body);
      var data = testJson['data'];
     if (testJson['next_page_url'] != null) {
        nexturl = testJson['next_page_url'];
      }/*else if(testJson['next_page_url'] == null){
        print("no data available");
        // Container(
        //   child: Text("no data avaialbe"),
        // );

      }*/
      else {
        loadCompleted = true;
      }
      for (var item in data) {
        Data data=
        Data(item["Id"], item["Note"], item["Status"], item["Amount"],item["Type"],item["TransactionNumber"],item["CreatedDate"]);
        tempList.add(data);
      }
      return tempList;
    } else {
      throw Exception('Failed to load Test');
    }
  }
  late Future<List<Data>> data;

  void scrollindecator() {
    _scrollController.addListener(
          () {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          print('reach to bottom botton');
          if (!loadCompleted) {
            setState(() {
              //add more data to list
              data = getData(nexturl) ;
            });
          }
        }
      },
    );
  }

  final ScrollController _scrollController = ScrollController();
  WalletController walletController = Get.put(WalletController());
  bool completed=true;
 // TransactionHistoryModel transactionHistoryModel=Get.put(TransactionHistoryModel());

  // nextPage() async {
  //   if (allLoaded) {
  //     return;
  //   }
  //   setState(() {
  //     loading = true;
  //   });
  //   await Future.delayed(Duration(milliseconds: 500));
  //   List<String> nextPageData = items.length >=
  //           walletNextPageController.walletModel.length
  //       ? []
  //       : List.generate(
  //           walletNextPageController.walletModel.length,
  //           (index) =>
  //               "${walletNextPageController.walletModel[index].walletBalance!.balanceAmount}"
  //                   +
  //               "${items.length}");
  //   if(nextPageData.isNotEmpty){
  //    for(int i=0;i>walletNextPageController.walletModel.length;i++){
  //
  //    }
  //   }
  //
  // }
/////////////////////////////////////////////////////////////////////////////////////////
//   mockFetch()async{
//     if(allLoaded){
//       return;
//     }
//     setState(() {
//       loading=true;
//     });
//     await Future.delayed(Duration(milliseconds: 500));
//     List<String> newData=items.length>=15
//         ?[]
//         :List.generate(10, (index) => "new item ${index+items.length}");
//     if(newData.isNotEmpty){
//       items.addAll(newData);
//     }
//     setState(() {
//        loading=false;
//        allLoaded=newData.isEmpty;
//        print("news data is empty now ${newData}");
//
//     });
//
//   }
  @override
  void initState() {
    walletController.fetchWallet(widget.token);
   setState(() {
     data = getData(uri) ;
   });
    scrollindecator();
    Future.delayed(Duration(seconds: 3),(){
      completed=false;
    });


  super.initState();
    //mockFetch();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels >=
    //       _scrollController.position.maxScrollExtent) {
    //     items.clear();
    //     print("wait for next Page");
    //     walletNextPageController.fetchWalletNextPage(walletController
    //         .walletModel.first.transactionsHistory!.nextPageUrl
    //         .toString());
    //     List<WalletModel> newData=walletNextPageController.walletModel.toList();
    //     items.addAll(newData);
    //     print(items.length);
    //
    //     print(
    //         "wallet Next Page se aa rha amount ${walletNextPageController.walletModel.first.walletBalance!.balanceAmount}");
    //     //
    //     // var a= walletController.walletModel.first.transactionsHistory!.nextPageUrl.toString();
    //     // print("Url Fron Next Page $a");
    //     //mockFetch();
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    walletController.walletModel.clear();
    super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          centerTitle: true,
          title: Text(
            "Available Balance",
            style: TextStyle(fontSize: 14),
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(150),
              child: Obx(() {
                return walletController.walletModel.isNotEmpty
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Text("Wallet Id :${walletController.walletModel.first.walletBalance!.walletId.toString()}",style: TextStyle(color: Colors.white),),

                              Center(
                                  child: Container(
                                      child: Text(
                                "\u{20B9} ${walletController.walletModel.first.balanceAmount}",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              )))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Withdraw_Screen(token: widget.token,)));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.account_balance_wallet_rounded,
                                        size: 28,
                                        color: Colors.white),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Withdraw",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (contex)=>Deposite_Screen(name: '${widget.name}', email: '${widget.email}', contact: '${widget.contact}',)));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  <Widget>[
                Icon(Icons.add_circle,size: 28,

                color: Colors.white),


                                   /* Image.asset("images/deposite.png",
                                        scale: 1.5),*/
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Add Wallet",
                                          style: TextStyle(color: Colors.white)),
                                    )],),
                              ),],),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:25,top: 8,bottom: 8),
                            child: Text("Transaction History",style: TextStyle(fontSize: 20,color: Colors.white),),
                          ),
                        ],
                      )
                    : Padding(
                      padding: const EdgeInsets.only(bottom: 60.0),
                      child: CircularProgressIndicator(color: Colors.white,),
                    );
              })),
        ),

        body: FutureBuilder(
          future: data,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return completed
                  ? Center(
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
              :Center(child: Text("No more Transaction Available "));
            } else {
//if (snapshot.connectionState == ConnectionState.done) {
              return
                  ListView.separated(
                    controller: _scrollController,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length + (loadCompleted?0:1),
                      itemBuilder: (BuildContext contex, int index) {
                        if (index == snapshot.data.length-1 &&
                            !loadCompleted) {
                          return
                               Center(
                            child: new Opacity(
                                opacity: 1.0,
                                child: CircularProgressIndicator(
                                  color: Scolor,
                                )
                            ),);

                        } else {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child:
                                  Text(snapshot.data[index].id.toString())),
                              title: Text(snapshot.data[index].transactionNumber),

                              subtitle: Text("\u{20B9} "+"${snapshot.data[index].credit}"),
                              trailing: Text(snapshot.data[index].status),
                              onTap: () {
                                print(index);
                              },
                            ),
                          );
                        }
                      },separatorBuilder: (context,index){
                      return Divider();
              },
//  },
                  );
            }},
        ));

  }
}
class Data {
  int id;
  String note;
  String status;
  String amount;
  String credit;
  String transactionNumber;
  String createdDate;

  Data(this.id, this.note, this.status, this.credit,this.createdDate,this.amount,this.transactionNumber);
}
//////////////////////////////////////
// ListView.builder(
//   controller: _scrollController,
//   itemBuilder: (BuildContext context, int index) {
//     // print("api data ${tempList.first.transactionsHistory!.data!.first.createdDate}");
//     if (tempList.isNotEmpty) {
//       return Container(
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     } else {
//       //if (snapshot.connectionState == ConnectionState.done) {
//       return ListView.builder(
//           physics: ScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: tempList.length,
//           itemBuilder: (BuildContext contex, int index) {
//             if (index == tempList.length - 1 &&
//                 !loadCompleted) {
//               return Center(
//                 child: new Opacity(
//                   opacity: 1.0,
//                   child: new CircularProgressIndicator(),
//                 ),
//               );
//             } else {
//               return ListTile(
//                 leading: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child:
//                     Text(tempList[index].transactionsHistory!.data![index].id.toString())),
//                 title: Text(tempList[index].transactionsHistory!.data![index].amount.toString()),
//                 // subtitle: Text(tempList[index].transactionsHistory!.data![index].email),
//                 trailing: Icon(
//                   Icons.info,
//                   color: Colors.blue,
//                 ),
//                 onTap: () {
//                   print(index);
//                 },
//               );
//             }
//           }
//         //  },
//       );
//     }
//   },
// ),
/////////////////////
///////////////////
// Obx(() {
//   return
//        ListView.builder(
//           controller: _scrollController,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(50.0),
//               child: ListTile(
//                 title: Text(allItems[index].walletBalance!.dateInString.toString()
//                    ,style: TextStyle(fontSize: 20),),
//               ),
//             );
//           },
//           itemCount:allItems.length);
//
// })
//////////////////////////////////////////////
// SingleChildScrollView(
//   child:Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text("Transactions",style: TextStyle(fontSize: 20),),
//       ),
//       Divider(),
//       ListView.builder(
//         controller: _scrollController,
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: 20,
//           itemBuilder: (context,index){
//             return
//               ListTile(
//                 leading: Icon(Icons.attach_money_rounded),
//                 title: Column(
//                   children: [
//                     Text("Id:${walletController.walletModel.first.transactionsHistory!.data!.first.id}",style: TextStyle(fontSize: 12),),
//                     Text("Transatction Number: ${walletController.walletModel.first.transactionsHistory!.data!.first.transactionNumber}",style: TextStyle(fontSize: 12))
//
//                   ],
//                 ),
//                 trailing: Column(
//                   children: [
//                     Text("\u{20B9} ${walletController.walletModel.first.transactionsHistory!.data!.first.amount}",style: TextStyle(fontSize: 12)),
//                     Text("${walletController.walletModel.first.transactionsHistory!.data!.first.status}",style: TextStyle(fontSize: 12),),
//
//
//                   ],
//                 ),
//
//               );
//           })
//     ],
//   ),
// )
/////////////////////////////////////////////////////////////////////////
// LayoutBuilder(builder: (context, constraints) {
//         return items.isNotEmpty
//             ?Stack(
//           children: [
//             ListView.separated(
//               controller: _scrollController,
//               itemBuilder: (context,index){
//                 return index<items.length
//                     ?ListTile(
//                   title: Text(items[index]),
//                 )
//                     :Container(
//                   width: constraints.maxWidth,
//                   height: 50,
//                   child: Center(child: Text("nothing more")),
//                 );
//               },
//               separatorBuilder: (context,index){
//                 return Divider();
//               },
//               itemCount: items.length+(allLoaded
//                   ?1
//                   :0),),
//             if(loading)...[
//               Positioned(
//                 left: 0,
//                 bottom: 0,
//                 child: Container(
//                   width: constraints.maxWidth,
//                   height: 80,
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//
//
//               ),
//             ],
//           ],
//         )
//             :Container(child: Center(child: CircularProgressIndicator()));
//
//       }
//
//       ),

// class Test {
//   final int id;
//   final String name;
//   final String email;
//   final String password;
//   Test(this.id, this.name, this.email, this.password);
// }
//////////////////////////
////////////////////////////////
