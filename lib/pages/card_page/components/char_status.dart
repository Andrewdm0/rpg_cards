import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rpg_cards/main.dart';
import 'package:rpg_cards/models/personagem_bean.dart';
import 'package:rpg_cards/pages/edit_page/edit_page.dart';

import 'card_image.dart';

class CharStatus extends StatefulWidget {
  CharStatus({required this.imageUrl, required this.personagemBean});
  String imageUrl;
  PersonagemBean personagemBean;

  @override
  State<CharStatus> createState() => _CharStatusState();
}

class _CharStatusState extends State<CharStatus> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  ),
                  Text(
                    ' HP: 3',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.water_drop,
                    color: Colors.blueAccent,
                  ),
                  Text(
                    ' MP: 4',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            ],
          ),
        ),
        CardImage(url: widget.imageUrl),
        Container(
          height: 200,
          child: Align(
            child: GestureDetector(
              child: Icon(
                Icons.edit,
                shadows: [
                  Shadow(
                    color: Colors.grey[500]!,
                    blurRadius: 0.5,
                    offset: Offset(1, 1),
                  )
                ],
              ),
              onTap: () {
                print(widget.personagemBean);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditPage(personagemBean: widget.personagemBean);
                    },
                  ),
                ).then((value) => setState((){}));
              },
            ),
            alignment: Alignment.topCenter,
          ),
        )
      ],
    );
  }
}
