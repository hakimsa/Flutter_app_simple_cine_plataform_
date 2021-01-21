import 'dart:math';
import 'package:cinema/search/search_delegate.dart';
import 'package:cinema/src/pages/widgets/MovieHorizontal.dart';
import 'package:cinema/src/pages/widgets/card_widgt_swiper.dart';
import 'package:cinema/src/providers/Provider.dart';
import 'package:cinema/src/providers/Provider_Menu.dart';
import 'package:cinema/src/utils/Iconos_string_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/Pelicula.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  StateHomePage createState() => StateHomePage();
}

final peliculasProvider = new Provider();

class StateHomePage extends State<HomePage>
    with SingleTickerProviderStateMixin {
  static AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
              },
            )
          ],
          backgroundColor: Colors.green,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  toggle();

                },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                focusColor: Colors.green,

              );
            },
          ),
        ),
        body: AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Stack(
                children: <Widget>[
                  home(),
                  Transform.translate(
                    offset: Offset(38 * (animationController.value - 0.5), 0),
                    child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.020)
                          ..rotateY(-pi / 2 * animationController.value),
                        alignment: Alignment.center,
                        child: Drawer(
                          child: Menu(context),
                        )),
                  ),
                ],
              );
            })
    ); // drawer:Menu(context)
  }

  home() {
    return ListView(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetas(),
               Divider(),
              _Footer(context),
            ],
          ),
        )
      ],
    );
  }

  void toggle() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }

}

Widget _lista() {

  return FutureBuilder<List<dynamic>>(
      future: menuprovider.cargarDatos(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          CircularProgressIndicator(
            backgroundColor: Colors.orange,
          );
          if (snapshot.data != null) {
            return ListView(
              children: _ListaItems(snapshot.data, context),
            );
          } else {
            return CircularProgressIndicator(
              backgroundColor: Colors.orange,
            );
          }
        }return CircularProgressIndicator();
      });
}

List<Widget> _ListaItems(List<dynamic> data, BuildContext context) {
  final List<Widget> opciones = [];
  data.forEach((opc) {
    final listado = ListTile(
      title: Text(opc["texto"]),
      onTap: () {
        Navigator.pushNamed(context, opc['ruta']);
      },
      trailing: getIcon(opc["icono"]),

    );
    opciones..add(listado)..add(Divider());
  });
  return opciones;
}

Widget _swiperTarjetas() {
  return FutureBuilder(
      future: peliculasProvider != peliculasProvider.getPopulares()
          ? peliculasProvider.getEnCines()
          : null,
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          return CardWidgtSwiper(peliculas: snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });
}

Widget _Footer(BuildContext context) {
  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(

            padding: EdgeInsets.all(5.0),
            child: SizedBox(
                child: Container(

                  height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                'Populares',
                style: GoogleFonts.b612Mono(shadows: [
                  BoxShadow(
                    color: Colors.green
                  )
                ]),
              ),
            )) //Theme.of(context).textTheme.subhead
            ),
        SizedBox(height: 5.0),
        StreamBuilder(
          stream: peliculasProvider.popularesStream,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
               var _peliculas=snapshot.data;
              return Movie_Horizontal(
                peliculas: _peliculas,
                siguientepaina: peliculasProvider.getPopulares,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    ),
  );
}

Menu(BuildContext context) {
  return new Drawer(

      child: Column(children: [
    Expanded(
      flex: 1,
      child: Container(

        width: MediaQuery.of(context).size.width * 0.55,
        child: DrawerHeader(
          decoration: BoxDecoration(

              image: DecorationImage(
                  image: AssetImage("assets/movies.png"), fit: BoxFit.contain)),
          child: Text("Megarama",style: GoogleFonts.saira(color:Colors.green,fontSize: 32),),
        ),
      ),
    ),
    Expanded(
      flex: 1,
      child: Container(
          color: Colors.transparent,
          width: 250,
          child: _lista(),
         ),
    )
  ]));
}
