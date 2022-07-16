import 'package:flutter/material.dart';
import 'package:flutter_sozluk_uygulamasii/show_word.dart';
import 'package:flutter_sozluk_uygulamasii/veritabani_dao.dart';

import 'kelimeler_class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sozluk Uygulamasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<Kelimeler>> kelimeleriGetir() async{
    List<Kelimeler> liste=await VeritabaniDAO().listele();
    return liste;
  }

  Future<List<Kelimeler>> kelimeleriAra(String aramakelimesi) async{
    List<Kelimeler> liste=await VeritabaniDAO().ara(aramakelimesi);
    return liste;
  }
  String aramaKismi="";
  bool secildi=false;
  @override
  Widget build(BuildContext context) {

    var ekranolc=MediaQuery.of(context).size;
    var ekranyuk=ekranolc.height;
    var ekrangen=ekranolc.width;

    return Scaffold(
        appBar: AppBar(
          title: secildi ?  TextField(decoration: const InputDecoration(hintText: "Deneme"),onChanged: (String? arama){
            setState((){
              aramaKismi=arama.toString();
            });
          },):const Text("Sozluk Uygulaması"),
          actions:[
            Padding(
              padding:  EdgeInsets.only(right: ekrangen/12),
              child: GestureDetector(child: secildi ? const  Icon(Icons.cancel) :const Icon(Icons.search),onTap: (){
                setState((){
                  secildi=!secildi;
                  aramaKismi="";
                });
                 }),
            ),
          ],
        ),
        body: FutureBuilder<List<Kelimeler>>(
          future:secildi? kelimeleriAra(aramaKismi) : kelimeleriGetir(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              List<Kelimeler>? listeler=snapshot.data!;
              return  ListView.builder(
                itemCount: listeler.length,
                itemBuilder: (context, index) {
                  var liste=listeler[index];
                  return GestureDetector(
                    child: SizedBox(
                      height: ekranyuk/10,
                      child: Card(
                          elevation: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(liste.kelimeE.toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
                              Text(liste.kelimeT.toString()),
                            ],
                          )),
                    ),
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowWord(liste))),
                  );

                },
              );

            }else{
              return const Center();
            }
          },
        )
       );
  }
}
