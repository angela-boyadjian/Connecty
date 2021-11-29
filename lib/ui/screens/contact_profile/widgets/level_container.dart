import 'package:connecty/ui/widgets/glassmorphism.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class LevelContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: GlassMorphism(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Relationship lvl 4',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SleekCircularSlider(
              appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(progressBarWidth: 10),
                animDurationMultiplier: 2.0,
              ),
              min: 10,
              max: 100,
              initialValue: 68,
            ),
            Text(
              '800/1000 XP',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}
