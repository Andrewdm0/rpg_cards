import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rpg_cards/helpers/pickUploadImage.dart';
import 'package:rpg_cards/main.dart';
import 'package:rpg_cards/models/personagem_bean.dart';
import 'package:rpg_cards/pages/card_page/components/card_image.dart';

class EditPage extends StatefulWidget {
  final PersonagemBean personagemBean;
  EditPage({required this.personagemBean});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var db = FirebaseFirestore.instance;
  TextEditingController nomeTextController = TextEditingController();
  TextEditingController armaTextController = TextEditingController();
  TextEditingController ataqueTextController = TextEditingController();
  String imageUrl = '';
  String imageRef = '';
  Map imageData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nomeTextController =
        TextEditingController(text: widget.personagemBean.nome);
    armaTextController =
        TextEditingController(text: widget.personagemBean.arma);
    ataqueTextController =
        TextEditingController(text: widget.personagemBean.ataque);
    imageUrl = widget.personagemBean.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: CardImage(url: imageUrl),
                    onTap: () async {
                      imageData =
                          await pickUploadImage(widget.personagemBean.imageref,widget.personagemBean.id, context);
                        imageUrl = imageData['imageUrl'];
                        imageRef = imageData['imageRef'];
                      setState(() {
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(prefixText: 'Nome: '),
                    controller: nomeTextController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(prefixText: 'Arma: '),
                    controller: armaTextController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(prefixText: 'Ataque: '),
                    controller: ataqueTextController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          var texto = ataqueTextController.text;
                          db
                              .collection('characters')
                              .doc(widget.personagemBean.id)
                              .update({'nome': '${nomeTextController.text}'});
                          db
                              .collection('characters')
                              .doc(widget.personagemBean.id)
                              .update({'arma': '${armaTextController.text}'});

                          Navigator.pop(context);
                        },
                        child: Text('Editar')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
