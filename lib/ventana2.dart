import 'package:flutter/material.dart';
import 'package:u3_ejercicio2_tablasconforaneas/persona.dart';
import 'ventana1.dart';
import 'basedatosforaneas.dart';

class ventana2 extends StatefulWidget {
  const ventana2({super.key});

  @override
  State<ventana2> createState() => _ventana2State();
}

List<int?> idP = [];

class _ventana2State extends State<ventana2> {
  @override
  int index = 0;
  final nombre = TextEditingController();
  final telefono = TextEditingController();
  List<Persona> datosP = [];

  void actualizarListaP() async {
    List<Persona> temp = await DB.mostrarPersonas();
    setState(() {
      datosP = temp;
      idP.clear();
      for (var persona in temp) {
        idP.add(persona.idpersona);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    actualizarListaP();
  }

  Widget build(BuildContext context) {
    return Scaffold(body: contenidoDA());
  }

  Widget contenidoDA() {
    switch (indexD) {
      case 0:
        if (datosP.length <= 0) {
          return Center(
            child: Text(
              "NO HAY REGISTROS",
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: datosP.length,
            itemBuilder: (context, contador) {
              return ListTile(
                title: Text(datosP[contador].nombre),
                subtitle: Text(datosP[contador].telefono),
                trailing: Text(datosP[contador].idpersona.toString()),
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
                  Text("REGISTRO DE USUARIO"),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(labelText: "Nombre"),
                    controller: nombre,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Teléfono"),
                    controller: telefono,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Persona p = Persona(
                          nombre: nombre.text,
                          telefono: telefono.text,
                        );

                        DB.insertarPersona(p).then((respuesta) {
                          if (respuesta <= 0) {
                            setState(() {
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
                            });
                          } else {
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "EXITO: SE HA REALIZADO EL REGISTRO",
                                    style: TextStyle(
                                      backgroundColor: Colors.green,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            });
                          }
                          actualizarListaP();
                          limpiarP();
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
        if (datosP.length <= 0) {
          return Center(
            child: Text(
              "NO HAY REGISTROS",
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: datosP.length,
            itemBuilder: (context, contador) {
              return ListTile(
                title: Text(datosP[contador].nombre),
                subtitle: Text(datosP[contador].telefono),
                leading: Text(datosP[contador].idpersona.toString()),
                trailing: IconButton(
                  onPressed: () {
                    nombre.text = datosP[contador].nombre;
                    telefono.text = datosP[contador].telefono;
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
                                        datosP[contador].idpersona.toString(),
                                      ),
                                      TextField(
                                        controller: nombre,
                                        decoration: InputDecoration(
                                          labelText: "Nombre",
                                          hintText: datosP[contador].nombre,
                                        ),
                                      ),
                                      TextField(
                                        controller: telefono,
                                        decoration: InputDecoration(
                                          labelText: "Teléfono",
                                          hintText: datosP[contador].telefono,
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
                                        Persona p = Persona(
                                          idpersona: datosP[contador].idpersona,
                                          nombre: nombre.text,
                                          telefono: telefono.text,
                                        );

                                        DB.actualizarPersona(p);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "EXITO: SE HA REALIZADO LA ACTUALIZACIÓN",
                                              style: TextStyle(
                                                backgroundColor: Colors.green,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                        actualizarListaP();
                                        limpiarP();
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
                  icon: Icon(Icons.update),
                ),
              );
            },
          );
        }
      case 3:
        if (datosP.length <= 0) {
          return Center(
            child: Text(
              "NO HAY REGISTROS",
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: datosP.length,
            itemBuilder: (context, contador) {
              return ListTile(
                title: Text(datosP[contador].nombre),
                subtitle: Text(datosP[contador].telefono),
                leading: Text(datosP[contador].idpersona.toString()),
                trailing: IconButton(
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
                                    DB.eliminarPersona(
                                      datosP[contador].idpersona,
                                    );
                                    actualizarListaP();
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
                  icon: Icon(Icons.delete),
                ),
              );
            },
          );
        }
    }
    return Center(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 50),
        child: Text(
          "APARTADO DEDICADO PARA CITAS",
          style: TextStyle(fontSize: 30, color: Colors.red),
        ),
      ),
    );
  }

  Widget? limpiarP() {
    nombre.text = "";
    telefono.text = "";
  }
}
