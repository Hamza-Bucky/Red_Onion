import 'package:flutter/material.dart';
import 'package:tunnel/main.dart';

class HomeCard extends StatelessWidget {
  final String title, subtitle;
  final Widget icon;
  const HomeCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaq.width * 0.47,
      child: Column(
        children: [
          icon,
          SizedBox(
            height: mediaq.height * 0.02,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              fontFamily: 'poppin',
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 13,
                fontFamily: 'poppin',
                fontWeight: FontWeight.w900,
                color: Theme.of(context).LightText),
          )
        ],
      ),
    );
  }
}
