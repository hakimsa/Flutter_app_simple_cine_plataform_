import 'package:cinema/src/providers/ProviderActors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'actor_detalles.dart';
import 'models/Actor.dart';
import 'models/Pelicula.dart';
import 'widgets/listado.dart';

class DetailScreen extends StatelessWidget {

  final Pelicula pelicula;
  List<Actor> actores;


  DetailScreen({Key key, @required this.pelicula, Actor actor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: postera(context));
  }

  poster() {
    return Stack(
      children: <Widget>[
        Column(children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: FadeInImage(
              fadeInCurve: Curves.fastOutSlowIn,
              fadeOutDuration: Duration(seconds: 5),
              placeholder: AssetImage('assets/original.gif'),
              image: NetworkImage(pelicula.getposterImg()),
              fit: BoxFit.cover,
            ),
          ),
        ]),

        valoracion(),

        // height: 300,
      ],
    );
  }

  Titulo() {
    return Positioned(
      child: Text(
        pelicula.title,
        style: GoogleFonts.pacifico(color: Colors.blueGrey, fontSize: 46),
      ),
      left: 150,
      bottom: 140,
    );
  }

  info() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SpecsBlock(
          label: 'Adult',
          value: pelicula.adult == false ? "Si" : "No",
          icon: Image.network(
              "http://icons.iconarchive.com/icons/google/noto-emoji-symbols/24/73038-no-one-under-eighteen-icon.png"),
        ),
        SpecsBlock(
          label: 'vote count  ',
          value: pelicula.voteCount.toString(),
          icon: Image.network(
              "http://icons.iconarchive.com/icons/graphicloads/colorful-long-shadow/24/Hand-thumbs-up-like-2-icon.png"),
        ),
        SpecsBlock(
          label: 'Popularity',
          value: pelicula.popularity.toString(),
          icon: Image.network(
              "http://icons.iconarchive.com/icons/graphicloads/colorful-long-shadow/24/People-icon.png"),
        ),
      ],
    );
  }

  descripcion() {
    return Row(
      children: <Widget>[
        Hero(
          tag: pelicula.id,
          child: Card(
            elevation: 10,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.3)),
            child: Container(
              child: SizedBox(
                child: Image.network(pelicula.getposterImg()),
                width: 90,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
            child: BorderedContainer(
                padding: const EdgeInsets.all(0),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  subtitle: valoracion(),
                  title: Text(
                    pelicula.originalTitle,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.acme(),

                  ), trailing: Image.network("http://icons.iconarchive.com/icons/sonya/swarm/64/Mayor-Clapper-icon.png"),
                )
            ))
      ],
    );
  }
  

  valoracion() {
    var ratio;
    if (pelicula.voteAverage >= 8.0) {
      ratio = 5.0;
    } else if (pelicula.voteAverage >= 7.1) {
      ratio = 4.0;
    } else if ((pelicula.voteAverage >= 5.0) |(pelicula.voteAverage == 6.7)) {

      ratio = 3.5;
    } else
      ratio = 2.0;
    return RatingBar(
      itemSize: 15.3,
      initialRating: ratio,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,

      itemPadding: EdgeInsets.symmetric(horizontal: 3.0)
    ,);
  }

  postera(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              pelicula.getposterImg(),
              fit: BoxFit.cover,
            )),
        SafeArea(

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
                      color: Colors.white,
                      textColor: Colors.grey,
                      minWidth: 0,
                      height: 40,
                      onPressed: () => Navigator.pop(context),
                    ),

                  ]),
                ),
                Spacer(),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white),
                        child: Column(
                            children: <Widget>[
                              const SizedBox(height: 30.0),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      info(),
                                      descripcion(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),

                                        child: Text(
                                          pelicula.id.toString(), style: TextStyle(
                                            color: Colors.grey.shade600
                                        ),),
                                      ),
                                      ExpansionTile(
                                        title: Text(
                                          "Show Actores", style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: const EdgeInsets.all(16.0),
                                            child: _crearCasting(pelicula),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ])))
              ],
            ))
      ],
    );
  }



  Widget _crearCasting(Pelicula pelicula){
    final actorProvider = new ProviderActor();

    return FutureBuilder(
      future: actorProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1
        ),
        itemCount: actores.length,
        itemBuilder: (context, index) {
         final card= Card(
            margin: EdgeInsets.all(5),
            elevation: 10,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.3)),
            child: Hero(
              tag: actores[index].id,
              child: Container(
                child: FadeInImage(
                  placeholder: AssetImage('assets/original.gif'),
                  image: NetworkImage(actores[index].getFoto()),
                  fit: BoxFit.cover,),

              ),

            ),

          );

          return GestureDetector(
              child: card,
              onTap: () =>
              {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActorDetalles(actor: actores[index]),
                  ),
                )});
        }));
  }

  Widget _actorTarjeta(Actor actor ) {
    return Container(
        child: Column(
          children: <Widget>[
           BorderedContainer(

             padding: const EdgeInsets.all(0),
             margin: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
            elevation: 20,
            color: Colors.blueGrey,
            child:  GestureDetector(
              onTap: (){
              /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => ActorDetalles(actor: actores[index]),
                ));*/

              } ,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(actor.getFoto()),
                  placeholder: AssetImage('assets/original.gif'),
                  height: 150.0,
                  fit: BoxFit.cover,
                  fadeOutDuration: Duration(seconds: 3),
                ),
              ),

            )
        ),
            Text(
              actor.name,style: GoogleFonts.actor(fontSize:12,shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
              overflow: TextOverflow.ellipsis,
            )
          ],
        )
    );
  }

}



