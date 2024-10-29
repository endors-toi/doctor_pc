class Propietario {
  // campos
  final int? id;
  final String nombreApellido;
  final int idComputadora;

  // constructor
  Propietario({
    this.id,
    required this.nombreApellido,
    required this.idComputadora,
  });

  // métodos json
  factory Propietario.fromJson(Map<String, dynamic> json) {
    return Propietario(
        id: json['id'],
        nombreApellido: json['nombreApellido'],
        idComputadora: json['id_computadora']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "nombreApellido": this.nombreApellido,
      "id_computadora": this.idComputadora
    };
  }
}
