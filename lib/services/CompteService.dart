import 'dart:convert';

import 'package:flutter_app/helpers/interceptor.dart';
import 'package:flutter_app/models/compte.dart';
import 'package:http_interceptor/http_with_interceptor.dart';

class CompteService {
  final  headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"

  };

  createCompte(compte) async{
    String url = "http://10.0.2.2:8000/api/users";

    return  await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .post(url,body:compte,headers: headers);




  }


  getCompte() async{
    String url = "http://10.0.2.2:8000/api/comptes";

    var res= await HttpWithInterceptor.build(
        interceptors: [ Interceptor() ])
        .get(url);
    var usera = json.decode(res.body);

    var user= usera["hydra:member"];
    List<Compte> users =[];

    for(var u in user){
      Compte mesuser=new Compte(id:u["id"],solde:u["solde"],numero:u["numero"],partner:u["partner"],depot:u["depot"],iri: u['@id']);
      users.add(mesuser);
    }
    return users;

  }

}