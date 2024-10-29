import 'package:flutter/material.dart';
import 'package:doctor_pc/models/computadora.dart';
import 'package:doctor_pc/services/computadoras_service.dart';

import 'package:doctor_pc/screens/ver_computadora_screen.dart';
import 'package:doctor_pc/screens/crear_computadora_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ComputadorasService _computadorasService = ComputadorasService();
  late Future<List<Computadora>> _computadorasFuture;

  @override
  void initState() {
    super.initState();
    _computadorasFuture = _computadorasService.getComputadoras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Computadoras Dashboard'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CrearComputadoraScreen(),
                  ),
                ).then(
                  (value) {
                    setState(() {
                      _computadorasFuture =
                          _computadorasService.getComputadoras();
                    });
                  },
                );
              },
            ),
          ],
        ),
        body: FutureBuilder(
            future: _computadorasFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (!snapshot.hasData) {
                return Center(
                  child: Text("No hay computadoras."),
                );
              } else {
                final computadoras = snapshot.data!;
                return ListView.builder(
                  itemCount: computadoras.length,
                  itemBuilder: (context, index) {
                    Computadora compu = computadoras[index];
                    return ListTile(
                      title: Text(compu.marca),
                      subtitle: Text(compu.propietario!.nombreApellido),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VerComputadoraScreen(computadora: compu),
                          ),
                        ).then(
                          (_) {
                            setState(() {
                              _computadorasFuture =
                                  _computadorasService.getComputadoras();
                            });
                          },
                        );
                      },
                    );
                  },
                );
              }
            }));
  }
}
