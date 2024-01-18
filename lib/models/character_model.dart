import 'package:equatable/equatable.dart';

class CharacterModel extends Equatable {
  const CharacterModel({
    required this.id,
    required this.name,
    required this.house,
    required this.image,
    required this.gender,
    required this.actor,
    required this.dateOfBirth,
    this.attemptsNumber = 0,
    this.isGuessed = false,
  });

  final String id;
  final String name;
  final String house;
  final String image;
  final String gender;
  final String actor;
  final DateTime? dateOfBirth;
  final int attemptsNumber;
  final bool isGuessed;

  @override
  List<Object> get props => [id, name, house, gender, actor];

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      house: json['house'],
      image: json['image'],
      gender: json['gender'],
      actor: json['actor'],
      dateOfBirth: DateTime.tryParse(json['dateOfBirth'] ?? ''),
    );
  }

  CharacterModel copyWith({
    String? id,
    String? name,
    String? house,
    String? image,
    String? gender,
    String? actor,
    DateTime? dateOfBirth,
    int? attemptsNumber,
    bool? isGuessed,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      house: house ?? this.house,
      image: image ?? this.image,
      gender: gender ?? this.gender,
      actor: actor ?? this.actor,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      attemptsNumber: attemptsNumber ?? this.attemptsNumber,
      isGuessed: isGuessed ?? this.isGuessed,
    );
  }
}
