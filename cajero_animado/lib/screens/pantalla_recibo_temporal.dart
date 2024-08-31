import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/atm_controller.dart';

class PantallaReciboTemporal extends StatelessWidget {
  final ATMController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    String? numcuenta=controller.atmModel.obtenerNumeroTarjetaPorClave('0113');
    String? cuentanequi=controller.ajustarNumeroTarjeta(numcuenta);
    int billete10k = controller.billetesUsados
            ?.where((billete) => billete == 10000)
            .length ??
        0;
    int billete20k = controller.billetesUsados
            ?.where((billete) => billete == 20000)
            .length ??
        0;
    int billete50k = controller.billetesUsados
            ?.where((billete) => billete == 50000)
            .length ??
        0;
    int billete100k = controller.billetesUsados
            ?.where((billete) => billete == 100000)
            .length ??
        0;

    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final String formattedTime = DateFormat('HH:mm:ss').format(now);

    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/fondoapp.jpg',
              fit: BoxFit.cover,
            ),
            Stack(children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 70, horizontal: 0),
                height: 1000,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      width: 10,
                      color: Colors.black38,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedSwitcher(
                        duration: Duration(seconds: 1),
                        child: Center(
                          child: Text(
                            'REGISTRO DE OPERACION RETIRO',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: AnimatedSwitcher(
                              duration: Duration(seconds: 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Fecha: ',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text(''),
                                      Text('Hora: ',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text(''),
                                      Text('TIPO DE OPERACION',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text(''),
                                      Text('NO. DE CUENTA',
                                          style: TextStyle(
                                              
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text(''),
                                      Text('POR VALOR DE',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text(''),
                                      Text('COSTO DE OPERACION',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text(''),
                                      Text('Billetes devueltos',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text('\$100.000',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text('\$50.000',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text('\$20.000',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text('\$10.000',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('$formattedDate',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text(''),
                                      Text('$formattedTime',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text(''),
                                      Text('RETIRO',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text(''),
                                      Text(
                                        '${cuentanequi}',
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 14),
                                      ),
                                      Text(''),
                                      Text('\$ ${controller.cantidadRetiro}',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text(''),
                                      Text(' \$0.00',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text(''),
                                      Text('CANTIDAD',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text('$billete100k',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text('$billete50k',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text('$billete20k',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                      Text('$billete10k',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'BANCOAGIL',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38),
                      ),
                      Text(''),
                      Text(
                          'TODA TRANSACCION ESTA SUJETA A VERIFICACION Y APROBACION',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38)),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.blue),
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                            padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0)),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                                side: BorderSide(
                                  color: Colors.white12,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () => Get.offAllNamed('/'),
                          child: SizedBox(
                            width: 90,
                            child: Row(
                              children: [
                                Text('Finalizar'),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.cancel)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
