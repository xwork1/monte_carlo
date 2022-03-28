import 'dart:math';

void main(List<String> args) {
  List<int> dizi = [
    1,
    10,
    100,
    1000,
    10000,
    100000,
    1000000,
    10000000,
    100000000,
    1000000000,
  ]; 
  //rastgele oluşan sayıyı işleme sokma fonksiyonu
  ortakareyontemi(int sayi, int hane) {
    int ortakare, nextnum = 0, trim;
    trim = hane ~/ 2; //ortadaki sayıyı almak için
    ortakare = sayi * sayi;
    print(ortakare); //kare alım işlemi
    ortakare = ortakare ~/ dizi[trim]; //diziye aktarım ortanca sayı için
   
    for (int i = 0; i < hane; i++) { //hane kadar diziyi döndürme işlemi
      nextnum += (ortakare % (dizi[trim])) * (dizi[i]); //sayıların tekrar işlemi sokulması
      ortakare = ortakare ~/ 10; 
    }
    return nextnum;
  }

  int basamaksayisi = 3; //alınacak basamak sayısı
  int baslangic, bitis;
  baslangic = dizi[basamaksayisi-1]; //bir önceki basamagı al
  bitis = dizi[basamaksayisi]; // bir sonraki basamakta son bul
  //random sayı oluşturma kısmı
  Random random = Random(); //ilk oluşan sayı için random fonksiyon
  int sonrakiSayi;
  sonrakiSayi = random.nextInt(bitis - baslangic) + baslangic; //sonraki sayı için ortadan 3 basamağı alma
  print('Random oluşan Orta Kare sayı:' + sonrakiSayi.toString() + ', ');
  for (var i = 0; i < 100; i++) { //100e kadar random sayıyla işlem yapma
    sonrakiSayi = ortakareyontemi(sonrakiSayi, basamaksayisi);
    print(sonrakiSayi.toString() + 'un karesi ->, ');
  }
}
