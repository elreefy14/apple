import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
            Text(
              textAlign: TextAlign.center,
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              textAlign: TextAlign.center,
              subtitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],),
        )
      ],
    );
  }
}
