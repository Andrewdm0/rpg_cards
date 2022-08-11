import 'package:flutter/material.dart';
import '../../../models/personagem_bean.dart';
import 'card_row.dart';

class CardColumn extends StatelessWidget {
  final PersonagemBean personagemBean;

  CardColumn({required this.personagemBean});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardRow(
          chave: 'Nome:',
          valor: personagemBean.nome,
        ),CardRow(
          chave: 'Classe:',
          valor: personagemBean.classe,
        ),CardRow(
          chave: 'Arma:',
          valor: personagemBean.arma,
        ),CardRow(
          chave: 'Ataque:',
          valor: personagemBean.ataque,
        ),
      ],
    );
  }
}
