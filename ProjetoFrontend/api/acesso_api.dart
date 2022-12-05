import 'dart:convert';

import 'package:http/http.dart';
import 'package:projeto_api/model/cidade.dart';
import 'package:projeto_api/model/cliente.dart';

class AcessoApi {
  Future<List<Cliente>> listaClientes() async {
    String url = 'http://localhost:8090/cliente';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = utf8.decode(resposta.bodyBytes);
    Iterable a = json.decode(jsonFormatadoUtf8);
    List<Cliente> clientes = List<Cliente>.from(a.map((p) => Cliente.fromJson(p)));
    return clientes;
  }

  Future<List<Cidade>> listaCidades() async {
    String url = 'http://localhost:8090/cidade';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = utf8.decode(resposta.bodyBytes);
    Iterable a = json.decode(jsonFormatadoUtf8);
    List<Cidade> cidades = List<Cidade>.from(a.map((c) => Cidade.fromJson(c)));
    return cidades;
  }

  Future<void> insereCliente(Map<String, dynamic> cliente) async {
    String url = 'http://localhost:8090/cliente';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    Response resposta =
      await post(Uri.parse(url), headers: headers, body: json.encode(cliente));
  }

  Future<void> insereCidade(Map<String, dynamic> cidade) async {
    String url = 'http://localhost:8090/cidade';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    Response resposta =
      await post(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }

  Future<void> alteraPessoa(Map<String, dynamic> pessoa, int id) async {
    String url = 'http://localhost:8090/cliente?id=${id}';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await put(Uri.parse(url), headers: headers, body: jsonEncode(pessoa));
  }

  Future<void> alteraCidade(Map<String, dynamic> cidade, int id) async {
    String url = 'http://localhost:8090/cidade?id=${id}';

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await put(Uri.parse(url), headers: headers, body: jsonEncode(cidade));
  }

  Future<void> deletaCliente(int id) async {
    print(id);
    String url = 'http://localhost:8090/cliente/${id}';
    await delete(Uri.parse(url));
  }

  Future<void> deletaCidade(int id) async {
    String url = 'http://localhost:8090/cidade/${id}';
    await delete(Uri.parse(url));
  }
}
