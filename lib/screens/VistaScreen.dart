import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:t2_ejercicios_parte2/screens/GuardarScreen.dart'; // Asegúrate de que la ruta sea correcta

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
    // Definimos una paleta de colores suaves y agradables, consistente con Login y Registro
    final Color primaryColor = Colors.teal.shade400; // Un verde azulado suave
    final Color accentColor = Colors.orange.shade300; // Un naranja cálido para acentos
    final Color textColor = Colors.grey.shade800; // Texto oscuro pero no negro puro

    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Fondo muy claro para suavidad, consistente
      appBar: AppBar(
        // Este AppBar automáticamente mostrará la flecha de retroceso
        title: Text(
          nota['titulo'] ?? 'Detalles de la Nota',
          style: const TextStyle(color: Colors.white), // Texto del título blanco
        ),
        backgroundColor: primaryColor, // Color principal consistente
        foregroundColor: Colors.white, // Iconos y texto en primer plano blanco
        elevation: 0, // Sin sombra para un look más plano
      ),
      body: SingleChildScrollView( // Añadir SingleChildScrollView para contenido largo
        padding: const EdgeInsets.all(20.0), // Padding consistente
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la nota
            Text(
              'Título: ${nota['titulo'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 28, // Tamaño de fuente más grande
                fontWeight: FontWeight.w700, // Peso de fuente consistente
                color: textColor, // Color de texto consistente
              ),
            ),
            const SizedBox(height: 15), // Espaciado consistente

            // Descripción de la nota
            Text(
              'Descripción: ${nota['descripcion'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade700, // Color de texto más suave
              ),
            ),
            const SizedBox(height: 15), // Espaciado consistente

            // Precio de la nota - Resaltado
            Text(
              'Precio: \$${(nota['precio'] ?? 0).toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20, // Tamaño de fuente ligeramente mayor
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30), // Más espacio antes del botón

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
                  minimumSize: const Size(double.infinity, 55), // Ancho completo, altura consistente
                  backgroundColor: accentColor, // Usar el accentColor para el botón de acción
                  foregroundColor: Colors.white, // Texto blanco para contraste
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Bordes redondeados
                  ),
                  elevation: 5, // Sombra ligera
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), // Estilo de texto
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}