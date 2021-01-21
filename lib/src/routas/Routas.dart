






import 'package:cinema/src/pages/HomePage.dart';
import 'package:cinema/src/pages/ver_pelicula.dart';

import 'package:cinema/src/pages/widgets/listado.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder>getApplicationRoutes(){
  return<String, WidgetBuilder>{
    'HomePage': (BuildContext context) => HomePage(),
 "BikeHomePage" : (BuildContext context) => BikeHomePage(),
    "VideoCard":(BuildContext context)=>VideoCard()



  };

}
