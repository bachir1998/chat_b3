
import 'package:chat_b3/Model/Profil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation{

  late String idConversation;
  late String idMoi;
  late String lastMessage;
  late String destinataire;

  Profil user = Profil.vide();


  Conversation(DocumentSnapshot snapshot){
    idConversation = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map <String, dynamic>;
    lastMessage = map['lastMessage'];
    idMoi = map['idMoi'];
    user = Profil(snapshot);
    destinataire = user.uid;
  }
}