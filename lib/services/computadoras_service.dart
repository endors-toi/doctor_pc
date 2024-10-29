import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:doctor_pc/models/computadora.dart';
import 'package:doctor_pc/models/propietario.dart';

class ComputadorasService {
  String apiUrlPC = 'http://localhost:8000/api'; // chrome
  String apiUrl = 'http://10.0.2.2:8000/api'; // emulador

  Map<String, String> headers = {
    // reglas de comunicación
    "Accept": "application/json", // yo recibo json.
    "Content-Type": "application/json" // te estoy enviando json.
  };

  // CRUD Computadoras (get, create, update, delete)
  Future<List<Computadora>> getComputadoras() async {
    final uri = Uri.parse(apiUrl + '/computadoras');

    final resp = await http.get(uri, headers: headers);
    print(resp.body);
    if (resp.statusCode == 200) {
      List<dynamic> jsonComp = json.decode(resp.body);
      List<Computadora> computadoras =
          jsonComp.map((e) => Computadora.fromJson(e)).toList();
      List<Propietario> propietarios = await getPropietarios();
      computadoras.forEach((compu) {
        compu.propietario = propietarios.firstWhere(
          (prop) => prop.idComputadora == compu.id,
        );
      });

      return computadoras;
    } else {
      throw Exception("Error al obtener computadoras");
    }
  }

  Future<int> createComputadora(Computadora compu) async {
    final uri = Uri.parse(apiUrl + '/computadoras');

    final resp = await http.post(uri,
        headers: headers, body: json.encode(compu.toJson()));

    if (resp.statusCode == 201) {
      return json.decode(resp.body)['id'];
    } else {
      print(resp.body);
      return -1;
    }
  }

  Future<bool> updateComputadora(Computadora compu, int id) async {
    final uri = Uri.parse(apiUrl + '/computadoras/${id}');

    final resp = await http.put(uri,
        headers: headers, body: json.encode(compu.toJson()));

    if (resp.statusCode == 200) {
      return true;
    } else {
      print(resp.body);
      return false;
    }
  }

  Future<bool> deleteComputadora(int id) async {
    final uri = Uri.parse(apiUrl + '/computadoras/${id}');
    print(apiUrl + '/computadoras/${id}');
    final resp = await http.delete(uri, headers: headers);

    if (resp.statusCode == 204) {
      return true;
    } else {
      print(resp.body);
      return false;
    }
  }

  // CRUD Propietarios
  Future<List<Propietario>> getPropietarios() async {
    final uri = Uri.parse(apiUrl + '/propietarios');

    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      List<dynamic> jsonComp = json.decode(resp.body);
      return jsonComp.map((e) => Propietario.fromJson(e)).toList();
    } else {
      throw Exception("Error al obtener propietarios");
    }
  }

  Future<int> createPropietario(Propietario prop) async {
    final uri = Uri.parse(apiUrl + '/propietarios');

    final resp = await http.post(uri,
        headers: headers, body: json.encode(prop.toJson()));

    if (resp.statusCode == 200) {
      return json.decode(resp.body)['id'];
    } else {
      print(resp.body);
      return -1;
    }
  }

  Future<bool> updatePropietario(Propietario prop, int id) async {
    final uri = Uri.parse(apiUrl + '/propietarios/${id}');

    final resp =
        await http.put(uri, headers: headers, body: json.encode(prop.toJson()));

    if (resp.statusCode == 200) {
      return true;
    } else {
      print(resp.body);
      return false;
    }
  }

  Future<bool> deletePropietario(int id) async {
    final uri = Uri.parse(apiUrl + '/propietarios/${id}');

    final resp = await http.delete(uri, headers: headers);

    if (resp.statusCode == 204) {
      return true;
    } else {
      print(resp.body);
      return false;
    }
  }
}
