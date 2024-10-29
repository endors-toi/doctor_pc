import 'package:doctor_pc/models/computadora.dart';
import 'package:doctor_pc/models/propietario.dart';
import 'package:doctor_pc/services/computadoras_service.dart';
import 'package:doctor_pc/utils.dart';
import 'package:flutter/material.dart';

class CrearComputadoraScreen extends StatefulWidget {
  const CrearComputadoraScreen({super.key});

  @override
  State<CrearComputadoraScreen> createState() => _CrearComputadoraScreenState();
}

class _CrearComputadoraScreenState extends State<CrearComputadoraScreen> {
  final ComputadorasService _computadorasService = ComputadorasService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _marcaController = TextEditingController();
  TextEditingController _precioController = TextEditingController();
  TextEditingController _anioController = TextEditingController();
  TextEditingController _propietarioNombreController = TextEditingController();
  TextEditingController _propietarioApellidoController =
      TextEditingController();

  void _createComputadora() {
    // crear computadora
    Computadora compu = Computadora(
      marca: _marcaController.text,
      precio: int.parse(_precioController.text),
      anio: DateTime(int.parse(_anioController.text)),
    );

    _computadorasService.createComputadora(compu).then(
      (id) {
        // crear propietario
        Propietario prop = Propietario(
          nombreApellido:
              '${_propietarioNombreController.text} ${_propietarioApellidoController.text}',
          idComputadora: id,
        );

        _computadorasService.createPropietario(prop).then((_) {
          // saliendo del formulario exitosamente
          showSnackbar(context, 'Computadora creada exitosamente');
          Navigator.pop(context);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Computadora'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                TextFormField(
                  controller: _marcaController,
                  decoration: InputDecoration(
                    labelText: 'Marca',
                  ),
                ),
                TextFormField(
                  controller: _precioController,
                  decoration: InputDecoration(
                    labelText: 'Precio',
                  ),
                ),
                TextFormField(
                  controller: _anioController,
                  decoration: InputDecoration(
                    labelText: 'Año',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Propietario',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _propietarioNombreController,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _propietarioApellidoController,
                        decoration: InputDecoration(
                          labelText: 'Apellido',
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => _createComputadora(),
                  child: Text('Crear Computadora'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
