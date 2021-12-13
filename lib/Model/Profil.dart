import 'package:cloud_firestore/cloud_firestore.dart';

class Profil{

  String name = "";
  String lastname = "";
  String image = "";
  String uid="";

  Profil(DocumentSnapshot snapshot){
    uid = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String,dynamic>;
    name = map["PRENOM"] ;
    lastname = map["NOM"] ;
    image = map["IMAGE"];


  }

  Profil.vide();

  Map <String, dynamic> toMap(){
    Map<String, dynamic> map;
    return map = {
      'name': name,
      'lastname' : lastname,
      'image' : image,
      'uid': uid

    };
  }
}