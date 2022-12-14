import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  String url;

  CardImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 200,
        minWidth: 200,
        maxHeight: 300,
        maxWidth: 200,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black)]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // Image border
        child: SizedBox.fromSize(
          child: FadeInImage.assetNetwork(
            placeholder: 'lib/assets/gif_loading.gif',
            image: url,
            fit: BoxFit.fitWidth,
            height: 250,
          ),
        ),
      ),
    );
  }
}
