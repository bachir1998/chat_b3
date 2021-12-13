import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:chat_b3/profil.dart';
import 'package:chat_b3/retour.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'helper/firestoreHelper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page')
      ,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String message = "non";
  //late String? mail;
  String mail = "";
  String passcode = "";

  // Toast pour Spécifier que la connexion est une réussite
  void LoginSucessfully(BuildContext context){
    AchievementView(
      context,
      title: "Yess",
      subTitle: "Connexion réussie                                  ",
      //onTab: _onTabAchievement,
      icon: Icon(Icons.insert_emoticon, color: Colors.white,),
      typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
      borderRadius: 5.0,
      color: Colors.greenAccent,
      textStyleTitle: TextStyle(),
      textStyleSubTitle: TextStyle(),
      alignment: Alignment.topCenter,
      duration: Duration(seconds: 3),
      isCircle: true,

    )..show();
  }

  // Toast pour Spécifier que la connexion a échoué

  void Loginfailed(BuildContext context){
    AchievementView(
      context,
      title: "Oups",
      subTitle: "Utilisateur inexistant dans la base données",
      //onTab: _onTabAchievement,
      icon: Icon(Icons.cancel, color: Colors.orangeAccent,),
      typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
      borderRadius: 5.0,
      color: Colors.red,
      textStyleTitle: TextStyle(),
      textStyleSubTitle: TextStyle(),
      alignment: Alignment.center,
      duration: Duration(seconds: 3),
      isCircle: true,

    )..show();
  }



  MessageError(){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            content: const Text('La saisie de votre mail ou password est éronnée'),
            actions: [
              ElevatedButton(
                  onPressed:(){
                    Navigator.pop(context);

                  },
                  child: const Text('OK')
              ),
            ],
          );
        });

  }

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double longueur = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(

          children :<Widget>[

            Container(
              width: largeur,
              height: 725,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [
                        Colors.blue.shade700,
                        Colors.blue.shade600,
                        Colors.blue.shade400
                      ]
                  )
              ),

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                    SizedBox(height:longueur/25),
                    Padding(
                      padding: EdgeInsets.all(20),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),),
                          SizedBox(height: longueur/100),
                          Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18))

                        ],

                      ),
                    ),
                    SizedBox(height: longueur/100),
                    Expanded(
                        child: Container(

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60))
                          ),

                          child: Padding(
                            padding: EdgeInsets.all(longueur/20),
                            child: Column(
                                children: <Widget>[
                                  SizedBox(height: longueur/20,), //pading de haut
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [BoxShadow(
                                            color: Colors.blue.shade700,
                                            blurRadius: 20,
                                            offset: Offset(2, 2)

                                        )]
                                    ),

                                    child: Column(
                                        children : <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(longueur/70),
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                            ),

                                            child: TextField(
                                              decoration: InputDecoration(
                                                  hintText: "Username ",
                                                  hintStyle: TextStyle(color: Colors.grey),
                                                  border: InputBorder.none
                                              ),
                                              onChanged: (String text){
                                                setState(() {
                                                  mail = text;
                                                });
                                              },
                                            ),
                                          ),

                                          Container(
                                            padding: EdgeInsets.all(longueur/70),
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                            ),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  hintText: "Password ",
                                                  hintStyle: TextStyle(color: Colors.grey),
                                                  border: InputBorder.none
                                              ),
                                              onChanged: (String text){
                                                setState(() {
                                                  passcode = text;
                                                  // print(message);
                                                });
                                              },
                                              obscureText: true,
                                            ),
                                          )

                                        ]
                                    ),
                                  ),
                                  SizedBox(height:longueur/20,),
                                  SizedBox(
                                    width: largeur/2,
                                    child: RaisedButton(
                                      child:Container(
                                        height: 60,
                                        margin: EdgeInsets.symmetric(horizontal:20),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Colors.green[500]
                                        ),

                                        child: Center(
                                            child: Text("Se connecter",style:TextStyle(color:Colors.white,fontSize:16,fontWeight: FontWeight.bold))
                                        ),
                                      ),
                                      onPressed: ()
                                      {
                                        Firestorehelper().connect(mail.toString().trim(),passcode.toString().trim()).then((value){
                                          LoginSucessfully(context);
                                          String identifiant = value.uid;
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (BuildContext context){
                                                //  return Retour(email: mail,password: passcode);
                                                return ProfilPage(identifiant: identifiant.toString().trim());

                                              }));
                                        }).catchError((erreur)
                                        {
                                          Loginfailed(context);
                                          MessageError();
                                        });

                                      },
                                      color: Colors.green[500],
                                      shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(50)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: longueur/20,),
                                  Text("Vous ne disposez pas  de compte ?",style: TextStyle(color: Colors.blue,fontSize:18,fontWeight: FontWeight.bold),),
                                  SizedBox(height:longueur/25,),

                                  SizedBox(
                                    width: largeur/2,
                                    child: RaisedButton(
                                      child:Container(
                                        height: 60,
                                        margin: EdgeInsets.symmetric(horizontal:20),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Colors.blue
                                        ),

                                        child: Center(
                                            child: Text("S'Inscrire ?",style:TextStyle(color:Colors.white,fontSize:16,fontWeight: FontWeight.bold))
                                        ),
                                      ),
                                      onPressed: (){
                                        //Firestorehelper().register(mail.toString().trim(), passcode.toString().trim(),'Gueye', 'Bachir Groo');
                                        Navigator.push(context, MaterialPageRoute(
                                            builder : (BuildContext context){
                                              return Retour(email : mail.toString().trim(),password:passcode.toString().trim());
                                            }
                                        ));

                                      },

                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(50)
                                      ),



                                    ),
                                  ),


                                ]
                            ),


                          ),
                        )
                    )

                  ]
              ),


            ),
          ]
      ),


    );
  }
}
