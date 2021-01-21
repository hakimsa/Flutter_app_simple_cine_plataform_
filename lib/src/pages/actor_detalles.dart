import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/Actor.dart';


class ActorDetalles extends StatelessWidget {
  final Actor actor;
  ActorDetalles({Key key, @required this.actor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: <Widget>[
      fotoActor(),
      infoActor(),

      backButton(context)
    ])));
  }

  perfilActor() {
    String genero;
    if (actor.gender == 1) {
      genero =
          "http://icons.iconarchive.com/icons/icons-land/vista-people/64/Occupations-Actor-Female-Dark-icon.png";
    } else {
      genero =
      "http://icons.iconarchive.com/icons/icons-land/vista-people/64/Occupations-Actor-Male-Dark-icon.png";
    }
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: NetworkImage(genero),
    );
  }

  fotoActor() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.network(
          actor.getFoto(),
          fit: BoxFit.cover,
        ));
  }

  infoActor() {
    return Card(
        color: Color.fromRGBO(77, 77, 77, 0.65),
        elevation: 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 53,),
            Container(
              transform: Matrix4.rotationZ(773) ,
              color: Color.fromRGBO(77, 77, 77, 0.75),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              height: 250,
              child: ListTile(
                trailing: Hero(
                  tag: actor.id,
                  child: Container(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/original.gif'),
                      image: NetworkImage(actor.getFoto()),
                      fit: BoxFit.cover,),

                  ),

                ),
                leading: perfilActor(),
                title: Text(
                  actor.name,
                  style: GoogleFonts.acme(color: Colors.white, fontSize: 35),
                ),
                subtitle: Text(
                  actor.character,
                  style: GoogleFonts.aclonica(color: Colors.orangeAccent),
                ),
              ),
            ),
          ],
        ));
  }

  backButton(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              MaterialButton(
                padding: const EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Icon(Icons.arrow_back_ios),
                color: Colors.transparent,
                textColor: Colors.white,
                minWidth: 0,
                height: 40,
                onPressed: () => Navigator.pop(context),
              ),
            ]),
          ),
        ],
      ),
    );
  }


}
