import 'dart:io';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  
static final String routeName = 'perfil';

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

final prefs = new PreferenciasUsuario();
  
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = PerfilPage.routeName;
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    MediaQueryData queryData = new MediaQueryData();
    queryData = MediaQuery.of(context);


    return SafeArea(
      child: Scaffold(
        body: Stack(
          children:<Widget>[ 
           Image(image:AssetImage('assets/screen_1.jpg'),
           fit: BoxFit.cover,
           height:queryData.size.height*1.0),
           Column(
           children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 8),
            ),
            Text('Perfil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                          margin: EdgeInsets.all(20),
                          elevation: 9,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: ProfileImage()),
                    ),
                    Text(usuario.nombre, style: TextStyle(fontSize: 24,color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          elevation: 9,
                          margin: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: RacketImage()),
                    ),
                    Text('Mi raqueta', style: TextStyle(fontSize: 24,color:Colors.white)),
                  ],
                ),
              ],
            ),
          ]),
                  ]),
      ),
    );
  }

  // Future<void> retrieveLostData() async {
  //   final LostData response = await picker.getLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   if (response.file != null) {
  //     setState(() {
  //       if (response.type == RetrieveType.image) {
  //       } else {}
  //     });
  //   } else {}
  // }
}

class ProfileImage extends StatefulWidget {
  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final picker = ImagePicker();
  File _image;
  ImageSource _source = ImageSource.gallery;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: _source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQueryData();
    queryData = MediaQuery.of(context);
    return Center(
      child: _image == null
          ? GestureDetector(
              child: Container(
                height: queryData.size.height*.26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30)),
                child: Image(
                  image: AssetImage('assets/tenista.gif'),
                  fit: BoxFit.contain,
                  height: queryData.size.height*.39,
                  width: queryData.size.width*.45,
                ),
              ),
              onTap: () {
               getImage();
              })
          : Container(height: 200, width: 150, child: Image.file(_image)),
    );
  }
}

class RacketImage extends StatefulWidget {
  @override
  _RacketImageState createState() => _RacketImageState();
}

class _RacketImageState extends State<RacketImage> {
  final picker = ImagePicker();
  File _image;

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _image == null
          ? GestureDetector(
              child: Image(
                image: AssetImage('assets/raqueta.jpg'),
                fit: BoxFit.contain,
                height: 200,
                width: 120,
              ),
              onTap: () {
                getImage(ImageSource.gallery);
              })
          : Container(height: 200, width: 120, child: Image.file(_image)),
    );
  }
}
