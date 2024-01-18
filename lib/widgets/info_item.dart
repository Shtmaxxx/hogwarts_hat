import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    required this.number,
    required this.info,
    super.key,
  });

  final String number;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            info,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
