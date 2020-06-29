import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'CryptoModel.dart';



void main() => runApp(MaterialApp(
  home: HomePage(),

));
class HomePage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();

}

// ignore: camel_case_types
class _homepageState extends State<HomePage> {
  
  String textt(String x){
    double y = double.parse(x);
    String z;
    if (y<0){
      z = 'red';
    }
    else{
      z = 'green';
    }
    return z;
  }


  @override
  Widget build(BuildContext context) {




    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Cryptocurrency',
        style: TextStyle(color: Colors.white,letterSpacing: 5, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Center(

        child: FutureBuilder(
          future: getCurrency(),
          builder: (context,snapshot){

            if (snapshot.hasData){
              final currency = snapshot.data;
              return ListView.builder(
                itemCount: 9,
                  itemBuilder: (context,index){
                    final curr = snapshot.data[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          color: Colors.grey[900],

                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Container(
                                    height: 100,
                                      child: Image.network('${curr['image']}')
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Name: ${curr['name']}',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                      SizedBox(height: 10,),
                                      Text('Current Price: ${curr['current_price']}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,fontWeight: FontWeight.w300,

                                        ),),
                                      SizedBox(height: 20,),

                                      Text('Price change in 24h: ${curr['price_change_24h']}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,fontWeight: FontWeight.w300,

                                        ),),



                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),

                        ),
                      ),
                    );

                  }
              );
            }
            else if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            else{
              return CircularProgressIndicator();
            }
          },
        ),

      ),


    );
  }
}


Future<List> getCurrency() async{

  String url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false';
  http.Response response = await http.get(url);

  if (response.statusCode == 200){
    final jsoncurrency = json.decode(response.body);
//    for(int i=0;i<10;i++){
//      return jsoncurrency.body[i]['name'];
//    }
    //return CryptoModel.fromJson(jsoncurrency[0]);
    return jsoncurrency;

  }
  else{
    throw Exception();
  }
}

