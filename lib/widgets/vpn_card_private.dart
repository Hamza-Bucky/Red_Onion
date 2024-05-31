import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/home_controller.dart';
import '../helpers/snack_bar.dart';
import '../main.dart';
import '../services/vpn_engine.dart';

class vpncard_private extends StatelessWidget {
  const vpncard_private({super.key});

  @override
  Widget build(BuildContext context) {
    final controllor = Get.find<HomeController>();

    return Card(
        margin: EdgeInsets.all(mediaq.height * 0.01),
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xffffa28d),
              Color(0xfffc878c),
              Color(0xfffc7c8c),
              Color(0xfffc4584)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(0.1),
          )),
          child: InkWell(
            onTap: () {
              Get.back();
              MyDialogs.success(prompt: 'Server Selected');
              if (controllor.vpnState == VpnEngine.vpnConnected) {
                VpnEngine.stopVpn();
                Future.delayed(Duration(seconds: 2), () {
                  controllor.privat_connectToVpn();
                });
              } else {
                controllor.privat_connectToVpn();
              }
            },
            borderRadius: BorderRadius.circular(15),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11)),
              leading: Container(
                  padding: EdgeInsets.all(0.5),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffffa28d),
                          Color(0xfffc878c),
                          Color(0xfffc878c),
                          Color(0xfffc878c)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                        transform: GradientRotation(0.1),
                      ),
                      borderRadius: BorderRadius.circular(7)),
                  //VPN LIST IMAGES PROPERTIES
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/flags/fr.png',
                      height: mediaq.width * 0.15,
                      width: mediaq.width * 0.2,
                      fit: BoxFit.cover,
                    ),
                  )),
              //TITLE FOR CONTRY ON VPN LIST<><>><><<><><><><>><><<<><><><<<>
              title: Text(
                'France',
                style: TextStyle(
                    fontFamily: 'poppin',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: Theme.of(context).LightText),
              ),
              //SUBTITLE FOR VPN LIST
              subtitle: Row(
                children: [
                  Icon(
                    Icons.speed_rounded,
                    color: Theme.of(context).LightText,
                  ),
                  SizedBox(
                    width: mediaq.width * 0.03,
                  ),
                  Text(
                    _formatBytes(203, 1),
                    style: TextStyle(
                        fontFamily: 'poppin',
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                        color: Theme.of(context).LightText),
                  )
                ],
              ),
              //TRAILING SECTION
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '3',
                    style: TextStyle(
                        color: Theme.of(context).LightText,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'poppin',
                        fontSize: 13),
                  ),
                  SizedBox(
                    width: mediaq.width * 0.03,
                  ),
                  Icon(
                    Icons.person_2,
                    size: 35,
                    color: Colors.lightBlue,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = ['Bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps'];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)}${suffixes[i]}';
  }
}
