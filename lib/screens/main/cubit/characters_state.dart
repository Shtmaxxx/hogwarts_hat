part of 'characters_cubit.dart';

class CharactersState extends Equatable {
  const CharactersState({
    this.characters = const [],
    this.total = 0,
    this.success = 0,
    this.failed = 0,
  });

  final List<CharacterModel> characters;
  final int total;
  final int success;
  final int failed;

  @override
  List<Object> get props => [characters, total, success, failed];

  CharactersState copyWith({
    List<CharacterModel>? characters,
    int? total,
    int? success,
    int? failed,
  }) {
    return CharactersState(
      characters: characters ?? this.characters,
      total: total ?? this.total,
      success: success ?? this.success,
      failed: failed ?? this.failed,
    );
  }
}

class CharacterLoading extends CharactersState {
  const CharacterLoading({
    super.characters,
    super.total,
    super.success,
    super.failed,
  });
}

class CharacterLoaded extends CharactersState {
  const CharacterLoaded({
    required this.currentCharacter,
    super.characters,
    super.total,
    super.success,
    super.failed,
  });

  final CharacterModel currentCharacter;

  @override
  List<Object> get props => [characters, currentCharacter];
}

class CharacterError extends CharactersState {
  const CharacterError({
    required this.failure,
    super.characters,
    super.total,
    super.success,
    super.failed,
  });

  final Failure failure;
}
