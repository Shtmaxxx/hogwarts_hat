import 'package:flutter/material.dart';
import 'package:hogwarts_hat/services/project_assets.dart';

class CharacterImage extends StatelessWidget {
  const CharacterImage({
    required this.image,
    this.name,
    super.key,
  });

  final String image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image.isNotEmpty
            ? Image.network(
                image,
                width: 150,
              )
            : Image.asset(
                ProjectAssets.unknown,
                width: 150,
              ),
        name != null
            ? Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Text(
                  name!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
