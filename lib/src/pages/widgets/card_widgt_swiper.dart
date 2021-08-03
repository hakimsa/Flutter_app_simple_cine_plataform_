import 'package:cinema/src/pages/models/Pelicula.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../pelicula_detalle.dart';

class CardWidgtSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;
  CardWidgtSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 10),

      child: Swiper(
        layout: SwiperLayout.STACK,
        itemHeight: 360,
        itemWidth: 195,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(

              placeholder: AssetImage('assets/original.gif'),
              image: NetworkImage(peliculas[index].getposterImg()),
              fit: BoxFit.cover,
            ),
          );
        },
        autoplay: true,
        itemCount: peliculas.length,
        scrollDirection: Axis.horizontal,
        onTap:(index){
          Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => DetailScreen(pelicula: peliculas[index]),
          ));

        }
        //pagination: new SwiperPagination(alignment: Alignment.bottomCenter),
        //   control: new SwiperControl(),
      ),
    );
  }
}

