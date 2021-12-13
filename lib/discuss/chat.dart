import 'package:chat_b3/Model/Profil.dart';
import 'package:chat_b3/helper/firestoreHelper.dart';
import 'package:chat_b3/myWidget/my_zone_texte.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Chat extends StatefulWidget{
  late Profil moi;
  late Profil partenaire;
  Chat({required this.moi, required this.partenaire});
  @override
  State<StatefulWidget> createState(){
    //TODO implement createState
    return ChatState();
  }
}


class ChatState extends State<Chat> {

  @override
  void initState() {
    super.initState();

  }

  Widget build(BuildContext context) {
      // TODO: implement build
    return Scaffold(

        appBar: AppBar(
        title: Text('Chat') ,
       centerTitle: true,



    ),
       body: Page(),
    );
  }

  Widget Page()
  {
    return Column(
      children: [
        new Flexible(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Text("Message changeant"),
            )
        ),
        Divider(height: 1.5,),

        //Zone de texte
        ZoneText(moi: widget.moi, partenaire: widget.partenaire)

      ],
    );
  }



}


/*
return ListTile(

                    title: Text(user.name),

                  );
 */