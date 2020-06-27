import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/depot.dart';
import 'package:flutter_app/models/partenaire.dart';
import 'package:flutter_app/pages/addUser.dart';

class addPartner extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _addPartner();
  }

}

class _addPartner extends State<addPartner>{
  Partner partner=new Partner();
  Depot depot =new Depot();
  final _k = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blue, //change your color here
        ),
        title: Text("Partenaire", style: TextStyle(
          color: Colors.blue,

        ),
        ),
        backgroundColor: Colors.white,

      ),
      body:  Container(
          child:ListView(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Container(
                  child: Center(
                    child:   ClipRRect(
                      borderRadius: BorderRadius.circular(100),

                      child:  Image.asset(
                        'assets/partner.jpg',
                        width: 170,
                      ),
                    )
                  )
              ),
              SizedBox(
                height: 55,
              ),
              Center(
                child:Text("Informations Partenaire",style:  TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),)
              ),
              Form(
                key: _k,
                child:
                 Column(
                children: [
                  Container(
                    height:50,
                    margin: EdgeInsets.all(10),
                    child: TextField(

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,

                        labelText: "Ninea",

                      ),
                      onChanged: (val){
                        partner.ninea=val;
                        print(partner.ninea);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height:50,
                    margin: EdgeInsets.all(10),
                    child: TextField(

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        labelText: "Registre de Commerce",

                      ),
                      onChanged: (va){
                        partner.rc=va;
                      },

                    ),
                  ),
                  Container(

                      height: 50,
                      margin: EdgeInsets.all(10),
                      child:ButtonTheme(
                          minWidth: 200.0,
                          height: 100.0,
                          child:RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(color: Colors.white)
                        ),
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text('Continuer'),
                        onPressed: () {

                          Navigator.push(
                         context,
                             MaterialPageRoute(builder: (context) => AddUserPage(partner:this.partner)),
                          );

                        },
                      )),)
                ],
              ))
            ],
              )
      ),
    );
  }




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
