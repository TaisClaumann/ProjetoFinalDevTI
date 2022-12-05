import 'package:flutter/material.dart';
import 'package:projeto_api/api/acesso_api.dart';
import 'package:projeto_api/model/cidade.dart';
import 'package:projeto_api/model/cliente.dart';
import 'package:projeto_api/util/combo_cidade.dart';
import 'package:projeto_api/util/componentes.dart';
import 'package:projeto_api/util/radio_sexo.dart';

class CadastroCliente extends StatefulWidget {
  const CadastroCliente({Key? key}) : super(key: key);

  @override
  State<CadastroCliente> createState() => _CadastroState();
}

class _CadastroState extends State<CadastroCliente> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtSexo = TextEditingController(text: "M");
  TextEditingController txtIdade = TextEditingController();
  TextEditingController txtCidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cliente;
    txtNome.text = args.nome;
    txtSexo.text = args.sexo;
    txtIdade.text = args.idade.toString();
    txtSexo.text = args.sexo;
    txtCidade.text = args.cidade.toString();

    cadastrar() async {
      Cliente c = Cliente(args.id, txtNome.text, txtSexo.text,
          int.parse(txtIdade.text), Cidade(int.parse(txtCidade.text), "", ""));
      if (c.id == 0) {
        await AcessoApi().insereCliente(c.toJson());
      } else {
        await AcessoApi().alteraPessoa(c.toJson(), c.id);
      }
      Navigator.of(context).pushReplacementNamed("/consulta/cliente");
    }

    home() {
      Navigator.of(context).pushReplacementNamed("/home");
    }

    return Scaffold(
      appBar: Componentes().criaAppBar("Cadastro", home),
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes().criaImputTexto(
                TextInputType.text, "Nome", txtNome, "Informe o nome"),
            Componentes().criaImputTexto(
                TextInputType.number, "Idade", txtIdade, "Informe a idade"),
            Center(
              child: RadioSexo(
                controller: txtSexo,
              ),
            ),
            Center(
              child: ComboCidade(
                controller: txtCidade,
              ),
            ),
            Componentes().criaBotao(formController, cadastrar, "Cadastrar"),
          ],
        ),
      ),
    );
  }
}
