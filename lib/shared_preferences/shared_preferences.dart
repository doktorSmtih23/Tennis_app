import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del Usuario
  get emailUsuario {
    return _prefs.getString('emailUsuario') ?? '';
  }

  set emailUsuario(String value) {
    _prefs.setString('emailUsuario', value);
  }

  get passUsuario {
    return _prefs.getString('passUsuario') ?? '';
  }

  set passUsuario(String value) {
    _prefs.setString('passUsuario', value);
  }

  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}
