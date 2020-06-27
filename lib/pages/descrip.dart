import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/addPartner.dart';
import 'package:flutter_app/pages/createAccount.dart';
import 'package:flutter_app/pages/getNinea.dart';

class descrip extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new description();
  }

}
class description extends State<descrip>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blue, //change your color here
        ),
        title: Text("Creation compte", style: TextStyle(
          color: Colors.blue,
        ),
        ),
        backgroundColor: Colors.white,

      ),
      body: Container(
         child:Column(
           children: <Widget>[
             Container(
               child: Center(
                 child:   Image(image: AssetImage('assets/decript.jpg')),
               )
             ),
             Column(
               children: [
                 Container(
                    height: 50,
                    margin: EdgeInsets.all(10),
                    child:ButtonTheme(
                    minWidth: 200.0,
                    height: 100.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(color: Colors.white)
                      ),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                   child: RaisedButton(
                     textColor: Colors.white,
                     color: Colors.blue,
                     child: Text('Créer Compte Nouveau Partenaire'),
                     onPressed: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => addPartner() ),
                       );
                     },
                   ),

                 )),
                 SizedBox(
                   height: 25,
                 )
                 ,
                 Container(
                    height: 50,
                    margin: EdgeInsets.all(10),
                    child:ButtonTheme(
                    minWidth: 200.0,
                    height: 100.0,
                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                   child: RaisedButton(
                     textColor: Colors.blue,
                     color: Colors.white,
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(100),
                         side: BorderSide(color: Colors.white)
                     ),
                     child: Text('Créer Compte  Partenaire Exixtant'),
                     onPressed: () {

                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => getNinea()),
                       );

                       // Navigator.push(
                       // context,
                       //   MaterialPageRoute(builder: (context) => Home()),
                       // );

                     },
                   ),
                 ))
               ],
             )
           ],
         )
      ),
    );
  }

}