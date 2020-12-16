import 'package:flutter/material.dart';

class Tienda_Wigdet extends StatelessWidget {
  
    @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Stack(alignment: Alignment.bottomLeft, children: <Widget>[
          Image(
            image: AssetImage('assets/tienda_img.jpg'),
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Align(
              child: Text(
            'Tienda',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          )),
        ]),
        onTap: () {
          Navigator.pushNamed(context, 'tienda');
        });
  }
}
