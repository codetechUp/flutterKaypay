import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/interceptor.dart';
import 'package:flutter_app/models/users.dart';
import 'package:flutter_app/pages/userpage.dart';
import 'package:flutter_app/services/CompteService.dart';
import 'package:flutter_app/services/userService.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'ListsUsers.dart';

// ignore: camel_case_types
class listCompte extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _listCompte();
  }
}
// ignore: camel_case_types
class _listCompte extends State<listCompte>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getusers();
  }
  var compteService =new CompteService()
  ;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text("Vos Comptes", style: TextStyle(
          color: Colors.black87,

        ),
        ),
        backgroundColor: Colors.white,

      ),
      body: Container(
        child: FutureBuilder(
          future: getusers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Container(
                child: Center(
                  child: Text('Chargement.....'),
                ),
              );
            }else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context ,int id){
                    return Container(
                      decoration:new BoxDecoration(
                        border:new Border(bottom:new BorderSide(color: Colors.grey)),

                      ),
                        child:ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => listUsers(iric:snapshot.data[id].iri) ),
                        );
                      },
                      leading: CircleAvatar(
                          radius: 20,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset("assets/depot.png"))
                      ),
                      title: Text(" "+snapshot.data[id].numero.toString(),
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700))),
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,

                          children:[
                            Text( FlutterMoneyFormatter(amount: (snapshot.data[id].solde)+00.000).output.nonSymbol.toString()+" XOF",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        color: Colors.green,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700))),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                              size: 24.0,
                            ),
                    Divider(
                    height: 1,
                    color:Colors.black
                    )

                          ]
                      ),
                    ));

                  });
            }

          },
        ),

      ),

    );
  }
  getusers() async {
    return this.compteService.getCompte();


  }
  toInt(n){
    return int.parse(n);
  }


}

