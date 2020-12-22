import 'dart:io';

import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return SafeArea(
      child: Scaffold(
        body: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Text('Perfil',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        margin: EdgeInsets.all(20),
                        elevation: 9,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: ProfileImage()),
                  ),
                  Text(usuario.nombre, style: TextStyle(fontSize: 24)),
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
                  Text('Mi raqueta', style: TextStyle(fontSize: 24)),
                ],
              ),
            ],
          ),
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
    return Center(
      child: _image == null
          ? GestureDetector(
              child: Image(
                image: AssetImage('assets/tenista.gif'),
                fit: BoxFit.contain,
                height: 200,
                width: 150,
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
