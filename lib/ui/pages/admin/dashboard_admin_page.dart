import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';

class DasboardAdminPage extends StatelessWidget {
  const DasboardAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: BrandColor.secondaryColor,
          title: H4(
            text: "Dasboard",
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Activity',
                style: TextStyle(
                  color: BrandColor.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              LegendsListWidget(
                legends: [
                  Legend('Pilates', Colors.red),
                  Legend('Quick workouts', Colors.blue),
                  Legend('Cycling', Colors.pink),
                ],
              ),
              const SizedBox(height: 14),
              AspectRatio(
                aspectRatio: 2,
                // child:BarChart(

                // ),
              ),
            ],
          ),
        ));
  }
}

class LegendWidget extends StatelessWidget {
  const LegendWidget({
    super.key,
    required this.name,
    required this.color,
  });
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          name,
          style: const TextStyle(
            color: Color(0xff757391),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class LegendsListWidget extends StatelessWidget {
  const LegendsListWidget({
    super.key,
    required this.legends,
  });
  final List<Legend> legends;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: legends
          .map(
            (e) => LegendWidget(
              name: e.name,
              color: e.color,
            ),
          )
          .toList(),
    );
  }
}

class Legend {
  Legend(this.name, this.color);
  final String name;
  final Color color;
}
