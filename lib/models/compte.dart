import 'package:flutter_app/models/depot.dart';
import 'package:flutter_app/models/partenaire.dart';
import 'package:flutter_app/models/user.dart';

class Compte{

  Partner partner;
  User users;
  int id;
  int solde;
  int numero;
  String iri;


  Depot depot;
  Compte({this.id,this.solde,this.numero,this.partner,this.depot,this.iri});

  Map<String , dynamic> toJson()=>
      {
        'partenaire': {
          'rc':partner.rc,
          'ninea':partner.ninea,
          'users':[ {
            "prenom":users.prenom,
            "nom":users.nom,
            "username":users.username,
            "password":users.password,
            "email":users.email,
          }]
        },
        'depots':[{
          "montant":depot.montant
        }

        ]

      };
}