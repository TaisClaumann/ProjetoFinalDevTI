import 'package:flutter/material.dart';
import 'package:projeto_api/api/acesso_api.dart';
import 'package:projeto_api/model/cidade.dart';
import 'package:projeto_api/model/cliente.dart';
import 'package:projeto_api/paginas/pesquisa_cidade.dart';
import 'package:projeto_api/paginas/pesquisa_cliente.dart';

class Componentes {
  criaAppBar(texto, [acao]) {
    return AppBar(
      title: criaTexto(texto),
      centerTitle: true,
      actions: <Widget>[
        IconButton(onPressed: acao, icon: const Icon(Icons.home)),
      ],
    );
  }

  criaAppBarSearchCidade(texto, acao, [context]) {
    return AppBar(
      title: criaTexto(texto),
      centerTitle: true,
      actions: <Widget>[
        IconButton(onPressed: acao, icon: const Icon(Icons.home)),
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: Pesquisa());
          },
          icon: const Icon(Icons.search_off_rounded),
        )
      ],
    );
  }

  criaAppBarSearchCliente(texto, acao, [context]) {
    return AppBar(
      title: criaTexto(texto),
      centerTitle: true,
      actions: <Widget>[
        IconButton(onPressed: acao, icon: const Icon(Icons.home)),
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: PesquisaCliente());
          },
          icon: const Icon(Icons.search_off_rounded),
        )
      ],
    );
  }

  criaTexto(texto, [cor]) {
    if (cor != null) {
      return Text(
        texto,
        style: TextStyle(color: cor),
      );
    }
    return Text(texto);
  }

  criaImputTexto(tipoTeclado, textoEtiqueta, controlador, msgValidacao) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: tipoTeclado,
        decoration: InputDecoration(
          labelText: textoEtiqueta,
          labelStyle: const TextStyle(
            fontSize: 20.0,
          ),
        ),
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 30),
        controller: controlador,
        validator: (value) {
          if (value!.isEmpty) {
            return msgValidacao;
          }
        },
      ),
    );
  }

  criaBotao(controladorFormulario, funcao, titulo) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 119, 60, 153),
              ),
              onPressed: () {
                if (controladorFormulario.currentState!.validate()) {
                  funcao();
                }
              },
              child: Text(
                titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  criaItemCliente(Cliente cliente, context) {
    String sexo = cliente.sexo == "M" ? "Masculino" : "Feminino";
    return ListTile(
      title: criaTexto("${cliente.id} - ${cliente.nome}"),
      subtitle: criaTexto(
          "${cliente.idade} anos - ${cliente.sexo}   (${cliente.cidade.nome}/${cliente.cidade.uf})"),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, "/cadastro/cliente",
                      arguments: cliente);
                }),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await AcessoApi().deletaCliente(cliente.id);
                  Navigator.pushReplacementNamed(context, "/consulta/cliente");
                })
          ],
        ),
      ),
    );
  }

  criaItemCidade(Cidade c, context) {
    return ListTile(
      title: Componentes().criaTexto("${c.id} - ${c.nome} (${c.uf})"),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, "/cadastro/cidade",
                      arguments: c);
                }),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await AcessoApi().deletaCidade(c.id);
                  Navigator.pushReplacementNamed(context, "/consulta/cidade");
                })
          ],
        ),
      ),
    );
  }

   criaCardComIconeTelaInicial(icone, funcao, texto) {
     return Center(
      child: Card(
        elevation: 10,
        color: Color.fromARGB(83, 116, 74, 195),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 10),
              Icon(icone, size: 200.0),
              ElevatedButton(
                onPressed: funcao,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 119, 60, 153),
                  fixedSize: const Size(200, 20),
                ),
                 child: Text(texto, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
          ),
      ),
     );
  }
}
