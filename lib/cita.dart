class Cita {
  int? idcita;
  String lugar;
  String fecha;
  String hora;
  String anotaciones;
  int idpersona;

  Cita({
    this.idcita,
    required this.lugar,
    required this.fecha,
    required this.hora,
    required this.anotaciones,
    required this.idpersona,
  });
  Map<String, dynamic> toJSON() {
    return {
      //'idcita': idcita,
      'lugar': lugar,
      'fecha': fecha,
      'hora': hora,
      'anotaciones': anotaciones,
      'idpersona': idpersona,
    };
  }
}
