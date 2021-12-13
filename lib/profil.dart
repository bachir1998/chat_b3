import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Model/Parameter.dart';
import 'Model/Profil.dart';
import 'helper/firestoreHelper.dart';


class ProfilPage extends StatefulWidget{
  String identifiant;
  ProfilPage({required String this.identifiant});
  @override
  State<StatefulWidget> createState(){
    //TODO implement createState
    return ProfilPageState();
  }
}


class ProfilPageState extends State<ProfilPage>{
  Profil utilisateur = Profil.vide();

  int _selectedIndex = 0;
  PageController controller = PageController();
  bool isButtonDisabled = false;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[

    Text(
      'Index 0: Mon profil',
      style: optionStyle,
    ),
    Text(
      'Index 1: Utilisateurs',
      style: optionStyle,
    ),


  ];

  void _onItemTapped(int index) {

    setState(() {
      _selectedIndex = index;

      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Parameter()));

    });

    //Navigator.push(context, MaterialPageRoute(builder: (context)=>Parameter()));
  }




  @override
  void initState()
  {
    super.initState();
    Firestorehelper().getProfil(widget.identifiant)
        .then((value){
      setState(() {
        utilisateur = value;
      });
    });
  }
  Widget build(BuildContext context) {
    /*  // TODO: implement build
  Firestorehelper().getProfil(widget.identifiant)
        .then((value){
      setState(() {
        utilisateur = value;
      });
    });*/
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil') ,
        centerTitle: true,

      ),

      // Center(
      //         child: _widgetOptions.elementAt(_selectedIndex),
      //       ),

      body: bodyPage(),
      bottomNavigationBar:BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Mon Profil',
            backgroundColor: Colors.green,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.book_sharp),
            label: 'Utilisateurs',
            backgroundColor: Colors.red,
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (currenSelected){
          setState(() {
              _selectedIndex = currenSelected;
             controller.animateToPage(
                 _selectedIndex,
                 duration: Duration(seconds: 1),
                 curve: Curves.easeInOutExpo);
          });
        },
      ),

    );
  }

  Widget bodyPage()
  {
    return PageView(
      children: <Widget> [
       Text("Profil") ,
       Parameter(identifiant:widget.identifiant)



      ],
      controller: controller,
      onPageChanged: (value){
        setState(() {
           _selectedIndex = value;
        });
      },
    );

  }
}


/*Container(
        child: Column(
          children: [
            Center(
              child: Row( children: [

                Text(utilisateur.name,style: TextStyle(
                    color : Colors.blue,
                    fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),
                Text(" "),
                Text(utilisateur.lastname,style: TextStyle(
                    color : Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                ),),


              ],),
            ),

            Container(
                width: MediaQuery.of(context).size.width/2,
                height : MediaQuery.of(context).size.height/2,
                margin: EdgeInsets.all(50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image : DecorationImage(

                        image: NetworkImage(utilisateur.image),fit: BoxFit.fill

                      // Image.network(utilisateur.image)

                    )

                )
            ),


          ],
        ),
      ),*/

