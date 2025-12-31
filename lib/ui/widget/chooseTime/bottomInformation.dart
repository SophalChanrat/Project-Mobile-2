import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class Bottominformation extends StatelessWidget {
  const Bottominformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage("assets/Logo.png"), height: 200, width: 180,),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            height: 50,
            child: Bubble(
              nip: BubbleNip.leftCenter,
              color: Colors.white,
              child: Center(child: Text("You can always change later", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 14),)),
            ),
          ),
        ),
      ],
    );
  }
}
