import 'package:flutter/material.dart';
import 'package:fooderlicht/chip.dart';
import 'fooderlicht_theme.dart';

class Card3 extends StatelessWidget {
  const Card3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mag2.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                // 1
                color: Colors.black.withOpacity(0.5),
                // 2
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.book_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                      /* const SizedBox(
                        height: 8,
                      ), */
                      Text(
                        "Recipe Trends",
                        style: FooderlichTheme.darkTextTheme.headline2,
                      ),
                      /* const SizedBox(
                        height: 8,
                      ), */
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Center(
              child: Wrap(
                runSpacing: 0,
                alignment: WrapAlignment.start,
                spacing: 10,
                children: const [
                  Chipp(label: "Healthy"),
                  Chipp(label: "Vegan"),
                  Chipp(label: "Fast Food"),
                  Chipp(label: "Chinese"),
                  Chipp(label: "American"),
                  Chipp(label: "Mexican"),
                  Chipp(label: "BBQ"),
                  Chipp(label: "Italian"),
                  Chipp(label: "Cheesy"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
