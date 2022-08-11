import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rpg_cards/models/personagem_bean.dart';
import 'package:rpg_cards/pages/add_page/components/add_text_field.dart';
import 'package:rpg_cards/pages/card_page/components/card_column.dart';
import 'package:rpg_cards/pages/card_page/components/card_image.dart';

class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);

  final imageController = TextEditingController();
  final nomeController = TextEditingController();
  final classeController = TextEditingController();
  final armaController = TextEditingController();
  final ataqueController = TextEditingController();


  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card'),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AddTextField(
                    controller: imageController,
                    label: 'Adicione a URL de uma imagem',
                    hint: 'Ex. www.urlfoto.com',
                  ),
                  AddTextField(
                    controller:nomeController,
                    label: 'Nome do personagem',
                    hint: 'Ex. Cleiton',
                  ),
                  AddTextField(
                    controller: classeController,
                    label: 'Classe do personagem',
                    hint: 'Ex. Mago',
                  ),
                  AddTextField(
                    controller: armaController,
                    label: 'Arma do personagem',
                    hint: 'Ex. Espada',
                  ),
                  AddTextField(
                    controller: ataqueController,
                    label: 'Ataque do personagem',
                    hint: 'Ex. Golpe Cortante',
                  ),
                  ElevatedButton(onPressed: () {
                    Map<String,dynamic> personagem = {
                      'image':imageController.text,
                      'nome':nomeController.text,
                      'classe':classeController.text,
                      'arma':armaController.text,
                      'ataque':ataqueController.text,
                      'dado':'0'
                    };
                    db.collection("characters").add(personagem);
                    Navigator.pop(context);
                  }, child: Text('Criar'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
