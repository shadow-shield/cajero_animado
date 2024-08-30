import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cajero_animado/screens/pantalla_codigo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/atm_controller.dart';

class PantallaPrincipal extends StatelessWidget {
  final ATMController controller = Get.put(ATMController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/fondoapp.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white24,
                    ),
                    child: Image.asset(
                      'assets/bancoagil.png',
                      width: 150,
                    ),
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '¡Bienvenido al Banco Ágil!',
                        textStyle: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                        speed: Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: Duration(seconds: 1),
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Estamos listos para asistirte.',
                        textStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                        speed: Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: Duration(seconds: 1),
                  ),
                  Image.asset(
                    'assets/cajero.png',
                  ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      foregroundColor: WidgetStateProperty.all(Colors.blue),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              PantallaCodigo(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0); 
                            const end = Offset(0.0, 0.0);
                            const curve = Curves.easeInOut;

                            var tween =
                                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    label: Text('Comenzar'),
                    icon: Image.asset(
                      'assets/next.gif',
                      width: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


