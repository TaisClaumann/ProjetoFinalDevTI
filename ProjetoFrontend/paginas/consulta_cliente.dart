import 'package:flutter/material.dart';
import 'package:projeto_api/api/acesso_api.dart';
import 'package:projeto_api/model/cidade.dart';
import 'package:projeto_api/model/cliente.dart';
import 'package:projeto_api/util/componentes.dart';

class ConsultaCliente extends StatefulWidget {
  const ConsultaCliente({super.key});

  @override
  State<ConsultaCliente> createState() => _ConsultaState();
}

class _ConsultaState extends State<ConsultaCliente> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<Cliente> lista = [];

   listarTodas() async {
      List<Cliente> clientes = await AcessoApi().listaClientes();
      setState(() {
        lista = clientes;
      });
    }

   @override
    void initState() {
      listarTodas();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed("/home");
    }

    irTelaCadastro() {
      Navigator.pushNamed(
        context,
        "/cadastro/cliente",
        arguments: Cliente(0, "", "", 0, Cidade(0,"", "")),
      );
    }

    criaItemCliente(Cliente c) {
    String sexo = c.sexo == "M" ? "Masculino" : "Feminino";
    return ListTile(
      title: Componentes().criaTexto("${c.id} - ${c.nome}  (${c.cidade.nome}/${c.cidade.uf})"),
      subtitle: Componentes().criaTexto("${c.idade} anos - ${c.sexo}"),
      trailing: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(context, "/cadastro/cliente",
                        arguments: c);
                  }),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await AcessoApi().deletaCliente(c.id);
                    setState(() {
                      listarTodas();
                    });
                  })
            ],
          ),
      )
    );
  }

    return Scaffold(
      appBar: Componentes().criaAppBarSearchCliente("Buscar Clientes", home, context),
      body: Form(
        key: formController,
        child: Column(
          children: <Widget> [
            Componentes()
                .criaBotao(formController, listarTodas, "Listar Todas"),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, indice) {
                      return Card(
                        elevation: 6,
                        margin: const EdgeInsets.all(5),
                        child: criaItemCliente(lista[indice]),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: irTelaCadastro,
        backgroundColor:const Color.fromARGB(255, 119, 60, 153),
        child: const Icon(Icons.add, color: Colors.white),
       )
    );
  }
}
