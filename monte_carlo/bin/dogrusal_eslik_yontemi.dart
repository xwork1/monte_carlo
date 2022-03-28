import 'dart:math';

void main(List<String> args) {
  // Random sayı üreteci
  Random random = Random();

  // 100 adet random sayı döndürme değeri.
  for (int i = 0; i < 100; i++) {
    print(random.nextDouble());
  }
}

class DogrusalEslik {
  // Doğrusal eşlik için verilen değerler x(i+1) = (a * x(i) + b) % m.
  final int a = 25173;
  final int b = 13849;
  final int m = 32768;

  // Döndürmek için geçerli değer.
  int x;

  DogrusalEslik(
    this.x,
  ) {
    //Constructor, değeri 0,5'e eşdeğer olan m'nin yarısına ayarlar.
    x = (m ~/ 2);
  }

  double next() {
    // Sıradaki değeri hesaplama
    x = (a * x + b) % m;

    // 0'dan 1'e değer döndürme.
    return (x / m).toDouble();
  }
}
