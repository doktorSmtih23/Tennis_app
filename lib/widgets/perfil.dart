import 'package:flutter/material.dart';


class Perfil_Wigdet extends StatelessWidget {
  
    @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Stack(alignment: Alignment.bottomLeft, children: <Widget>[
          Image(
            image: AssetImage('assets/perfil_img.jpg'),
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Align(
              child: Text(
            'Perfil',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          )),
        ]),
        onTap: () {
          Navigator.pushNamed(context, 'perfil');
        });
  }
}
