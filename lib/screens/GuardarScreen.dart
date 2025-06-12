import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class GuardarScreen extends StatefulWidget {
  final String? notaId; 
  final Map<String, dynamic>? nota; 
  final DatabaseReference notasRef;

  const GuardarScreen({
    Key? key,
    this.notaId,
    this.nota,
    required this.notasRef,
  }) : super(key: key);

  @override
  _GuardarScreenState createState() => _GuardarScreenState();
}

class _GuardarScreenState extends State<GuardarScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _descripcionController;
  late TextEditingController _precioController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.nota?['titulo'] ?? '');
    _descripcionController = TextEditingController(text: widget.nota?['descripcion'] ?? '');
    _precioController = TextEditingController(text: (widget.nota?['precio'] ?? 0.0).toString());
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  Future<void> guardarNota() async {
    if (_formKey.currentState!.validate()) {
      final String titulo = _tituloController.text;
      final String descripcion = _descripcionController.text;
      final double precio = double.parse(_precioController.text);

      if (widget.notaId == null) {
        // Añadir nueva nota
        final newNoteRef = widget.notasRef.push(); 
        await newNoteRef.set({
          'titulo': titulo,
          'descripcion': descripcion,
          'precio': precio,
          'timestamp': ServerValue.timestamp, 
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nota agregada correctamente.')));
      } else {
        
        await widget.notasRef.child(widget.notaId!).update({
          'titulo': titulo,
          'descripcion': descripcion,
          'precio': precio,
          'timestamp': ServerValue.timestamp, 
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nota actualizada correctamente.')));
      }
      Navigator.of(context).pop(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.notaId == null ? 'Agregar Nota' : 'Editar Nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una descripción';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precioController,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un precio';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, ingresa un número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: guardarNota,
                child: Text(widget.notaId == null ? 'Guardar Nota' : 'Actualizar Nota'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
