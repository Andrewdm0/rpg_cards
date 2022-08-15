import 'package:flutter/material.dart';
import 'package:rpg_cards/models/personagem_bean.dart';

import '../card_page.dart';

class TileList extends StatelessWidget {
  final PersonagemBean personagemBean;

  const TileList({Key? key, required this.personagemBean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black)],
      ),
      child: ListTile(
        title: Text(
          personagemBean.nome,
          style: TextStyle(fontSize: 20),
        ),
        trailing: Text(
          personagemBean.classe,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CardPage(
                  personagemBean: personagemBean,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
