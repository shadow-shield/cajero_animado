import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/atm_controller.dart';

class PantallaCodigo extends StatelessWidget {
  final ATMController controller = Get.find();
  final TextEditingController tarjetaController = TextEditingController();
  final TextEditingController claveController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/fondoapp.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Ingresa tu número de cuenta y clave para continuar.',
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          speed: Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          'Asegúrate de que los datos sean correctos.',
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          speed: Duration(milliseconds: 100),
                        ),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: tarjetaController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Número de Cuenta',
                        filled: true,
                        suffixIcon: Image.asset(
                          'assets/cuenta.gif',
                          width: 1,
                        ),
                        labelStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    width: 500,
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: claveController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Clave Segura',
                        suffixIcon: Image.asset(
                          'assets/contrasena.gif',
                          width: 1,
                        ),
                        labelStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      controller.autenticar(
                          tarjetaController.text, claveController.text);
            
                      if (controller.verificarAutenticacion()) {
                        if (tarjetaController.text == '11234567890') {
                          Get.toNamed('/retiro');
                        } else if (tarjetaController.text == '01234567890') {
                          controller.generarCodigoTemporal();
                          Get.toNamed('/retiro-temporal');
                        } else {
                          Get.snackbar('Error', 'Número de cuenta no reconocido',
                              backgroundColor: Colors.white,
                              colorText: Colors.blue);
                        }
                      } else {
                        Get.snackbar('Error', 'Tarjeta o clave segura incorrecta',
                            backgroundColor: Colors.white,
                            colorText: Colors.blue);
                      }
                    },
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ingresar',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 22,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Image.asset('assets/personas-mobile.png')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
