import 'package:flutter/material.dart';
import 'package:projeto_api/util/componentes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    consultaCliente() {
      Navigator.of(context).pushReplacementNamed("/consulta/cliente");
    }

    consultaCidade() {
      Navigator.of(context).pushReplacementNamed("/consulta/cidade");
    }

    return Scaffold(
      appBar: Componentes().criaAppBar("Utilização API"),
      body: Form(
        key: formController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Componentes().criaCardComIconeTelaInicial(Icons.people , consultaCliente, "Consultar Clientes"),
                const SizedBox(width: 13),
                Componentes().criaCardComIconeTelaInicial(Icons.maps_home_work, consultaCidade, "Consultar Cidades"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
