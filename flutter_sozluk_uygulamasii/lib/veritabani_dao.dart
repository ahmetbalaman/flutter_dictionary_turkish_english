import 'package:flutter_sozluk_uygulamasii/VeritabaniYardimcisi.dart';
import 'package:flutter_sozluk_uygulamasii/kelimeler_class.dart';

class VeritabaniDAO{

  Future<List<Kelimeler>> listele() async{

    var db=await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps =
    await db.rawQuery("SELECT * FROM kelimeler");

    return List.generate(maps.length, (index) {
      var row = maps[index];
      return Kelimeler(kelimeId: row["kelime_id"], kelimeE: row["ingilizce"], kelimeT: row["turkce"]);
    });

  }

  Future<List<Kelimeler>> ara(String? aramakelimesi) async{

    var db=await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps =
    await db.rawQuery("SELECT * FROM kelimeler WHERE ingilizce like '%$aramakelimesi%'");

    return List.generate(maps.length, (index) {
      var row = maps[index];
      return Kelimeler(kelimeId: row["kelime_id"], kelimeE: row["ingilizce"], kelimeT: row["turkce"]);
    });

  }
}