import 'package:contacts_app/data/entity/kisiler.dart';
import 'package:contacts_app/ui/views/detay_sayfa.dart';
import 'package:flutter/material.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({Key? key}) : super(key: key);

  @override
  _KayitSayfaState createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

  Future<void> kaydet(String kisi_ad, String kisi_tel) async {
    print("Kişi Kaydet : $kisi_ad - $kisi_tel");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kayıt Sayfası"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfKisiAdi,
                decoration: const InputDecoration(hintText: "Kişi Adı"),
              ),
              TextField(
                controller: tfKisiTel,
                decoration: const InputDecoration(hintText: "Kişi Telefon"),
              ),
              ElevatedButton(
                  onPressed: () {
                    kaydet(tfKisiAdi.text, tfKisiTel.text);
                    var kisi =
                        Kisiler(kisi_id: 1, kisi_ad: "ceke", kisi_tel: "428");
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetaySayfa(
                                      kisi: kisi,
                                    )))
                        .then((value) => {print("Anasayfaya dönüldü.")});
                  },
                  child: const Text("Kaydet"))
            ],
          ),
        ),
      ),
    );
  }
}
