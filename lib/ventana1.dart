import 'package:flutter/material.dart';
import 'package:u3_ejercicio2_tablasconforaneas/ventana2.dart';
import 'package:u3_ejercicio2_tablasconforaneas/ventana3.dart';

class App0302 extends StatefulWidget {
  const App0302({super.key});

  @override
  State<App0302> createState() => _App0302State();
}

int indexD = 0;

class _App0302State extends State<App0302> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        title: Text("MI AGENDA VIRTUAL",
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red.shade400,
        centerTitle: true,
      ),
      body: contenidoB(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "CLIENTES"),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: "CITAS"),
        ],
        onTap: (pos){
          setState(() {
            index = pos;
          });
        },
        backgroundColor: Colors.red.shade400,
        selectedItemColor: Colors.white,
        iconSize: 25,
        selectedFontSize: 20,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              child: CircleAvatar(child: Image.asset("assets/JANE_LENTES.jpg", width: 130,),),
            ),
            SizedBox(height: 20),
            _itemDrawer(0, Icons.list, "MOSTRAR"),
            _itemDrawer(1, Icons.text_fields_rounded, "CAPTURAR"),
            _itemDrawer(2, Icons.update, "ACTUALIZAR"),
            _itemDrawer(3, Icons.delete, "ELIMINAR"),
            Divider(),
            _itemDrawer(4, Icons.sunny, "HOY"),
          ],
        ),
      ),
    );
  }

  Widget contenidoB(){
    switch(index){
      case 0:
        return ventana2();
    }return ventana3();
  }

  Widget _itemDrawer(int indice, IconData icono, String text) {
    return ListTile(
      onTap: () {
        setState(() {
          indexD = indice;
        });
        Navigator.pop(context);
      },
      title: Row(
        children: [
          Expanded(child: Icon(icono, size: 30)),
          Expanded(child: Text(text, style: TextStyle(fontSize: 18)), flex: 2),
        ],
      ),
    );
  }
}
