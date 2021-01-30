import 'package:flutter/material.dart';

class UsuariosWigdet extends StatelessWidget {
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQueryData();
    queryData = MediaQuery.of(context);
    return GestureDetector(
        child: Stack(alignment: Alignment.bottomLeft, children: <Widget>[
          Center(
            child: Container(
              height: queryData.size.height*.28,
              width: queryData.size.width*.95,
              child: Image(
                image: AssetImage('assets/usuarios_img.jpg'),
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
              child: Text(
            'Usuarios',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          )),
        ]),
        onTap: () {
          Navigator.pushNamed(context, 'usuarios');
        });
  }
}
