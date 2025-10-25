import 'package:flutter/material.dart';
import 'package:u3_ejercicio2_tablasconforaneas/cita.dart';
import 'package:u3_ejercicio2_tablasconforaneas/ventana2.dart';
import 'ventana1.dart';
import 'basedatosforaneas.dart';

class ventana3 extends StatefulWidget {
  const ventana3({super.key});

  @override
  State<ventana3> createState() => _ventana3State();
}

class _ventana3State extends State<ventana3> {
  List<Cita> datosC = [];
  final lugar = TextEditingController();
  final fecha = TextEditingController();
  final hora = TextEditingController();
  final anotaciones = TextEditingController();
  final idpersona = TextEditingController();

  void actualizarListaC() async {
    List<Cita> temp = await DB.mostrarCitas();
    setState(() {
      datosC = temp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    actualizarListaC();
  }

  DateTime? parseFecha(String fecha) {
    try {
      return DateTime.parse(fecha);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: contenidoDA());
  }

  Widget contenidoDA() {
    switch (indexD) {
      case 0:
        if (datosC.isEmpty) {
          return Center(
            child: Text(
              "NO HAY REGISTROS",
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
          );
        } else {
          datosC.sort((a, b) {
            final fechaA = parseFecha(a.fecha);
            final fechaB = parseFecha(b.fecha);

            if (fechaA == null && fechaB == null) return 0;
            if (fechaA == null) return 1;
            if (fechaB == null) return -1;

            return fechaA.compareTo(fechaB);
          });

          return ListView.builder(
            itemCount: datosC.length,
            itemBuilder: (context, contador) {
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("IDCITA: ${datosC[contador].idcita}  "),
                        Text("IDPERSONA: ${datosC[contador].idpersona}"),
                      ],
                    ),
                    Text("Lugar: ${datosC[contador].lugar}"),
                    Text("Fecha: ${datosC[contador].fecha}"),
                    Text("Hora: ${datosC[contador].hora}"),
                    Text("Anotaciones: ${datosC[contador].anotaciones}"),
                  ],
                ),
              );
            },
          );
        }
      case 1:
        return ListView(
          padding: EdgeInsetsGeometry.all(20),
          children: [
            Card(
              child: Column(
                children: [
                  Text("REGISTRO DE CITAS"),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(labelText: "Lugar"),
                    controller: lugar,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Fecha"),
                    controller: fecha,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Hora"),
                    controller: hora,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Anotaciones"),
                    controller: anotaciones,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "IDPersona"),
                    controller: idpersona,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        int? idIngresado = int.tryParse(idpersona.text);
                        if (idIngresado == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "ERROR: IDPERSONA NO VÁLIDO",
                                style: TextStyle(
                                  backgroundColor: Colors.red,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                          return;
                        }
                        if (!idP.contains(idIngresado)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "ERROR: INGRESA UNA IDPERSONA EXISTENTE",
                                style: TextStyle(
                                  backgroundColor: Colors.red,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                          return;
                        }
                        Cita c = Cita(
                          lugar: lugar.text,
                          fecha: fecha.text,
                          hora: hora.text,
                          anotaciones: anotaciones.text,
                          idpersona: idIngresado,
                        );

                        DB.insertarCita(c).then((respuesta) {
                          if (respuesta <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "ERROR: NO SE HA REALIZADO EL REGISTRO",
                                  style: TextStyle(
                                    backgroundColor: Colors.red,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "ÉXITO: SE HA REGISTRADO LA CITA",
                                  style: TextStyle(
                                    backgroundColor: Colors.green,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                            actualizarListaC();
                            limpiarC();
                          }
                        });
                      });
                    },
                    child: Text("ENVIAR"),
                  ),
                ],
              ),
            ),
          ],
        );
      case 2:
        if (datosC.length <= 0) {
          return Center(
            child: Text(
              "NO HAY REGISTROS",
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: datosC.length,
            itemBuilder: (context, contador) {
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("IDCITA: ${datosC[contador].idcita}  "),
                        Text("IDPERSONA: ${datosC[contador].idpersona}"),
                      ],
                    ),
                    Text("Lugar: ${datosC[contador].lugar}"),
                    Text("Fecha: ${datosC[contador].fecha}"),
                    Text("Hora: ${datosC[contador].hora}"),
                    Text("Anotaciones: ${datosC[contador].anotaciones}"),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        lugar.text = datosC[contador].lugar;
                        fecha.text = datosC[contador].fecha;
                        hora.text = datosC[contador].hora;
                        anotaciones.text = datosC[contador].anotaciones;
                        idpersona.text = datosC[contador].idpersona.toString();
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("ACTUALIZAR REGISTRO"),
                              content: Column(
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: EdgeInsetsGeometry.all(20),
                                      child: Column(
                                        children: [
                                          Text(
                                            datosC[contador].idcita.toString(),
                                          ),
                                          TextField(
                                            controller: lugar,
                                            decoration: InputDecoration(
                                              labelText: "Lugar",
                                              hintText: datosC[contador].lugar,
                                            ),
                                          ),
                                          TextField(
                                            controller: fecha,
                                            decoration: InputDecoration(
                                              labelText: "Fecha",
                                              hintText: datosC[contador].fecha,
                                            ),
                                          ),
                                          TextField(
                                            controller: hora,
                                            decoration: InputDecoration(
                                              labelText: "Hora",
                                              hintText: datosC[contador].hora,
                                            ),
                                          ),
                                          TextField(
                                            controller: anotaciones,
                                            decoration: InputDecoration(
                                              labelText: "Anotaciones",
                                              hintText:
                                                  datosC[contador].anotaciones,
                                            ),
                                          ),
                                          TextField(
                                            controller: idpersona,
                                            decoration: InputDecoration(
                                              labelText: "IDPersona",
                                              hintText: datosC[contador]
                                                  .idpersona
                                                  .toString(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            int? idIngresado = int.tryParse(
                                              idpersona.text,
                                            );
                                            if (idIngresado == null) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "ERROR: IDPERSONA NO VÁLIDO",
                                                    style: TextStyle(
                                                      backgroundColor:
                                                          Colors.red,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            if (!idP.contains(idIngresado)) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "ERROR: INGRESA UNA IDPERSONA EXISTENTE",
                                                    style: TextStyle(
                                                      backgroundColor:
                                                          Colors.red,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              );
                                              return Navigator.pop(context);
                                            }
                                            Cita c = Cita(
                                              idcita: datosC[contador].idcita,
                                              lugar: lugar.text,
                                              fecha: fecha.text,
                                              hora: hora.text,
                                              anotaciones: anotaciones.text,
                                              idpersona: int.parse(
                                                idpersona.text,
                                              ),
                                            );

                                            DB.actualizarCita(c);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "EXITO: SE HA REALIZADO LA ACTUALIZACIÓN",
                                                  style: TextStyle(
                                                    backgroundColor:
                                                        Colors.green,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                            actualizarListaC();
                                            limpiarC();
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text("ACTUALIZAR"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text("CANCELAR"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text("ACTUALIZAR"),
                    ),
                  ],
                ),
              );
            },
          );
        }
      case 3:
        if (datosC.length <= 0) {
          return Center(
            child: Text(
              "NO HAY REGISTROS",
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: datosC.length,
            itemBuilder: (context, contador) {
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("IDCITA: ${datosC[contador].idcita}  "),
                        Text("IDPERSONA: ${datosC[contador].idpersona}"),
                      ],
                    ),
                    Text("Lugar: ${datosC[contador].lugar}"),
                    Text("Fecha: ${datosC[contador].fecha}"),
                    Text("Hora: ${datosC[contador].hora}"),
                    Text("Anotaciones: ${datosC[contador].anotaciones}"),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("ELIMINAR REGISTRO"),
                              content: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        DB.eliminarCita(
                                          datosC[contador].idcita,
                                        );
                                        actualizarListaC();
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text("ELIMINAR"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text("CANCELAR"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text("ELIMINAR"),
                    ),
                  ],
                ),
              );
            },
          );
        }
    }
    final hoy = DateTime.now();
    final fechaHoy =
        "${hoy.year}-${hoy.month.toString().padLeft(2, '0')}-${hoy.day.toString().padLeft(2, '0')}";
    final citasHoy = datosC.where((cita) => cita.fecha == fechaHoy).toList();

    if (citasHoy.isEmpty) {
      return Center(
        child: Text(
          "NO HAY CITAS PARA HOY ($fechaHoy)",
          style: TextStyle(fontSize: 25, color: Colors.red),
        ),
      );
    }

    return ListView.builder(
      itemCount: citasHoy.length,
      itemBuilder: (context, index) {
        final cita = citasHoy[index];
        return Card(
          child: ListTile(
            title: Text("Lugar: ${cita.lugar}"),
            subtitle: Text("Hora: ${cita.hora}\n${cita.anotaciones}"),
            leading: Text("ID: ${cita.idcita}"),
          ),
        );
      },
    );
  }

  Widget? limpiarC() {
    lugar.text = "";
    fecha.text = "";
    hora.text = "";
    anotaciones.text = "";
    idpersona.text = "";
  }
}
