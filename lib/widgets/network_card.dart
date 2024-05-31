import 'package:flutter/material.dart';

import 'package:tunnel/main.dart';
import 'package:tunnel/models/network_data.dart';

class NetworkCard extends StatelessWidget {
  final NetworkData data;

  const NetworkCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
            transform: GradientRotation(0.7),
          )),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(15),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11)),
              leading: Icon(data.icon.icon,
                  color: data.icon.color, size: data.icon.size ?? 28),
              //TITLE FOR CONTRY ON VPN LIST<><>><><<><><><><>><><<<><><><<<>
              title: Text(
                data.title,
                style: TextStyle(
                    fontFamily: 'poppin', fontWeight: FontWeight.w900),
              ),
              //SUBTITLE FOR VPN LIST
              subtitle: Text(
                data.subtitle,
                style: TextStyle(
                    fontFamily: 'poppin', fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ));
  }
}
