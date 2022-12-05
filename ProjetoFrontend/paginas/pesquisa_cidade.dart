import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projeto_api/api/acesso_api.dart';
import 'package:projeto_api/model/cidade.dart';
import 'package:projeto_api/util/componentes.dart';

class Pesquisa extends SearchDelegate<AcessoApi> {
  @override
  String get searchFieldLabel => "Ex: cidade ou Uf";

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
      future: buscaCidadePorNome(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
           List<Cidade> cidades = snapshot.data!.cast<Cidade>();
          return ListView.builder(
              itemCount: cidades.length,
              itemBuilder: (context, index) {
                return Componentes().criaItemCidade(cidades[index], context);
              });
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Erro ao pesquisar cidade"),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<Cidade>> buscaCidadePorNome(String nomeCidade) async {
    String url = "http://localhost:8090/cidade/sugest/${nomeCidade}";
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = utf8.decode(resposta.bodyBytes);
    Iterable a = json.decode(jsonFormatadoUtf8);
    List<Cidade> cidadesNome =
        List<Cidade>.from(a.map((c) => Cidade.fromJson(c)));
    return cidadesNome;
  }
}
