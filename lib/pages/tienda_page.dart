import 'package:chat_app/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class TiendaPage extends StatelessWidget {
  static final String routeName = 'tienda';
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = TiendaPage.routeName;

    return SafeArea(
        child: Scaffold(
      body: Text('Tienda'),
    ));
  }
}
