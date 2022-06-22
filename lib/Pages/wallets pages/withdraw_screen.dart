import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tezz_driver_app/Controller/WithdrawAmountPost.dart';
import 'package:tezz_driver_app/Controller/max_amount_withdraw.dart';
import 'package:tezz_driver_app/constant.dart';
class Withdraw_Screen extends StatefulWidget {
  final String token;
  const Withdraw_Screen({Key? key,required this.token}) : super(key: key);

  @override
  State<Withdraw_Screen> createState() => _Withdraw_ScreenState();
}

class _Withdraw_ScreenState extends State<Withdraw_Screen> {
  final TextEditingController amountController=TextEditingController();
  final GlobalKey <FormState> _key=GlobalKey<FormState>();
  final TextEditingController note=TextEditingController();
  WithdrawMaxController withdrawMaxController=Get.put(WithdrawMaxController());
  WithdrawAmountController withdrawAmountController= Get.put(WithdrawAmountController());
  bool loading=false;
refresh(){
   Future.delayed(Duration(seconds: 3,),(){
     setState(() {
       loading=false;
     });
     Fluttertoast.showToast(msg: "${withdrawAmountController.massageError.first.message}");
   });

}
  @override
  void initState() {
    withdrawMaxController.getWithdrawMax();
  /*  Future.delayed(Duration(seconds: 3),(){
      print("withdero max body ${withdrawMaxController.withdrawMaxModel}");
      amountController.text=withdrawMaxController.withdrawMaxModel.first.toString();


    });*/

    super.initState();

  }
  @override
  void dispose() {


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Withdraw Request"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ModalProgressHUD(
          inAsyncCall: loading,
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Enter Amount",style: TextStyle(fontSize: 20,color: Scolor),)),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(

                      decoration: InputDecoration(
                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      controller: amountController,
                      style: TextStyle(fontSize: 14,color: Colors.grey),


                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: note,
                      maxLength: 20,
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "Note",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )),),),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    print("amount ${amountController.text}");
                    print("note coming from here ${note.text}");
                    setState(() {
                      withdrawAmountController.postWithdrowAmount(amountController.text, note.text,widget.token);
                    });
                   refresh();
                    loading=true;
                  },
                  child: const Text("submit"),
                ),
              ),
                  Padding(
                    padding:  EdgeInsets.only(left: 12.0,top: 10),
                    child: Text("Payment Instructions",style: TextStyle(fontSize: 16),),
                  ),
                  ListTile(
                    leading: Icon(Icons.double_arrow_rounded),
                    title: Text("Information provided by you to the Service for a bill payment to be made to your Payee (e.g., Payee name, account number, payment amount, payment date,",style: TextStyle(fontSize: 8),),
                  ),
                  ListTile(
                    leading: Icon(Icons.double_arrow_rounded),
                    title: Text("Information provided by Company to the Service for a bill payment to be made to the Biller (such as, but not limited to, Biller name, Biller Account number, and Scheduled Payment Date.",style: TextStyle(fontSize: 8),),
                  ),
                  ListTile(
                    leading: Icon(Icons.double_arrow_rounded),
                    title: Text(" Instruction of the Home DGS to the Host DGS for the payment of compensation to an eligible depositor by the Host DGS on behalf of the Home DGS.",style: TextStyle(fontSize: 8),),
                  ),
                  ListTile(
                    leading: Icon(Icons.double_arrow_rounded),
                    title: Text(" The balance of funds held by the Custodian representing net proceeds (after payment of expenses) received upon the sale of Shares are to be remitted in accordance with the provisions of this Custody Agreement as follows (select one)",style: TextStyle(fontSize: 8),),
                  )
                ],
              ),
            ),
          ),
        ),
      )

    );
  }
}
