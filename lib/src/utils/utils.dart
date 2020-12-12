//Funcion que determina si es un numero o no
bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s); //Si se puede o no se puede parsear

  return (n == null) ? false : true;
}
