import 'package:doctor_pc/models/computadora.dart';
import 'package:doctor_pc/models/propietario.dart';
import 'package:doctor_pc/services/computadoras_service.dart';
import 'package:doctor_pc/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditarComputadoraScreen extends StatefulWidget {
  final Computadora computadora;

  EditarComputadoraScreen({super.key, required this.computadora});

  @override
  _EditarComputadoraScreenState createState() =>
      _EditarComputadoraScreenState();
}

class _EditarComputadoraScreenState extends State<EditarComputadoraScreen> {
  final ComputadorasService _computadorasService = ComputadorasService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _marcaController;
  late TextEditingController _precioController;
  late TextEditingController _anioController;
  late TextEditingController _propietarioNombreController;
  late TextEditingController _propietarioApellidoController;

  @override
  void initState() {
    super.initState();
    _marcaController = TextEditingController(text: widget.computadora.marca);
    _precioController =
        TextEditingController(text: widget.computadora.precio.toString());
    _anioController = TextEditingController(
        text: DateFormat.y().format(widget.computadora.anio));
    _propietarioNombreController = TextEditingController(
        text: widget.computadora.propietario!.nombreApellido.split(' ')[0]);
    _propietarioApellidoController = TextEditingController(
        text: widget.computadora.propietario!.nombreApellido.split(' ')[1]);
  }

  void _saveComputadora() {
    // actualizar computadora
    Computadora compu = Computadora(
      marca: _marcaController.text,
      precio: int.parse(_precioController.text),
      anio: DateTime(int.parse(_anioController.text)),
    );

    _computadorasService.updateComputadora(compu, widget.computadora.id!);

    // actualizar propietario
    Propietario prop = Propietario(
      nombreApellido:
          '${_propietarioNombreController.text} ${_propietarioApellidoController.text}',
      idComputadora: widget.computadora.propietario!.idComputadora,
    );

    _computadorasService
        .updatePropietario(prop, widget.computadora.propietario!.id!)
        .then((_) {
      // saliendo del formulario exitosamente
      showSnackbar(context, 'Computadora actualizada exitosamente');
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Computadora ${widget.computadora.marca}'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _marcaController,
                decoration: InputDecoration(labelText: 'Marca'),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _precioController,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _anioController,
                decoration: InputDecoration(labelText: 'Año'),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 8),
              Text(
                'Propietario',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _propietarioNombreController,
                      decoration: InputDecoration(labelText: 'Nombre'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _propietarioApellidoController,
                      decoration: InputDecoration(labelText: 'Apellido'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _saveComputadora(),
                child: Text('Actualizar Computadora'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
