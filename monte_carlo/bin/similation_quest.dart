// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:math';
import 'package:excel/excel.dart';

void main(List<String> args) {
  var file = "ketcapfabrikasi.xlsx"; //excel dosyasının okunması
  var bytes = File(file).readAsBytesSync(); //excel dosyasının okunması
  var excel = Excel.decodeBytes(bytes); //decode edilmesi
  var miktar = <dynamic>[];
  var aylar = []; // [] dizi türü olarak tanımlanıyor
  var map = {}; // map yapısı ile tanımlanıyor (dizi türünün gelişmiş hali)

  //Miktarı diziye alma, Excel verisini çekme
  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table]!.rows) {
      var a = row.map((e) => e?.value).toList();
      miktar.add(a[1]); // miktar kısmını böyle çektim
      aylar.add(a[0]); // aylar kısmını bu diziye aldım
    }
  }
  aylar.remove('Ay'); //ay ve miktar dizisini diziye aldıktan sonra rahat işlem
  miktar.remove('Miktar'); //yapmak amacıyla sildim

  //Frekans bulma
  print('Miktar ->: ' + miktar.toString());
  print('************************');
  for (var element in miktar) {
    //foreach döngüsü ile gezip miktarları buldum
    if (!map.containsKey(element)) {
      map[element] = 1;
    } else {
      map[element] += 1;
    }
  }
  print('Frekans ->: ' +
      map.toString()); //gezdikten sonra aynı değerleri birbirine ekledim
  print('************************');
  //map te miktarlar mevcut hale geldi frekans işlemi yaptırdım
  //Frekans Olasılığı Hesaplanması
  num i = 0;
  map.forEach((key, value) {
    i += value;
  });
  final frekans = {};
  map.forEach((key, value) {
    frekans[key] = value / i;
  });
  print('Frekans Olasılığı ->: ' + frekans.toString());
  print('************************');
  //sortedkeys = 3,4,5,6 da mevcut frekansın düzenlenmesi için kullandım sırayla işlem olması için
  //Kümülatif Olasılığı hesaplanması
  var sortedKeys = map.keys.toList()..sort();
  var j;
  for (var k = 0; k < map.length; k++) {
    if (k == 0) {
      map[sortedKeys[k]] = 0;
      j = sortedKeys[k];
      continue;
    }
    map[sortedKeys[k]] = frekans[j] + map[j];
    j = sortedKeys[k];
  }
  print('Kümülatif Olasılık ->: ' + map.toString());
  print('************************');
  var randoms = {};
  for (var key in aylar) {
    randoms[key] = Random().nextDouble();
  }

  //12 ay için (0-1) aralığında ondalıklı rastgele sayıların üretilmesi
  print(
      '12 ay için (0-1) aralığında ondalıklı rastgele sayıların üretilmesi ->: ' +
          randoms.toString());
  print('************************');
  var newValues = {};
  randoms.forEach((key, value) {
    for (var k = 0; k < map.length - 1; k++) {
      if (value > map[sortedKeys[k]] && value < 1) {
        newValues[key] = sortedKeys[k + 1];
      }
      if (value > map[sortedKeys[k]] && value < map[sortedKeys[k + 1]]) {
        newValues[key] = sortedKeys[k];
      }
    }
  });

  //Kümülatif Olasılık değerlerinden karşılık gelen Miktar değeri
  print('Kümülatif Olasılık değerlerinden karşılık gelen Miktar değeri ->: ' +
      newValues.toString());
  print('************************');
  //ilk frekans düzenleme işlemi (aylar için)
  var lastMap = {};
  newValues.forEach((key, value) {
    if (!lastMap.containsKey(value)) {
      lastMap[value] = 1;
    } else {
      lastMap[value] += 1;
    }
  });
  print('ilk deneme ->: ' + lastMap.toString());
  print('************************');

  //1000. döndürme işlemi
  for (var k = 0; k < 1000; k++) {
    newValues = {};
    lastMap = {};
    for (var key in aylar) {
      randoms[key] = Random().nextDouble();
    }
    randoms.forEach((key, value) {
      for (var k = 0; k < map.length - 1; k++) {
        if (k < map.length - 1) {
          if (value > map[sortedKeys[k]] && value < 1) {
            newValues[key] = sortedKeys[k + 1];
          }
        }
        if (value > map[sortedKeys[k]] && value < map[sortedKeys[k + 1]]) {
          newValues[key] = sortedKeys[k];
        }
      }
    });
    newValues.forEach((key, value) {
      if (!lastMap.containsKey(value)) {
        lastMap[value] = 1;
      } else {
        lastMap[value] += 1;
      }
    });
  }
  print('1000. Deneme->: ' + lastMap.toString());
}
