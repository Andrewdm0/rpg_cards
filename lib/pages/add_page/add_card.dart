import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpg_cards/helpers/pickUploadImage.dart';
import 'package:rpg_cards/models/personagem_bean.dart';
import 'package:rpg_cards/pages/add_page/components/add_text_field.dart';
import 'package:rpg_cards/pages/add_page/components/botao_drop_down.dart';
import 'package:rpg_cards/pages/card_page/components/card_column.dart';
import 'package:rpg_cards/pages/card_page/components/card_image.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key, this.currentUser}) : super(key: key);
  User? currentUser;

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final imageController = TextEditingController();

  final nomeController = TextEditingController();

  String? classeDropdowntext;

  final armaController = TextEditingController();

  final ataqueController = TextEditingController();

  Widget widgetPhoto = Icon(Icons.image);

  Map imageData = {};

  FirebaseFirestore db = FirebaseFirestore.instance;

  setClasseDropdownText(String value) {
    setState(() {
      classeDropdowntext = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: const BoxDecoration(
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
                  GestureDetector(
                    onTap: () async {
                      imageData = await pickUploadImage('',null, context);
                      widgetPhoto = imageData['widgetPhoto'];
                      print('AQUI TA OS DADOS DA IMAGE DATA $imageData');
                      setState(() {});
                    },
                    child: Container(
                      width: 180,
                      height: 180,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: const BoxDecoration(
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
                      child: widgetPhoto,
                    ),
                  ),
                  AddTextField(
                    controller: nomeController,
                    label: 'Nome do personagem',
                    hint: 'Ex. Cleiton',
                  ),
                  BotaoDropDown(
                      callback: setClasseDropdownText,
                      classeText: classeDropdowntext),
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
                  ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> personagem = {
                          'image': imageData['imageUrl'] == null
                              ? 'http://1.bp.blogspot.com/-3rQ8tv7qbno/VNzzO2HyEII/AAAAAAAAAJI/7LrSFFanmys/s1600/colocando%2Bavatar%2Bem%2Bcomentarios%2Banonimos.jpg'
                              : imageData['imageUrl'],
                          'imageRef': imageData['imageRef'] == null
                              ? ''
                              : imageData['imageRef'],
                          'nome': nomeController.text,
                          'classe': classeDropdowntext == null
                              ? 'Mago'
                              : classeDropdowntext,
                          'arma': armaController.text,
                          'ataque': ataqueController.text,
                          'userUid': widget.currentUser!.uid,
                          'dado': '1'
                        };
                        db.collection("characters").add(personagem);
                        Navigator.pop(context);
                      },
                      child: const Text('Criar')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
