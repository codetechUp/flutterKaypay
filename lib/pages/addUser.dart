import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_app/helpers/interceptor.dart';
import 'package:flutter_app/models/compte.dart';
import 'package:flutter_app/models/partenaire.dart';

import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/pages/addDepot.dart';
import 'package:flutter_app/pages/dash.dart';

import 'package:flutter_app/services/userService.dart';

import 'package:http_interceptor/http_interceptor.dart';

class AddUserPage extends StatefulWidget {
 Partner partner;
 AddUserPage({this.partner});
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  static User users=new User();

 UserService userService=new UserService();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
var selected;

List  roles;
User user;

  String token;

  @override
  void initState() {
    // TODO: implement initState
    if(widget.partner == null){
    this.getRoles();}
    super.initState();
    print(widget.partner);

  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar:AppBar(
          iconTheme: IconThemeData(
            color: Colors.blue, //change your color here
          ),
          title: Text("Creation user", style: TextStyle(
            color: Colors.blue,

          ),
          ),
          backgroundColor: Colors.white,

        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: ListView(
              children: <Widget>[
                Center(
                    child:   ClipRRect(
                      borderRadius: BorderRadius.circular(100),

                      child:  Image.asset(
                        'assets/adduser.jpg',
                        width: 170,
                      ),
                    )
                ),
                SizedBox(
                  height: 14,
                ),
                Center(
                    child:Text("Informations User",style:  TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),)
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: prenomController,

                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),

                      hintText: 'Prenom',
                      labelText: 'Prenom',
                      filled: true,

                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: nomController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),

                      labelText: 'Nom',
                        filled: true,
                      hintText: 'Nom'
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),

                      labelText: 'Username',
                      filled: true,

                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,

                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(8),
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
                      labelText: "email",

                    ),
                    obscureText: true,
                    controller: emailController,

                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                 Center(
                 child:  Container(
                     padding: EdgeInsets.all(8),
                     child:(widget.partner == null)? DropdownButton(
                       items:  roles.map((value)=>DropdownMenuItem(
                         child: Text(value['libelle']),
                         value : value['id'],
                       )).toList() ,
                       onChanged: (e){
                         setState(() {
                           selected = e;
                           print(selected);
                         });

                       },
                       value: selected,
                       hint: Text("Choisir son role"),
                     ):Container(

    )
                 ),
               ),

                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(color: Colors.white)
                      ),
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: (widget.partner == null)? Text('Créer l\'utilisateur') :Text('Continuer'),
                      onPressed: () {

                        if(widget.partner == null){
                           createUsers();
                        Navigator.push(
                         context,
                        MaterialPageRoute(builder: (context) =>  Home(sms:"Utilisateur Créee")),
                        );}else {

                          var compte = new Compte();
                          compte.partner=widget.partner;
                          users.username = usernameController.text;
                         users.prenom = prenomController.text;
                          users.nom = nomController.text;
                         users.password =
                              passwordController.text;
                        users.email = emailController.text;
                          compte.users=users;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => addDepot(compte:compte)));
                        }},
                    )),
              ],
            )));

  }
 void getRoles() async {

    String url = "http://10.0.2.2:8000/api/roles";

    var res = await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .get(url);

    print(res.body);
    var role = json.decode(res.body);
    print(role["hydra:member"]);

    setState(() {
      this.roles=role["hydra:member"];

    });

  }

  void createUsers() async {
   var  user={
      "prenom":prenomController.text,
      "nom":nomController.text,
      "username":usernameController.text,
      "password":passwordController.text,
      "email":emailController.text,
      "role":"api/roles/"+selected.toString()
    };
   print(user);
  var res= this.userService.createUser(json.encode(user));

   print(res);
  }




}

