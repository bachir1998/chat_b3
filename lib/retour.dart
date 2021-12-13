import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';


import 'helper/firestoreHelper.dart';

class Retour extends StatefulWidget{
  String email;
  String password;

  Retour({required String this.email, required String this.password});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //throw UnimplementedError();
    return RetourState();
  }

}


class RetourState extends State<Retour>{
  PageController controller = PageController(initialPage: 0);
  String nom = "";
  String prenom = "";
  String nameImage = "";
  var imageProfil;
  late Uint8List? byteImage;
  String pathImage = "";
  //DateTime dateNaissance = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Deuxième page'),
        centerTitle: true,
      ),
      body: bodyPage(),
    );
  }

  Widget bodyPage(){
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/1.5,
          width: MediaQuery.of(context).size.width,
          padding : const EdgeInsets.only(left:20,right:20),
          //pour silder
          child: PageView(
            controller: controller,
            scrollDirection: Axis.vertical,
            children:  [
              Center(
                child : recupererNom(),
              ),
              Center(
                child :  recupererPrenom(),
              ),
              recupererImage()


            ],
          ),
        ),

        ElevatedButton(
            onPressed: (){
              //print(dateNaissance);
              Map <String, dynamic> map = {
                "PRENOM": prenom,
                "NOM": nom,
                "IMAGE": pathImage
              };
              Firestorehelper().register(widget.email, widget.password, map);
            },
            child: const Text('Enregistrement'))
      ],
    );
  }

  Widget recupererNom()
  {
    return TextField(
        decoration : InputDecoration(
            hintText: 'Entrer votre nom',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )
        ),
        onChanged : (text){
          setState(() {
            nom = text;
          });
        }
    );
  }

  Widget recupererPrenom()
  {
    return TextField(
        decoration : InputDecoration(
            hintText: 'Entrer votre prénom',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )
        ),
        onChanged : (text){
          setState(() {
            prenom = text;
          });
        }
    );
  }


  recupererImage()
  {
    return Container(
        height: 100,
        child : ElevatedButton.icon(
          onPressed: (){
            importImage();
          },
          icon: Icon(Icons.upload),
          label: Text('image'),
        )
    );
  }

  importImage() async
  {
    //sélectionner image
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true
    );
    if(result!=null)
    {
      print(result.files.first.name);
      print(result.files.first.bytes);
      setState(() {
        byteImage = result.files.first.bytes;
        nameImage= result.files.first.name;
      });
      afficherImage();
    }
  }

  afficherImage()
  {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Image.memory(byteImage!, width: 250,height: 250,) ,
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Annuler")
              ),

              ElevatedButton(
                  onPressed: () async{
                    //stocker l'image dans la base de données
                    await Firestorehelper().stockageImage(nameImage, byteImage!).then((value){
                      setState(() {
                        pathImage = value;
                      });
                    });
                    Navigator.pop(context);


                  },
                  child: Text("Enregistrer")
              )





            ],
          );
        }
    );
  }

}







/*
Text("mon adresse mail est la suivante : ${widget.email} et le mot de passe est ${widget.password}",
         style: TextStyle(
           color : Colors.red,
           fontSize: 25
         ),),
      backgroundColor: Colors.amber,
 */



/*
return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate:DateTime(2040),
      initialDatePickerMode: DatePickerMode.day,*/

/*




Future dialogHeure async ()
  {
    await showDialog(
      context : context,
      builder : (BuildContext context){
        return DatePicker(
          DateTime(1970),
          width : 60,
          height: 60,
          onDateChange: (value){
            setState(() {

            });
          },
        );

      }
    );


  }

 */