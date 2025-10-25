import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:u3_ejercicio2_tablasconforaneas/cita.dart';
import 'package:u3_ejercicio2_tablasconforaneas/persona.dart';

class DB {
  static Future<Database> _conectarDB() async {
    return openDatabase(
      join(await getDatabasesPath(), "ejercicio2_v2.db"),
      version: 2,
      onConfigure: (db) async{
        await db.execute("PRAGMA foreign_keys = ON");
      },
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE PERSONA(IDPERSONA INTEGER PRIMARY KEY AUTOINCREMENT, NOMBRE TEXT NOT NULL, TELEFONO TEXT)",
        );
        await db.execute(
          "CREATE TABLE CITA(IDCITA INTEGER PRIMARY KEY AUTOINCREMENT, LUGAR TEXT, FECHA TEXT, HORA TEXT, ANOTACIONES TEXT, IDPERSONA INTEGER, FOREIGN KEY (IDPERSONA) REFERENCES PERSONA(IDPERSONA) ON DELETE CASCADE ON UPDATE CASCADE)",
        );
      },
    );
  }

  static Future<int> insertarPersona(Persona p) async {
    Database base = await _conectarDB();
    return base.insert("PERSONA", p.toJSON());
  }

  static Future<List<Persona>> mostrarPersonas() async {
    Database base = await _conectarDB();

    List<Map<String, dynamic>> temp = await base.query("PERSONA");

    return List.generate(temp.length, (contador) {
      return Persona(
        idpersona: temp[contador]['IDPERSONA'],
        nombre: temp[contador]['NOMBRE'],
        telefono: temp[contador]['TELEFONO'],
      );
    });
  }

  static Future<int> actualizarPersona(Persona p) async {
    Database base = await _conectarDB();
    return base.update(
      "PERSONA",
      p.toJSON(),
      where: "IDPERSONA=?",
      whereArgs: [p.idpersona],
    );
  }

  static Future<int> eliminarPersona(int? idpersona) async {
    Database base = await _conectarDB();
    return base.delete("PERSONA", where: "IDPERSONA=?", whereArgs: [idpersona]);
  }

  static Future<int> insertarCita(Cita c) async {
    Database base = await _conectarDB();
    return base.insert("CITA", c.toJSON());
  }

  static Future<List<Cita>> mostrarCitas() async {
    Database base = await _conectarDB();

    List<Map<String, dynamic>> temp = await base.query("CITA");

    return List.generate(temp.length, (contador) {
      return Cita(
        idcita: temp[contador]['IDCITA'],
        lugar: temp[contador]['LUGAR'],
        fecha: temp[contador]['FECHA'],
        hora: temp[contador]['HORA'],
        anotaciones: temp[contador]['ANOTACIONES'],
        idpersona: temp[contador]['IDPERSONA'],
      );
    });
  }

  static Future<int> actualizarCita(Cita c) async {
    Database base = await _conectarDB();
    return base.update(
      "CITA",
      c.toJSON(),
      where: "IDCITA=?",
      whereArgs: [c.idcita],
    );
  }

  static Future<int> eliminarCita(int? idcita) async {
    Database base = await _conectarDB();
    return base.delete("CITA", where: "IDCITA=?", whereArgs: [idcita]);
  }
}
