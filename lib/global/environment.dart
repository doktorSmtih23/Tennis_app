import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.100.3:3000/api'//https://pure-brushlands-64301.herokuapp.com/api'
      : 'https://pure-brushlands-64301.herokuapp.com/api';
  static String socketUrl = Platform.isAndroid
      ? 'https://pure-brushlands-64301.herokuapp.com'
      : 'https://pure-brushlands-64301.herokuapp.com';
}
