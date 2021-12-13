
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {

  late String idMessage;

  //émetteur
  late String from;

  //récepteur du message
  late String to;
  late String texte;
  late DateTime envoiMessage;


  Message(DocumentSnapshot snapshot){
    idMessage = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    from = map['from'];
    to = map['to'];
    texte = map['texte'];
    Timestamp time = map['envoiMessage'];
    envoiMessage = time.toDate();
  }


}