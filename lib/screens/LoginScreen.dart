import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:t2_ejercicios_parte2/screens/ListaScreen.dart';
import 'package:t2_ejercicios_parte2/screens/RegisterScreen.dart'; 

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contrasenia = TextEditingController();

  @override
  void dispose() {
    _correo.dispose();
    _contrasenia.dispose();
    super.dispose();
  }

  Future<void> loginFire(String correo, String contrasenia, BuildContext context) async {
    try {
     
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: correo,
        password: contrasenia,
      );
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ListaScreen()),
      );
    } on FirebaseAuthException catch (e) {
      
      String mensaje = '';
      if (e.code == 'user-not-found') {
        mensaje = 'No existe un usuario con ese correo.';
      } else if (e.code == 'wrong-password') {
        mensaje = 'Contraseña incorrecta.';
      } else if (e.code == 'invalid-email') {
        mensaje = 'El formato del email es inválido.';
      } else if (e.code == 'channel-error') {
        mensaje = 'Error de configuración de Firebase. Verifica tu `google-services.json` o `GoogleService-Info.plist`.';
      }
      else {
        mensaje = 'Error: ${e.message}';
      }


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensaje),
          backgroundColor: Colors.redAccent,
        ),
      );
    } catch (e) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrió un error inesperado: $e'),
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 100, color: primaryColor),
              const SizedBox(height: 20),
              
              Text(
                "Iniciar Sesión",
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
                  labelText: "Correo",
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
              // Campo de texto para la contraseña
              TextField(
                controller: _contrasenia,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  hintText: "Ingresa tu contraseña",
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
                obscureText: true,
              ),
              const SizedBox(height: 30),
              // Botón de ingresar 
              ElevatedButton(
                onPressed: () => loginFire(_correo.text, _contrasenia.text, context),
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
                child: const Text("Ingresar"),
              ),
              const SizedBox(height: 20),
              // Botón para navegar a la pantalla de registro
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Registro()), 
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: accentColor, 
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                child: const Text("¿No tienes cuenta? Regístrate aquí"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
