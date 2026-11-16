import 'package:flutter/material.dart';
import '../modeller/sepet_elemani.dart';

class SepetEkrani extends StatefulWidget {
  final List<SepetElemani> sepet;
  final VoidCallback sepetiGuncelle;

  const SepetEkrani({
    super.key,
    required this.sepet,
    required this.sepetiGuncelle,
  });

  @override
  State<SepetEkrani> createState() => _SepetEkraniState();
}

class _SepetEkraniState extends State<SepetEkrani> {
  double get toplamTutar =>
      widget.sepet.fold(0, (toplam, e) => toplam + (e.urun.fiyat * e.adet));

  void adetDegistir(SepetElemani eleman, int artis) {
    setState(() {
      eleman.adet += artis;
      if (eleman.adet <= 0) widget.sepet.remove(eleman);
    });
    widget.sepetiGuncelle();
  }

  void urunSil(SepetElemani eleman) {
    setState(() => widget.sepet.remove(eleman));
    widget.sepetiGuncelle();
  }

  void siparisVer() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sipariş Alındı"),
        content: Text("Toplam ${toplamTutar.toInt()} TL tutarındaki siparişiniz onaylandı."),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => widget.sepet.clear());
              widget.sepetiGuncelle();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Tamam"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: widget.sepet.isEmpty
          ? const Center(child: Text("Sepetiniz boş.", style: TextStyle(fontSize: 18)))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.sepet.length,
                    itemBuilder: (context, i) {
                      SepetElemani eleman = widget.sepet[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: Image.network(
                            eleman.urun.resim,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, e, s) => const Icon(Icons.fitness_center),
                          ),
                          title: Text(eleman.urun.isim),
                          subtitle: Text("${(eleman.urun.fiyat * eleman.adet).toInt()} TL"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(icon: const Icon(Icons.remove), onPressed: () => adetDegistir(eleman, -1)),
                              Text("${eleman.adet}"),
                              IconButton(icon: const Icon(Icons.add), onPressed: () => adetDegistir(eleman, 1)),
                              IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => urunSil(eleman)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Toplam: ${toplamTutar.toInt()} TL",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: siparisVer,
                        child: const Text("Siparişi Tamamla"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
