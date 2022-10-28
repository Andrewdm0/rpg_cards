import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rpg_cards/helpers/random_generator.dart';
import 'package:rpg_cards/main.dart';
import 'package:rpg_cards/pages/card_page/components/char_status.dart';
import 'package:rpg_cards/pages/card_page/components/dice_box.dart';
import '../../helpers/send_push.dart';
import '../../models/personagem_bean.dart';
import 'components/card_column.dart';
import 'components/card_image.dart';

class CardPage extends StatefulWidget {
  final PersonagemBean personagemBean;

  CardPage({required this.personagemBean});

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var numero;
  int diceSize = 20;
  int id = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numero = widget.personagemBean.dado;
  }

  void changeSize(id){
    switch (id) {
      case 0:
        diceSize = 3;
        break;
      case 1:
        diceSize = 6;
        break;
      case 2:
        diceSize = 20;
        break;
    }
  }

  rollDice() {
    setState(() {
      var random = getRandomNumber(diceSize);
      numero = random;
    });
    db
        .collection('characters')
        .doc(widget.personagemBean.id)
        .update({'dado': '$numero'});
    sendPushMessage(numero, widget.personagemBean.nome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.personagemBean.nome),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Colors.black,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CharStatus(imageUrl: widget.personagemBean.image, personagemBean: widget.personagemBean),
                  SizedBox(height: 20),
                  CardColumn(personagemBean: widget.personagemBean),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      (numero == null) ? '0' : numero.toString(),
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DiceBox(text: 'd3',setChangeSize: changeSize,id: 0,),
                      DiceBox(text: 'd6',setChangeSize: changeSize,id: 1,),
                      DiceBox(text: 'd20',setChangeSize: changeSize,id: 2,),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: rollDice,
                    child: Text(
                      'Role os Dados',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
