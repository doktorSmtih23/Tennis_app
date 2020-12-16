import 'package:chat_app/widgets/perfil.dart';
import 'package:chat_app/widgets/tienda.dart';
import 'package:chat_app/widgets/usuarios.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 10)),
          Perfil_Wigdet(),
          Padding(padding: EdgeInsets.only(top: 10)),
          Usuarios_Wigdet(),
          Padding(padding: EdgeInsets.only(top: 10)),
          Tienda_Wigdet(),
        ]),
      ),
    );
  }
}




