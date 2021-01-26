// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.imagen,
    this.online,
    this.nombre,
    this.email,
    this.uid,
    
  });
  String imagen;
  bool online;
  String nombre;
  String email;
  String uid;
  

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        email: json["email"],
        uid: json["uid"],
        );

  Map<String, dynamic> toJson() => {
        "online": online,
        "imagen": imagen,
        "nombre": nombre,
        "email": email,
        "uid": uid,
       };
}
