import 'dart:convert';

import 'package:formvalidation/src/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductosProviders {
  final String _url =
      'https://flutter-varios-b6117-default-rtdb.firebaseio.com';

  //Crear productos
  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';

    //Peticion post
    final resp = await http.post(url,
        body: productoModelToJson(producto)); //Producto en su forma string

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }
}
