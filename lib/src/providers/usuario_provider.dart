import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {
  /*Para que pueda hacer la peticion a Firebase 
    necesito una url particular*/

  final String _firebaseToken = 'AIzaSyDD8NqoqSCqdD9ZQOY0XgotpLod5YevtZM';

  Future nuevoUsuario(String email, String password) async {
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

    //print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      //Salvar el token en el storage
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}
