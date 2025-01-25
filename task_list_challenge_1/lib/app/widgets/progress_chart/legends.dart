import 'package:flutter/material.dart';
import 'package:task_list_challenge_1/app/widgets/listtile_config.dart';

class ChartLegends extends StatelessWidget {
  const ChartLegends({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (_, orientation) {
      return LayoutBuilder(builder: (_, constraints) {
        var height = constraints.maxHeight;
        var width = constraints.maxWidth;
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Legend",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTileConfig(
                icon: Icon(
                  Icons.rectangle,
                  color: Colors.green,
                ),
                text: "Completed",
              ),
              ListTileConfig(
                icon: Icon(
                  Icons.rectangle,
                  color: Colors.red,
                ),
                text: "Pending",
              ),
            ],
          ),
        );
      });
    });
  }
}
