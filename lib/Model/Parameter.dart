import 'package:chat_b3/discuss/chat.dart';
import 'package:chat_b3/helper/firestoreHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Profil.dart';



class Parameter extends StatefulWidget{
  String identifiant;
  Parameter({required String this.identifiant});
  @override
  State<StatefulWidget> createState(){
    //TODO implement createState
    return ParameterState();
  }
}


class ParameterState extends State<Parameter> {
  Profil utilisateur = Profil.vide();

  @override
  void initState() {
    super.initState();
    Firestorehelper().getProfil(widget.identifiant)
        .then((value) {
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


        body: bodyPage()
    );
  }


  Widget bodyPage() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestorehelper().firestore_user.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        else {
          List documents = snapshot.data!.docs;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, int index) {
                Profil user = Profil(documents[index]);
                return (user.uid != widget.identifiant) ?
                InkWell(
                    child : ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder : (BuildContext context){
                                return Chat(moi: utilisateur,partenaire: user,);
                              }
                          ));
                        },
                        title: Text(user.name+" "+user.lastname),
                      ),

                    ) : Container();
                /* return ListTile(
                      title: Text(user.name),
                    );*/

              }
          );
        }
      },
    );
  }

}


/*
return ListTile(

                    title: Text(user.name),

                  );
 */