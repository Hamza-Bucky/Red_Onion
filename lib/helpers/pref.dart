import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/vpn.dart';

class Pref {
  static late Box _box;
  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('data');
  }

//FOR REMEMBERING THEME CHOICE ON RESTART
  static bool get isDarkMode => _box.get('isDarkMode') ?? false;
  static set isDarkMode(bool v) => _box.put('isDarkMode', v);
//STORING START UP/RECENTLY USED VPN DETAIL IN CHACHE
  static Vpn get vpn => Vpn.fromJson(jsonDecode(_box.get('vpn') ?? '{}'));
  static set vpn(Vpn v) => _box.put('vpn', jsonEncode(v));

//FOR STORING VPN LOCATION SERVERS SO THAT IT WONT TAKE TO MUCH TIME
  static List<Vpn> get vpnList {
    List<Vpn> temp = [];
    final data = jsonDecode(_box.get('vpnList') ?? '[]');
    for (var i in data) temp.add(Vpn.fromJson(i));
    return temp;
  }

  static set vpnList(List<Vpn> v) => _box.put('vpnList', jsonEncode(v));
}
