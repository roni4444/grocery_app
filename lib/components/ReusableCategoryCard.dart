import 'package:flutter/material.dart';

class ReusableCategoryCard extends StatelessWidget {
  ReusableCategoryCard({@required this.imagePath, @required this.cardText});
  final String imagePath;
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Card(
        margin: EdgeInsets.fromLTRB(0, 110, 50, 10),
        color: Colors.white,
        child: Text(
          cardText,
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 22.0),
        ),
      ),
    );
  }
}
