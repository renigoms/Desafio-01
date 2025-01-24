import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/controller/task_controller.dart';
import 'package:task_list_challenge_1/app/widgets/listtile_config.dart';

class FilterButtonConfig extends StatefulWidget {
  const FilterButtonConfig({super.key});

  @override
  State<FilterButtonConfig> createState() => _FilterButtonConfigState();
}

class _FilterButtonConfigState extends State<FilterButtonConfig> {
  final List<Map<String, dynamic>> _detailsConfig = [
    {
      "title": "Completed",
      "value": "Completed",
      "color": Colors.green,
      "icon": Icons.check,
    },
    {
      "title": "Pending",
      "value": "Pending",
      "color": Colors.yellow,
      "icon": Icons.warning_amber,
    },
    {
      "title": "Without Filter",
      "value": "WithoutFilter",
      "color": Colors.redAccent,
      "icon": Icons.filter_alt_off_outlined,
    },
  ];
  List<PopupMenuEntry> popupMenuEntryList = [];

  @override
  void initState() {
    super.initState();
    popupMenuEntryList = List.generate(
      3,
      (index) => PopupMenuItem(
        value: _detailsConfig[index]["value"],
        child: ListTileConfig(
          icon: Icon(_detailsConfig[index]["icon"],
              color: _detailsConfig[index]["color"]),
          text: _detailsConfig[index]["title"],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(builder: (_, taskController, widget) {
      return PopupMenuButton(
        onSelected: (value) {
          try {
            taskController.taskFilter(value, context);
            if (taskController.messageSnackBar != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(taskController.messageSnackBar!),
                ),
              );
            }
          } catch (e) {
            print(e.toString());
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Internal error !")));
          }
        },
        elevation: 20,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        shadowColor: Colors.grey,
        icon: const Icon(Icons.filter_alt_outlined),
        iconColor: Colors.white,
        iconSize: 30,
        itemBuilder: (BuildContext bc) => popupMenuEntryList,
      );
    });
  }
}
