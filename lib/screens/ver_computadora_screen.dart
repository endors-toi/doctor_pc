import 'package:doctor_pc/models/computadora.dart';
import 'package:doctor_pc/screens/editar_computadora_screen.dart';
import 'package:doctor_pc/services/computadoras_service.dart';
import 'package:doctor_pc/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VerComputadoraScreen extends StatelessWidget {
  final Computadora computadora;

  VerComputadoraScreen({super.key, required this.computadora});

  @override
  Widget build(BuildContext context) {
    final ComputadorasService _computadorasService = ComputadorasService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditarComputadoraScreen(computadora: computadora),
                ),
              ).then(
                (_) {
                  Navigator.pop(context);
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _computadorasService.deleteComputadora(computadora.id!).then(
                (success) {
                  if (success) {
                    showSnackbar(context, "Computadora eliminada");
                    Navigator.pop(context);
                  } else {
                    showSnackbar(context, "No se pudo eliminar");
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Marca: ${computadora.marca}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Precio: ${computadora.precio}'),
            SizedBox(height: 8),
            Text('Año: ${DateFormat.y().format(computadora.anio)}'),
            SizedBox(height: 8),
            Text("Propietario: ${computadora.propietario!.nombreApellido}"),
          ],
        ),
      ),
    );
  }
}
