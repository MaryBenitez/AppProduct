import 'package:flutter/material.dart';

//Funcion que determina si es un numero o no
bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s); //Si se puede o no se puede parsear

  return (n == null) ? false : true;
}

//Ventana de alerta
void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información incorrecta'),
          content: Text(mensaje),
          actions: [
            FlatButton(
              child: Text('Ok!'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
