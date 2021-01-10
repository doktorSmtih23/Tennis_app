import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.100.3:3001/api' //'https://pure-brushlands-64301.herokuapp.com/api'
      : 'https://pure-brushlands-64301.herokuapp.com/api';
  static String socketUrl = Platform.isAndroid
      ? 'http://192.168.100.3:3000'
      : 'https://pure-brushlands-64301.herokuapp.com';
}
