import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/interceptor.dart';
import 'package:http_interceptor/http_with_interceptor.dart';

import 'dash.dart';

class affect extends StatefulWidget{
  String iric;
  String iriu;
  affect({this.iriu,this.iric});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _affect();
  }

}
class _affect extends State<affect>{
  DateTime _dateDebut;
  DateTime _dateFin;
  DateTime now =new  DateTime.now();


  DateTime selectedDate = DateTime.now();
  TextEditingController _date1 = new TextEditingController();
  TextEditingController _date2 = new TextEditingController();
  String error;

  Future<Null> _selectDate(BuildContext context,_date) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: (_dateDebut==null)? DateTime(now.year): DateTime(_dateDebut.year),
        lastDate: DateTime(now.year+1));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date.value = TextEditingValue(text: picked.toString());
      });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Container(
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

                  child:
                            Column(
                              children: [
                                GestureDetector(
                                onTap: () => _selectDate(context,_date1),
                  child: AbsorbPointer(
                    child: TextFormField(

                      controller: _date1,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        labelText: "Date Debut",
                        hintText: 'Date Debut',
                        prefixIcon: Icon(
                          Icons.dialpad,
                          color: Colors.blue,
                        ),

                      ),
                    ),
                  ),
                ),
                                SizedBox(
                        height: 15,
                      ),
                                GestureDetector(
                                  onTap: () => _selectDate(context,_date2),
                                  child: AbsorbPointer(
                                    child: TextFormField(

                                      controller: _date2,
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(100),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        filled: true,
                                        labelText: "Date Fin",
                                        hintText: 'Date Fin',
                                        prefixIcon: Icon(
                                          Icons.dialpad,
                                          color: Colors.blue,
                                        ),

                                      ),
                                    ),
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
                              child: Text("Faire l'affectation"),
                              onPressed: () {
doAffect();
                               // Navigator.push(
                                 // context,
                                 // MaterialPageRoute(builder: (context) => AddUserPage(partner:this.partner)),
                              //  );

                              },
                            )),),
                                (error==null)?Container():Container(
                                  child: Text(error),
                                )
                    ],
                  ))
            ],
          )
      ),
    );
  }
  void doAffect() async {
    var body;
    String url = "http://10.0.2.2:8000/api/affectations";
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"

    };
    body={
      "dateDebut": _date1.text,
      "dateFin":_date2.text,
      "comptes": widget.iric,
      "users": widget.iriu
    }
    ;
    var res= await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .post(url,body:json.encode(body),headers: headers);
    if(res.statusCode>=200 && res.statusCode < 400 ){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(sms:"Affectation réussie avec success")),
      );
    }else{
      error=json.decode(res.body)['message'];
      setState(() {
        error=error;
      });
    }

  }

}