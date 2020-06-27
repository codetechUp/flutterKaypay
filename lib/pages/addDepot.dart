import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/interceptor.dart';
import 'package:flutter_app/models/compte.dart';
import 'package:flutter_app/models/depot.dart';
import 'package:flutter_app/models/partenaire.dart';
import 'package:flutter_app/models/user.dart';
import 'package:http_interceptor/http_with_interceptor.dart';

import 'dash.dart';

class addDepot extends StatefulWidget{
 Compte compte;
 String iri;
 String irip;
  User user;
  addDepot({this.compte,this.iri,this.irip});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _addDepot();
  }

}
class _addDepot extends State<addDepot>{
  var error;
  final _formKey = GlobalKey<FormState>();
  TextEditingController montantController = TextEditingController();
Depot depot=new Depot();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Montant à Déposer", style: TextStyle(
          color: Colors.blue,

        ),
        ),
        backgroundColor: Colors.blue,

      ),

      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40,),
            Center(
              child:ClipRRect(
              borderRadius: BorderRadius.circular(100),

              child:  Image.asset(
                'assets/wallet.jpg',
                width: 277,
              ),
            )),
            SizedBox(height: 50),
            Center(
                child:Text("Montant à deposer",style:  TextStyle(
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
                          controller: montantController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            labelText: 'Montant à déposer ',
                            filled: true
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      (widget.irip ==null)?
                      Container(
                          height: 50,

                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text('Creer le compte'),
                            onPressed: () {
                              CreateCompte();


                            },
                          )):Container(
                          height: 50,

                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text('Faire le depot'),
                            onPressed: () {
                              doDepot();


                            },
                          )
                      ),

                      (error!=null)?
                      Container(
                          padding: EdgeInsets.all(10),
                          child:Text(error)
                      ):Container(),
                      // Add TextFormFields and RaisedButton here.
                    ]

                ),


              ),)
          ],
        ),
      ),
    );
  }

  void doDepot() async {
    var body;
    String url = "http://10.0.2.2:8000/api/depots";
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"

    };
    body={
      "montant": int.parse(montantController.text),
      "compte": widget.irip
    }
;
    var res= await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .post(url,body:json.encode(body),headers: headers);
    if(res.statusCode>=200 && res.statusCode < 400 ){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(sms:"Montant Déposer avec success")),
      );
    }else{
      error=json.decode(res.body)['message'];
      setState(() {
        error=error;
      });
    }

  }

  void CreateCompte() async {
var body;
    String url = "http://10.0.2.2:8000/api/comptes";
    depot.montant=int.parse(montantController.text);
    if(widget.compte!=null){
    widget.compte.depot=depot;
    body = widget.compte.toJson();
    }else{
       body= {
        'partenaire': widget.iri ,
        'depots':[{
          "montant":depot.montant
        }

        ]

      };;

    }


    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"

    };

    var res= await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .post(url,body:json.encode(body),headers: headers);
    print(res.statusCode);

    if(res.statusCode>=200 && res.statusCode < 400 ){

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(sms:"Compte crée avec success")),
      );
    }else{

      error=json.decode(res.body)['message'];
      print(error);

      if(error=="Invalid credentials."){
        setState(() {
          error="Identifiants Incorrects";
        });
      }else{
        setState(() {

          error=error;
        });
      }
    }}
  void _onLoading() {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            child: new Row(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  height: 100.0,
                  width: 90.0,
                ),
                SizedBox(
                  child: CircularProgressIndicator(),
                  height: 50.0,
                  width: 50.0,
                ),
                SizedBox(
                  child: CircularProgressIndicator(),
                  height: 10.0,
                  width: 10.0,
                ),
                Text("KayPay Transfert")
              ],)
        )
        ;
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog

    });
  }
}