import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/perfil_page.dart';
import 'package:chat_app/pages/tienda_page.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_pade.dart';
import 'package:chat_app/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'registro': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
  'home': (_) => HomePage(),
  'tienda': (_) => TiendaPage(),
  'perfil': (_) =>PerfilPage(),
};
