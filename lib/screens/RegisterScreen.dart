import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:t2_ejercicios_parte2/screens/LoginScreen.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contrasenia = TextEditingController();

  @override
  void dispose() {
    _correo.dispose();
    _contrasenia.dispose();
    super.dispose();
  }

  Future<void> registroFire(String correo, String contrasenia) async {
    try {
      
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: correo,
        password: contrasenia,
      );

      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registro exitoso. Por favor, inicia sesión.'),
          backgroundColor: Colors.green, 
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } on FirebaseAuthException catch (e) {
    
      String mensaje = '';
      if (e.code == 'weak-password') {
        mensaje = 'La contraseña es muy débil. Debe tener al menos 6 caracteres.';
      } else if (e.code == 'email-already-in-use') {
        mensaje = 'El correo ya está registrado. Intenta iniciar sesión o usa otro correo.';
      } else if (e.code == 'invalid-email') {
        mensaje = 'El formato del email es inválido.';
      } else if (e.code == 'operation-not-allowed') {
        mensaje = 'Registro con email/contraseña no habilitado. Contacta al soporte.';
      } else {
        mensaje = 'Error al registrar: ${e.message}';
      }

      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensaje),
          backgroundColor: Colors.redAccent, 
        ),
      );
    } catch (e) {
      
      print('Error desconocido al registrar: $e'); 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrió un error inesperado al registrar: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   
    final Color primaryColor = Colors.teal.shade400; 
    final Color accentColor = Colors.orange.shade300; 
    final Color textColor = Colors.grey.shade800; 
    final Color hintColor = Colors.grey.shade500; 

    return Scaffold(
      backgroundColor: Colors.grey.shade50, 
      appBar: AppBar( 
        title: const Text("Registro de Usuario"),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0, 
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Text(
                "Crear Cuenta", 
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 40),
            
              TextField(
                controller: _correo,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Correo Electrónico", 
                  hintText: "ejemplo@dominio.com",
                  prefixIcon: Icon(Icons.email, color: primaryColor.withOpacity(0.7)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  labelStyle: TextStyle(color: hintColor),
                  hintStyle: TextStyle(color: hintColor.withOpacity(0.7)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
              ),
              const SizedBox(height: 20),
         
              TextField(
                controller: _contrasenia,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  hintText: "Mínimo 6 caracteres",
                  prefixIcon: Icon(Icons.lock, color: primaryColor.withOpacity(0.7)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  labelStyle: TextStyle(color: hintColor),
                  hintStyle: TextStyle(color: hintColor.withOpacity(0.7)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
              ),
              const SizedBox(height: 30),
         
              ElevatedButton(
                onPressed: () => registroFire(_correo.text, _contrasenia.text),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                child: const Text("Registrarse"),
              ),
              const SizedBox(height: 20),
           
              TextButton(
                onPressed: () {
               
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: accentColor,
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                child: const Text("¿Ya tienes cuenta? Inicia sesión"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}