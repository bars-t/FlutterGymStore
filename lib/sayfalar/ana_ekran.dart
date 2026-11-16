import 'package:flutter/material.dart';
import '../veriler/urunler_verisi.dart';
import '../modeller/urun.dart';
import '../modeller/sepet_elemani.dart';
import '../bilesenler/urun_karti.dart';
import 'urun_detay_ekrani.dart';
import 'sepet_ekrani.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  List<Urun> filtrelenenler = tumUrunler;
  List<SepetElemani> sepet = [];
  String secilenKategori = "Tümü";
  TextEditingController aramaKontrolcusu = TextEditingController();

  final List<String> kategoriler = [
    "Tümü", "Ağırlık", "Fitness", "Yoga & Pilates",
    "Aksesuar", "Kardiyo", "Ekipman", "Besin Takviyesi"
  ];

  void sepeteEkle(Urun urun) {
    setState(() {
      for (var e in sepet) {
        if (e.urun.id == urun.id) {
          e.adet++;
          return;
        }
      }
      sepet.add(SepetElemani(urun: urun));
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${urun.isim} sepete eklendi!"), duration: const Duration(seconds: 1)),
    );
  }

  void filtrele() {
    String ara = aramaKontrolcusu.text.toLowerCase().trim();
    setState(() {
      filtrelenenler = tumUrunler.where((u) {
        return u.isim.toLowerCase().contains(ara) &&
            (secilenKategori == "Tümü" || u.kategori == secilenKategori);
      }).toList();
    });
  }

  int get toplamAdet => sepet.fold(0, (toplam, e) => toplam + e.adet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("gymStore"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Badge(
              label: Text("$toplamAdet"),
              isLabelVisible: toplamAdet > 0,
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SepetEkrani(
                    sepet: sepet,
                    sepetiGuncelle: () => setState(() {}),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: aramaKontrolcusu,
              onChanged: (deger) => filtrele(),
              decoration: const InputDecoration(
                hintText: "Ürün ara...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: kategoriler.length,
              itemBuilder: (context, i) {
                bool secili = secilenKategori == kategoriler[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(kategoriler[i], style: TextStyle(fontSize: 12, color: secili ? Colors.white : Colors.black)),
                    selected: secili,
                    selectedColor: Colors.deepOrange,
                    onSelected: (val) {
                      setState(() => secilenKategori = kategoriler[i]);
                      filtrele();
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: filtrelenenler.isEmpty
                ? const Center(child: Text("Ürün bulunamadı."))
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filtrelenenler.length,
                    itemBuilder: (context, i) {
                      Urun urun = filtrelenenler[i];
                      return UrunKarti(
                        urun: urun,
                        tiklandiginda: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UrunDetayEkrani(
                                urun: urun,
                                sepeteEkle: () => sepeteEkle(urun),
                              ),
                            ),
                          );
                        },
                        sepeteEkle: () => sepeteEkle(urun),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
