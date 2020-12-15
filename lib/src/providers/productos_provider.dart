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

  //Mostrar Todos
  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
    });
    return productos;
  }

  //Borrar Productos
  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));

    return 1;
  }

  //Editar producto
  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json';

    //Peticion put
    final resp = await http.put(url,
        body: productoModelToJson(producto)); //Producto en su forma string

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }
}
