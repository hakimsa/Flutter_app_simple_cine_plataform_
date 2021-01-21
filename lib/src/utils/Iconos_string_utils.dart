
import 'package:flutter/material.dart';



final _icons=<String,IconData>{

  "Icon-home" : Icons.home,
  "Icon-person" : Icons.person,
  "Icon-live_help" :Icons.live_help,
  "Icon-contacts" :Icons.contacts,
  "Icon-category" :Icons.category,
  "Icons.receipt" :Icons.receipt,
  "Icons.details" :Icons.details,
};

Icon getIcon(String nombreIcono){
  return Icon(_icons[nombreIcono],color: Colors.green,);

}