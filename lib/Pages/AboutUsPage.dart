import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/AboutUsmodel.dart';
class AboutUsPage extends StatefulWidget {
  final String token;
  const AboutUsPage({Key? key,required this.token}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {

 Stream<AboutUsModel> getData() async*{
    final res=await http.get(Uri.parse("${baseUrl}api/getAboutUsApi"));
   // Iterable data=jsonDecode(res.body);
    print("Response"+res.body);
    yield aboutUsModelFromJson(res.body);
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
/* final counter =
    Provider.of<NotificationCounters>(context, listen: false);*/

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us"
        ),
      ),
      body:StreamBuilder(
        stream: getData(),
        builder: (context,AsyncSnapshot<AboutUsModel> snapshot){
          if(snapshot.hasData){
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                    image: snapshot.data!.image.isEmpty?const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("images/image.png")):DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        baseUrl+snapshot.data!.image,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Card(
                    elevation: 20,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)
                        )
                    ),
                    margin: EdgeInsets.only(bottom:0,top: 0,left: 5,right: 5),
                    child:Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20,left: 10),
                              child: Text("${snapshot.data!.title}",style: Theme.of(context).textTheme.headline6,),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10,left: 10),
                              child: Text("${snapshot.data!.subtitle}",style: TextStyle(color: Colors.grey),),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("${snapshot.data!.description}"),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}
