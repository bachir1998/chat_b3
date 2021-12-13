import 'dart:typed_data';
import 'package:chat_b3/Model/Profil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';



class Firestorehelper{

  final firebase_Aut      =  FirebaseAuth.instance;
  final firebaseStorage   =  FirebaseStorage.instance;
  final cloudfFirestore   =  FirebaseFirestore.instance;
  final firestore_user  =  FirebaseFirestore.instance.collection("user");
  final firestockageImage =  FirebaseStorage.instance.ref("imageProfil");


  //Méthode
  register(String email, String password,Map<String, dynamic> map) async{
    try
    {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!; //pour déclarer qu'une variable peut être nulle ou non nulle
      String uid = user.uid;
      /* Map <String, dynamic> map = {
        "nom" : nom,
        "prenom" : prenom
      };*/

      addUser(map, uid);

    }
    catch(e)
    {
      print(e);

    }

  }

  Future <User> connect(String email, String password) async{
    var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    User user = result.user!; //pour déclarer qu'une variable peut être nulle ou non nulle
    return user;
  }

  addUser(Map<String,dynamic> map, String identifiant){

    firestore_user.doc(identifiant).set(map);

  }

  Future <String> stockageImage(String name, Uint8List bytes) async{
    //Stockage de l'image dans la base de données
    TaskSnapshot download = await FirebaseStorage.instance.ref("profil/$name").putData(bytes);
    // recupération du chemin de l'image dans la base de données
    String url = await download.ref.getDownloadURL();
    return url;
  }




  String getIdentifiant()
  {
    //recupérer l'identifiant  de l'utilisateur connecté
    String id;
    id = FirebaseAuth.instance.currentUser!.uid;
    return id;
  }

  Future<Profil> getProfil(String identifiant)async
  {
    //recupération de la collection et le document dans la base de données
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("user")
        .doc(identifiant).get();
    // construction du type profil dans notre exemple
    return Profil(snapshot);
  }
}




