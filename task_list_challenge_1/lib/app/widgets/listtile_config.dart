import 'package:flutter/material.dart';

class ListTileConfig extends StatelessWidget {
  final Icon _icon;
  final String _text;
  const ListTileConfig({super.key, required Icon icon, required String text})
      : _icon = icon,
        _text = text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _icon,
      title:  Text(
        _text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
