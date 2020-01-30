import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String apiLink = 'https://blockchain.info/tobtc?currency=INR&value=';
  String message = "";

  TextEditingController valueContaroller = TextEditingController();

  Future getBitcoinPrice() async
  {
    var url = apiLink + valueContaroller.text.trim();
    var response = await http.get(Uri.encodeFull(url));

    var converted = json.decode(response.body);

    setState(() {
      message = "Bitcoin price: $converted";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bitcoin price app"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(

            children: <Widget>[

              TextField(
                controller: valueContaroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Enter a amount INR'
                ),
                keyboardType: TextInputType.number,
              ),

              Container(height: 20,),

              Container(
                width: double.infinity,
                child: MaterialButton(
                  padding: EdgeInsets.all(15),
                  color: Theme.of(context).textSelectionColor,
                  child: Text("Search"),
                  onPressed: getBitcoinPrice,
                ),
              ),

              Container(height: 40,),

              Text(
                message,
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}