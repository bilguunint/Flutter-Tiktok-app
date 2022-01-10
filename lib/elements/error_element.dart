import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildErrorWidget(String error) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(
        height: 140.0,
        width: 140.0,
        child: SvgPicture.asset(
          "assets/icons/warning.svg",
        ),
      ),
      const SizedBox(
        height: 25.0,
      ),
      const Text(
        "Уучлаарай, системд алдаа гарлаа",
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
