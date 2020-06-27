import 'package:flutter/material.dart';

class depot2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new depotState2();
  }

}
class depotState2 extends State<depot2>{
  var error;
  final _formKey = GlobalKey<FormState>();
  TextEditingController montantController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text("Montant à Déposer", style: TextStyle(
          color: Colors.black87,

        ),
        ),
        backgroundColor: Colors.white,

      ),

      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40,),
            Container(
              child: Image(image: AssetImage('assets/deposit.jpg')),
            ),
            SizedBox(height: 50),
           Center(
             child:Text("Donner le montant à déposer",style:TextStyle(
                 color: Colors.black54,
                 fontWeight: FontWeight.w100,
                 fontSize: 30
             )),),
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
                            border: OutlineInputBorder(),
                            labelText: 'Montant à déposer ',
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
                              // Navigator.push(
                              // context,
                              //   MaterialPageRoute(builder: (context) => Home()),
                              // );

                            },
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
    );
  }

}