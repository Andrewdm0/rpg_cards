import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rpg_cards/main.dart';
import 'package:rpg_cards/models/personagem_bean.dart';
import 'package:rpg_cards/pages/add_page/add_card.dart';
import 'package:rpg_cards/pages/card_page/card_page.dart';
import '../card_page/components/tile_list.dart';

class HomePage extends StatelessWidget {
  HomePage(this.currentUser);
  FirebaseFirestore db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  User? currentUser;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Cards RPG',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: db.collection("characters").orderBy("nome").snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      List<DocumentSnapshot> personagens =
                          snapshot.data!.docs.toList();
                      List<PersonagemBean> lista_personagens = [];
                      personagens.forEach((element) {
                        lista_personagens.add(
                          PersonagemBean(
                            nome: element['nome'],
                            classe: element['classe'],
                            arma: element['arma'],
                            ataque: element['ataque'],
                            image: element['image'],
                            imageref: element['imageRef'],
                            id: element.id,
                            userUid: element['userUid'],
                            dado: element['dado'],
                          ),
                        );
                      });

                      return Container(
                        height: size.height * 0.6,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Slidable(
                              endActionPane: ActionPane(
                                extentRatio: 0.2,
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (value) {
                                      if (currentUser?.uid ==
                                          'HBGrv9VtszeVrQBM1MNpOGZxco82' || currentUser?.uid == personagens[index]['userUid']) {
                                        db
                                            .collection('characters')
                                            .doc(personagens[index].id)
                                            .delete();
                                        FirebaseStorage.instance
                                            .ref()
                                            .child(lista_personagens[index]
                                                .imageref)
                                            .delete();
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // retorna um objeto do tipo Dialog
                                            return AlertDialog(
                                              title: new Text("Erro"),
                                              content: new Text(
                                                  "Você não tem permissão!"),
                                              actions: <Widget>[
                                                // define os botões na base do dialogo
                                                new TextButton(
                                                  child: new Text("Fechar"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    backgroundColor: Colors.redAccent,
                                    icon: Icons.delete,
                                    label: 'Deletar',
                                  )
                                ],
                              ),
                              child: TileList(
                                personagemBean: lista_personagens[index],
                              ),
                            );
                          },
                          itemCount: personagens.length,
                        ),
                      );
                  }
                }),
            Padding(
              padding: const EdgeInsets.all(0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(50, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddPage(currentUser: currentUser);
                      },
                    ),
                  );
                },
                child: Text('Adicionar personagem'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
