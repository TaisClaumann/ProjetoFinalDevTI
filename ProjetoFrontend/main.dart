import 'package:flutter/material.dart';
import 'package:projeto_api/paginas/cadastro_cidade.dart';
import 'package:projeto_api/paginas/cadastro_cliente.dart';
import 'package:projeto_api/paginas/consulta_cidade.dart';
import 'package:projeto_api/paginas/consulta_cliente.dart';
import 'package:projeto_api/paginas/home.dart';
import 'package:projeto_api/util/tema.dart';

void main() {
  runApp(const API());
}

class API extends StatefulWidget {
  const API({Key? key}) : super(key: key);


  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Tema().criaTema(),
      initialRoute: "/home",
      routes: {
        "/home": (context) => const Home(),
        "/consulta/cliente": (context) => const ConsultaCliente(),
        "/cadastro/cliente": (context) => const CadastroCliente(),
        "/cadastro/cidade": (context) => const CadastroCidade(),
        "/consulta/cidade": (context) => const ConsultaCidade(),
      },
    );
  }
}
