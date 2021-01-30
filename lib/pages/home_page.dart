

import 'package:chat_app/shared_preferences/shared_preferences.dart';
import 'package:chat_app/widgets/perfil.dart';
import 'package:chat_app/widgets/tienda.dart';
import 'package:chat_app/widgets/usuarios.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  static final String routeName = 'home';
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = HomePage.routeName;
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
          //Padding(padding: EdgeInsets.only(top: 30)),
          PerfilWigdet(),
          //Padding(padding: EdgeInsets.only(top: 10)),
          UsuariosWigdet(),
          //Padding(padding: EdgeInsets.only(top: 10)),
          TiendaWigdet(),
        ]),
      ),
    );
  }
}




