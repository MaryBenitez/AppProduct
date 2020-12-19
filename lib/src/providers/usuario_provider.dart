import 'dart:convert';

import 'package:formvalidation/src/preferencia_usuario/preferencia_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  /*Para que pueda hacer la peticion a Firebase 
    necesito una url particular*/

  final String _firebaseToken = 'AIzaSyDD8NqoqSCqdD9ZQOY0XgotpLod5YevtZM';
  final _prefs = new PreferenciasUsuario();

  //Obtengo el token
  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      //Para indicarle a Firebase que necesito el token de regreso
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    //OBTENGO EL TOKEN
    if (decodedResp.containsKey('idToken')) {
      //Guardo en el dispositivo
      _prefs.token = decodedResp['idToken'];

      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  //Verificar login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      //Para indicarle a Firebase que necesito el token de regreso
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    //OBTENGO EL TOKEN
    if (decodedResp.containsKey('idToken')) {
      //Guardo en el dispositivo
      _prefs.token = decodedResp['idToken'];

      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}
