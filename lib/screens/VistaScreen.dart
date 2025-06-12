import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:t2_ejercicios_parte2/screens/GuardarScreen.dart';

class VistaScreen extends StatelessWidget {
  final String notaId;
  final Map<String, dynamic> nota;
  final DatabaseReference notasRef;

  const VistaScreen({
    Key? key,
    required this.notaId,
    required this.nota,
    required this.notasRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.teal.shade400; 
    final Color accentColor = Colors.orange.shade300; 
    final Color textColor = Colors.grey.shade800; 

    return Scaffold(
      backgroundColor: Colors.grey.shade50, 
      appBar: AppBar(
       
        title: Text(
          nota['titulo'] ?? 'Detalles de la Nota',
          style: const TextStyle(color: Colors.white), 
        ),
        backgroundColor: primaryColor, 
        foregroundColor: Colors.white, 
        elevation: 0, 
      ),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(20.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              'Título: ${nota['titulo'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.w700, 
                color: textColor, 
              ),
            ),
            const SizedBox(height: 15), 

            // Descripción de la nota
            Text(
              'Descripción: ${nota['descripcion'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade700, 
              ),
            ),
            const SizedBox(height: 15), 

            
            Text(
              'Precio: \$${(nota['precio'] ?? 0).toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30), 

            // Botón Editar Nota
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("Editar Nota"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GuardarScreen(
                        notaId: notaId,
                        nota: nota,
                        notasRef: notasRef,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55), 
                  backgroundColor: accentColor, 
                  foregroundColor: Colors.white, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), 
                  ),
                  elevation: 5, // Sombra ligera
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
