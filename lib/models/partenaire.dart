import 'package:flutter_app/models/users.dart';

class Partner{
  String ninea;
  String rc;
  User users;

  Partner({this.ninea,this.rc,this.users});

  Map<String , dynamic> toJson()=>
      {
        'partenaire': {
          'rc':rc,
          'ninea':ninea,
          'users': {
            "prenom":users.prenom,
            "nom":users.nom,
            "username":users.username,
            "password":users.password,
            "email":users.email,
          }
        }


      };
}