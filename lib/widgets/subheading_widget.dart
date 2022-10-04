import 'package:flutter/material.dart';

class SubHeadingRow extends StatelessWidget {
  const SubHeadingRow({
    Key? key,
    required this.icon,
    required this.lable,
  }) : super(key: key);

  final IconData icon;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.green,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          lable,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
