import 'package:cinema/src/pages/widgets/MovieHorizontal.dart';
import 'package:cinema/src/pages/widgets/card_widgt_swiper.dart';
import 'package:cinema/src/routas/Routas.dart';
import 'package:flutter/material.dart';

import 'src/pages/HomePage.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'HomePage',
      routes: getApplicationRoutes(),

    );
  }
}