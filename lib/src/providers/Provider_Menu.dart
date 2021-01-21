import 'dart:convert';

import 'package:flutter/services.dart';

class _MenuProvider {
  List<dynamic> opciones = [];
  _MenuProvider() {
    // cargarDatos();
  }
  Future< List<dynamic>> cargarDatos() async {
    final respose = await rootBundle.loadString('data_local/data_local.json');
    Map dataMap = json.decode(respose);
    opciones = dataMap['rutas'];
    return opciones;
  }
}


final menuprovider = new _MenuProvider();
