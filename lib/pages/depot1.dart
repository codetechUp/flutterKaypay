 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/interceptor.dart';
import 'package:flutter_app/pages/addDepot.dart';
import 'package:http_interceptor/http_with_interceptor.dart';
import 'depot2.dart';

class depot1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new depotState();
  }

}
class depotState extends State<depot1>{
  var error;
  final _formKey = GlobalKey<FormState>();
  TextEditingController numeroController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
          title: Text("Numéro de Compte", style: TextStyle(
              color: Colors.black87,

              ),
          ),
        backgroundColor: Colors.white,

      ),
      body: Material(
      elevation: 10.0,
      child:Container(

        child: ListView(
          children: <Widget>[
            SizedBox(height: 40),
            Container(
              child: Image(image: AssetImage('assets/deposit.jpg')),
            ),
            SizedBox(height: 50),
            Center(
              child:Text("Donner le numero de Compte",style:  TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),)
            ),
            SizedBox(height: 20),
            Container(
              child:  Form(
                key: _formKey,
                  child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: numeroController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                labelText: 'Numéro du compte ',
                                filled: true
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Container(
                            height: 50,

                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              child: Text('Continuer'),
                              onPressed: () {
                               getNum(numeroController.text)       ;                       },
                            )),
                        // Add TextFormFields and RaisedButton here.
                      ]

                  ),


            ),),
            (error!=null)?
           Center(
                child:Text(error)
            ):Container(),
          ],
        ),
      ),
    ));
  }
  void getNum(a) async {

    String url = "http://10.0.2.2:8000/api/comptes?numero="+a;
    var res = await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .get(url);

    print(res.body);


    print(res.statusCode);

    if(res.statusCode>=200 && res.statusCode < 400 ){
      var compte= json.decode(res.body)["hydra:member"];
      print(compte);
      if(!compte.isEmpty){



        String irip =compte[0]["@id"];



        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addDepot(irip: irip))

        );}else{
        setState(() {
          error="Partenaire n'existe pas";
        }); }
    }else{

      error=json.decode(res.body)['message'];
      print(error);

      if(error=="Invalid credentials."){
        setState(() {
          error="Identifiants Incorrects";
        });
      }else{
        setState(() {
          error="Partenaire n'existe pas";
        });
      }
    }}

}