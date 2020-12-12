import 'package:flutter/material.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

//Variable global
final formKey = GlobalKey<FormState>();

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          //Container mejor elaborado
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _crearNombre(),
                  _crearPrecio(),
                  _crearBoton(),
                ],
              )),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    //Trabaja directamente con un formulario, controlados el estado
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      onPressed: _submit,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
    );
  }
}

_submit() {
  //Cuando el formulario NO es válido
  if (!formKey.currentState.validate()) {
    return;
  }
  print('TODO Ok');
}
