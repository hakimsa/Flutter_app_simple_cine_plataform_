
import 'package:cinema/src/pages/models/Pelicula.dart';
import 'package:cinema/src/pages/pelicula_detalle.dart';
import 'package:flutter/material.dart';


class Movie_Horizontal extends StatelessWidget {
  final Function siguientepaina;
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);
  final List<Pelicula> peliculas;

  Movie_Horizontal({@required this.peliculas, @required this.siguientepaina}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              10.0, // horizontal, move right 10
              10.0, // vertical, move down 10
            ),
          )
        ],
        // borderRadius: new BorderRadius.all(...),
        // gradient: new LinearGradient(...),
      ),
      padding: EdgeInsets.all(8),
      width: double.infinity,
      child: _tarjetas(),
    );
  }

  Widget _tarjetas() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          child: PageView.builder(
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                _pageController.addListener(() {
                  if (_pageController.position.pixels >=
                      _pageController.position.maxScrollExtent)
                    siguientepaina();
                });

                final card = Card(
                  margin: EdgeInsets.all(5),
                  elevation: 10,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.3)),
                  child: Hero(
                    tag: peliculas[index].id,
                    child: Container(
                      child: FadeInImage(
                        placeholder: AssetImage('assets/original.gif'),
                        image: NetworkImage(peliculas[index].getposterImg()),
                        fit: BoxFit.fill,
                      ),

                    ),
                  )
                );

                return GestureDetector(
                  child: card,
                  onTap: ()=>
                  {

                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => DetailScreen(pelicula: peliculas[index]),
                  ),
                  )});
                  },
              itemCount: peliculas.length,
              scrollDirection: Axis.horizontal  )

        )
      ],
    );
  }
}


