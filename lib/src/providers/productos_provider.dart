import 'dart:convert';
import 'dart:io';

import 'package:formvalidation/src/models/product_model.dart';
import 'package:formvalidation/src/preferencia_usuario/preferencia_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ProductosProviders {
  final String _url =
      'https://flutter-varios-b6117-default-rtdb.firebaseio.com';

  final _prefs = new PreferenciasUsuario();

  //Crear productos
  Future<bool> crearProducto(ProductoModel producto) async {
    final url =
        '$_url/productos.json?auth=${_prefs.token}'; //Necesita del token para poder crear

    //Peticion post
    final resp = await http.post(url,
        body: productoModelToJson(producto)); //Producto en su forma string

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  //Mostrar Todos
  Future<List<ProductoModel>> cargarProductos() async {
    final url =
        '$_url/productos.json?auth=${_prefs.token}'; //Necesita token para poder ver
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
    final url =
        '$_url/productos/$id.json?auth=${_prefs.token}'; //Necesita token para poder borrar
    final resp = await http.delete(url);

    print(json.decode(resp.body));

    return 1;
  }

  //Editar producto
  Future<bool> editarProducto(ProductoModel producto) async {
    final url =
        '$_url/productos/${producto.id}.json?auth=${_prefs.token}'; //Necesita token para poder editar

    //Peticion put
    final resp = await http.put(url,
        body: productoModelToJson(producto)); //Producto en su forma string

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/drkhlgi1o/image/upload?upload_preset=zvctjrcy');

    final mimeType = mime(imagen.path).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        //                      imagen    tipo(jpg,png,gif,etc)
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    //Se manda la peticion
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salió mal');
      print(resp.body);
      return null;
    }

    //Extraer direccion de img
    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }
}
