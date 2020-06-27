import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_route.dart';
import 'package:flutter_app/models/users.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_interceptor/http_with_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'griddashboard.dart';
import '../helpers/interceptor.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  String sms;
  Home({this.sms});
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {

  String username;
  var image;
  String role;
  User currentUser;


  @override
   void initState() {
    // TODO: implement initState
    super.initState();
    this.getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(

        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top:20,bottom: 20),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12)),
        child:
          Container(

              color: Colors.white,
            child:Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top:20),
                    alignment: Alignment.center,
                    child: Center(
                      child:CircleAvatar(
                          radius: 45,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child:(currentUser!= null)? Image.memory(base64.decode(currentUser.image),height: 125,width: 125,fit: BoxFit.cover,) : null)),

                    )),
                SizedBox(
                  height: 15,
                )
                ,
                Container(
                    alignment: Alignment.center,
                    child: Center(
                      child:Container(

                          child: Text(
                            (currentUser==null)? "Salut" : currentUser.prenom+" "+currentUser.nom ,
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),)

                    )),
                Container(
                    alignment: Alignment.center,
                    child: Center(
                        child:Container(

                          child: Text(
                            (currentUser==null)? "@" : "@"+currentUser.roles ,
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),)

                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                RaisedButton(
                 color:Colors.white,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.lock,color: Colors.blue),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text('Se Déconnecter', style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                  ],
                )
              ],
            )
          )),
          (role != null)?
          GridDashboard(role): Text('Chargement')
        ],
      ),
    );
  }


 void  getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("id");
    var role=prefs.getString('role');
    String url = "http://10.0.2.2:8000/api/users/"+id.toString();

    var res = await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .get(url);
   var user = json.decode(res.body);
    setState(() {

      //this.image=user['image'];

      currentUser=new User(user["prenom"],user["nom"],user["email"], user["password"], user['username'], user["roles"][0],user["image"],user["isActive"],user["id"]);

      //this.username=user["prenom"] + " "+ user["nom"];
      this.role=prefs.getString('role');

    });
    print(currentUser.roles);
    if(widget.sms==null){
      widget.sms="Bienvenue sur votre Dash";
    }
    showFlushbar(context: context, flushbar:  Flushbar(
      title: "Message",
      message:  widget.sms,
      duration: Duration(seconds: 6),
      icon: Icon(Icons.notifications_active,color: Colors.white),
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.BOTTOM,
    )..show(context));
  }
}
