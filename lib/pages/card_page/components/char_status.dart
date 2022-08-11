import 'package:flutter/material.dart';

import 'card_image.dart';

class CharStatus extends StatefulWidget {
  CharStatus({Key? key, required this.imageUrl}) : super(key: key);
  String imageUrl;

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
      ],
    );
  }
}
