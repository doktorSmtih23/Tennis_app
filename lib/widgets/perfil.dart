import 'package:flutter/material.dart';

class PerfilWigdet extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  MediaQueryData queryData = MediaQueryData();
  queryData= MediaQuery.of(context);
  
    
    return GestureDetector(
        child: Stack(alignment: Alignment.bottomLeft, children: <Widget>[
          Center(
            child: Card(
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 9,
              child: Image(
                image: AssetImage('assets/perfil_img.jpg'), 
                height: queryData.size.height*.28,
                width: queryData.size.width*.96,
                fit: BoxFit.contain,
                ),
              ),
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
