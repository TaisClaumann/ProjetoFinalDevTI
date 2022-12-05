import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projeto_api/api/acesso_api.dart';
import 'package:projeto_api/model/cliente.dart';
import 'package:projeto_api/util/componentes.dart';

class PesquisaCliente extends SearchDelegate<AcessoApi> {
  @override
  String get searchFieldLabel => "Ex: nome, cidade, sexo...";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (() {
          query = "";
        }),
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, AcessoApi());
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder<List>(
      future: buscaClientePorNome(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
           List<Cliente> clientes = snapshot.data!.cast<Cliente>();
          return ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                return Componentes().criaItemCliente(clientes[index], context);
              });
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Erro ao pesquisar cliente"),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<Cliente>> buscaClientePorNome(String nomeCliente) async {
    String url = "http://localhost:8090/cliente/sugest/${nomeCliente}";
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = utf8.decode(resposta.bodyBytes);
    Iterable a = json.decode(jsonFormatadoUtf8);
    List<Cliente> clientes =
        List<Cliente>.from(a.map((c) => Cliente.fromJson(c)));
    return clientes;
  }
}
