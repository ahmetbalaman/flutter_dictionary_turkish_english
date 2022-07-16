import 'package:flutter/material.dart';

import 'kelimeler_class.dart';

class ShowWord extends StatelessWidget {
  Kelimeler kelime;


  ShowWord(this.kelime);

  @override
  Widget build(BuildContext context) {
    var ekranolc = MediaQuery.of(context).size;
    var ekranyuk = ekranolc.height;
    var ekrangen = ekranolc.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detay"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              kelime.kelimeE.toString(),
              style: TextStyle(
                  fontSize: ekranyuk / 7,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink),
            ),
            Text(
              kelime.kelimeT.toString(),
              style: TextStyle(fontSize: ekranyuk / 7),
            )
          ],
        ),
      ),
    );
  }
}
