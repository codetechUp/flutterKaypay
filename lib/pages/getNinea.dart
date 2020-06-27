import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/interceptor.dart';
import 'package:flutter_app/models/compte.dart';
import 'package:flutter_app/models/depot.dart';
import 'package:flutter_app/models/partenaire.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/pages/addDepot.dart';
import 'package:http_interceptor/http_with_interceptor.dart';

import 'dash.dart';

class getNinea extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _getNinea();
  }

}
class _getNinea extends State<getNinea>{


  Compte comptes=new Compte();
  User users=new User();
  var error;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nineaController = TextEditingController();
  Partner partner=new Partner();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blue //change your color here
        ),
        title: Text("Ninea du Partenaire", style: TextStyle(
          color: Colors.blue,

        ),
        ),
        backgroundColor: Colors.white,

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
                child:Text("Entrer le ninea du partenaire",style:  TextStyle(
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
                          controller: nineaController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              labelText: 'Ninea du partenaire ',
                              filled: true
                          ),

                        ),
                      ),
                      Container(
                          height: 50,

                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text('Creer le compte'),
                            onPressed: () {
                              getNinea(nineaController.text);


                            },
                          )),
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

  void getNinea(a) async {

    String url = "http://10.0.2.2:8000/api/comptes?partenaire.ninea="+a;
    var res = await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .get(url);

    print(res.body);


    print(res.statusCode);

    if(res.statusCode>=200 && res.statusCode < 400 ){
      var compte= json.decode(res.body)["hydra:member"];
      print(compte.isEmpty);
      if(!compte.isEmpty){



         String iri=compte[0]["partenaire"]["@id"];



      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => addDepot(iri: iri))

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