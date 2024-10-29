import 'package:doctor_pc/models/propietario.dart';

class Computadora {
  // campos
  final int? id;
  final int precio;
  final String marca;
  final DateTime anio;
  Propietario? propietario;

  // constructor
  Computadora({
    this.id,
    required this.precio,
    required this.marca,
    required this.anio,
    this.propietario,
  });

  // métodos json (comunicación con la API)
  factory Computadora.fromJson(Map<String, dynamic> json) {
    return Computadora(
      id: json['id'],
      precio: json['precio'],
      marca: json['marca'],
      anio: DateTime.parse(json['anio']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "precio": this.precio,
      "marca": this.marca,
      "anio": this.anio.toIso8601String(),
    };
  }
}
