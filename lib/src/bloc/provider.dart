import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/login_bloc.dart';
export 'package:formvalidation/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  final loginBloc = LoginBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  //Condicion: Al actualizarse debe notificar a sus hijos. El 99% de los casos es cierto TRUE
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }
}
