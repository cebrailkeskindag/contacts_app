import 'package:contacts_app/data/entity/kisiler.dart';
import 'package:contacts_app/ui/views/detay_sayfa.dart';
import 'package:contacts_app/ui/views/kayit_sayfa.dart';
import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  Future<void> ara(String aramaKelimesi) async {
    print("Kişi Ara : $aramaKelimesi");
  }

  Future<void> sil(int kisi_id) async {
    print("Kişi Sil : $kisi_id");
  }

  Future<List<Kisiler>> kisileriYukle() async {
    var kisilerListesi = <Kisiler>[];
    var k1 = Kisiler(kisi_id: 1, kisi_ad: "cebrail", kisi_tel: "428");
    var k2 = Kisiler(kisi_id: 2, kisi_ad: "selin", kisi_tel: "680");
    var k3 = Kisiler(kisi_id: 3, kisi_ad: "ali", kisi_tel: "1907");
    var k4 = Kisiler(kisi_id: 4, kisi_ad: "sude", kisi_tel: "2024");
    kisilerListesi.add(k1);
    kisilerListesi.add(k2);
    kisilerListesi.add(k3);
    kisilerListesi.add(k4);
    return kisilerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? TextField(
                decoration: const InputDecoration(hintText: "Ara"),
                onChanged: (aramaSonucu) {
                  ara(aramaSonucu);
                },
              )
            : const Text("Kişiler"),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                    });
                  },
                  icon: const Icon(Icons.clear))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                  icon: const Icon(Icons.search))
        ],
      ),
      body: FutureBuilder(
          future: kisileriYukle(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var kisilerListesi = snapshot.data;
              return ListView.builder(
                itemCount: kisilerListesi!.length,
                itemBuilder: (context, index) {
                  var kisi = kisilerListesi[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetaySayfa(
                                        kisi: kisi,
                                      )))
                          .then((value) => {print("Anasayfaya dönüldü.")});
                    },
                    child: Card(
                      child: Row(
                        children: [
                          Column(
                            children: [Text(kisi.kisi_ad), Text(kisi.kisi_tel)],
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("${kisi.kisi_ad} silinsin mi?"),
                                  action: SnackBarAction(
                                    label: "Evet",
                                    onPressed: () {
                                      sil(kisi.kisi_id);
                                    },
                                  ),
                                ));
                              },
                              icon: const Icon(Icons.clear))
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const KayitSayfa()))
              .then((value) => {print("Anasayfaya dönüldü.")});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
