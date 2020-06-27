import 'package:flutter/material.dart';
import 'package:flutter_app/pages/addUser.dart';
import 'package:flutter_app/pages/createAccount.dart';
import 'package:flutter_app/pages/descrip.dart';
import 'package:flutter_app/pages/infouser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/pages/ListsUsers.dart';

import 'depot1.dart';
import 'listCompte.dart';

class GridDashboard extends StatefulWidget {

  final role;
  GridDashboard(this.role);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GridState();
  }

}
class GridState extends State<GridDashboard>{


  List<Items> myList=[];
  final Items item1 = new Items(
      title: "Creation  users",
      subtitle: "Creer vos utilisateurs",
      event: "",
      img: "assets/adduser.jpg",
      route : AddUserPage())
  ;

  final Items item2 = new Items(
      title: "Gestion users",
      subtitle: "Listez ,Bloquer ou modifier vos users",
      event: "",
      img: "assets/user.jpg",
      route : listUsers()
  );
  final Items item3 = new Items(
      title: "Creer Compte ",
      subtitle: "creer comptes partenaire",
      event: "",
      img: "assets/partner.png",
      route: descrip()
  );
  final Items item4 = new Items(
    title: "Faire Dépot",
    subtitle: "Déposer de l'argent pour un compte",
    event: "",
    img: "assets/depot.png",
    route: depot1()

  );
  final  Items item5 = new Items(
    title: "Affectation Comptes",
    subtitle: "Affecter vos Comptes à vos user",
    event: "",
    img: "assets/users.jpg",
    route: listCompte()
  );
  final Items item6 = new Items(
    title: "Envoyer",
    subtitle: "Envoyer de l'argent ",
    event: "",
    img: "assets/envoyer.jpg",
    route: InfoUser()
  );
  final Items item7= new Items(
    title: "Retirer ",
    subtitle: "Retirer de l'argent",
    event: "",
    img: "assets/retire.jpg",
  );
  getItems(){
    if(this.widget.role=="ROLE_ADMIN_SYST" || this.widget.role=="ROLE_ADMIN"){
      myList = [item1, item2, item3, item4];
    }if(this.widget.role=="ROLE_CAISSIER"){
      myList = [item4];
    }if(this.widget.role=="ROLE_PARTENAIRE" || this.widget.role=="ROLE_PADMIN"){
      myList = [item1,item2,item5,item6,item7];
    }if(this.widget.role=="ROLE_PUSER"){
      myList = [item6,item7];
    }
  }
@override
void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
  }


  @override
  Widget build(BuildContext context) {


    var color = 0xff453658;

    return Flexible(
      child:
      (myList!=[])?
      GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children:
          myList.map((data) {
            return new GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => data.route ),
                  );
                },
                child:
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white60, borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     ClipRRect(
                       borderRadius: BorderRadius.circular(100),

                       child:  Image.asset(
                         data.img,
                         width: 77,
                       ),
                     ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.title,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        data.subtitle,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.black38,
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.event,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.black38,
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ));
          }).toList())
            :null );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  var route ;
  Items({this.title, this.subtitle, this.event, this.img,this.route});
}
