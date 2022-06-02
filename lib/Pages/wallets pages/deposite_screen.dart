import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tezz_driver_app/Controller/WithdrawAmountPost.dart';
import 'package:tezz_driver_app/Controller/max_amount_withdraw.dart';
import 'package:tezz_driver_app/constant.dart';
class Deposite_Screen extends StatefulWidget {
  final String name;
  final String email;
  final String contact;
  const Deposite_Screen({Key? key,required this.name,required this.email,required this.contact}) : super(key: key);

  @override
  State<Deposite_Screen> createState() => _Deposite_ScreenState();
}

class _Deposite_ScreenState extends State<Deposite_Screen> {
  final TextEditingController amountController=TextEditingController();
  final GlobalKey <FormState> _key=GlobalKey<FormState>();
  final TextEditingController note=TextEditingController();
  WithdrawMaxController withdrawMaxController=Get.put(WithdrawMaxController());
  WithdrawAmountController withdrawAmountController= Get.put(WithdrawAmountController());
  Razorpay? _razorpay;
  void _handlePaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: "Success :" + "${response.paymentId}" ,timeInSecForIosWeb:4 );
  }
  void _handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: "Error "+"${response.code}"+"-"+"${response.message}",timeInSecForIosWeb: 4
    );
  }
  void _handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg:  "External_wallet"+"${response.walletName}",timeInSecForIosWeb: 4);

  }
  void openCheckOut() async{
    var options={
      'key': 'rzp_test_xG2kPI7zhUIyVb',
      'amount':int.parse(amountController.text)*100,
      'name': '${widget.name}',
      'description': note.text,
      'prefill': {'contact': '${widget.contact}', 'email': '${widget.email}'},
      'external': {
        'wallets': ['paytm']
      }

    };
    try{
      _razorpay!.open(options);
    }catch(e){
      print(e);

    }

  }
  @override
  void initState() {

    withdrawMaxController.getWithdrawMax();
    Future.delayed(Duration(seconds: 3),(){
      print("withdero max body ${withdrawMaxController.withdrawMaxModel}");
      amountController.text=withdrawMaxController.withdrawMaxModel.first.toString();

    });

    _razorpay=Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // TODO: implement initState
    super.initState();

  }
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(msg: widget.contact);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add to wallet"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
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
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )),),),
                  Center(
                    child: ElevatedButton(
                      onPressed: (){
                        print("amount ${amountController.text}");
                        print("note coming from here ${note.text}");
                        setState(() {
                          openCheckOut();
                        });


                      },
                      child: Text("submit"),
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
      ),

    );
  }
}
