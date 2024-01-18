import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_hat/core/errors/failure.dart';
import 'package:hogwarts_hat/models/character_model.dart';
import 'package:hogwarts_hat/repositories/character_repository.dart';
import 'package:injectable/injectable.dart';

part 'characters_state.dart';

@injectable
class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.characterRepository) : super(const CharacterLoading());

  final CharacterRepositoryI characterRepository;

  Future<void> loadCharacter() async {
    emit(
      CharacterLoading(
        characters: state.characters,
        total: state.total,
        success: state.success,
        failed: state.failed,
      ),
    );

    final Either<Failure, CharacterModel> result =
        await characterRepository.getRandomCharacter();
    result.fold(
      (failture) {
        emit(
          CharacterError(
            failure: failture,
            characters: state.characters,
            total: state.total,
            success: state.success,
            failed: state.failed,
          ),
        );
      },
      (character) {
        emit(
          CharacterLoaded(
            currentCharacter: character,
            characters: state.characters,
            total: state.total,
            success: state.success,
            failed: state.failed,
          ),
        );
      },
    );
  }

  void guessHouse(String house) {
    if (state is CharacterLoaded) {
      final loadedState = state as CharacterLoaded;
      late final List<CharacterModel> characters;
      final stateCharacter = state.characters
          .firstWhereOrNull((c) => c.id == loadedState.currentCharacter.id);
      if (house == loadedState.currentCharacter.house) {
        if (stateCharacter != null) {
          if (stateCharacter.isGuessed) {
            characters = state.characters;
          } else {
            final index = state.characters.indexOf(stateCharacter);
            characters = List.from(state.characters);
            characters[index] = stateCharacter.copyWith(
              attemptsNumber: stateCharacter.attemptsNumber + 1,
              isGuessed: true,
            );
          }
        } else {
          characters = List.from(state.characters)
            ..add(loadedState.currentCharacter
                .copyWith(attemptsNumber: 1, isGuessed: true));
        }
        emit(
          state.copyWith(
            characters: characters,
            total: state.total + 1,
            success: state.success + 1,
          ),
        );
      } else {
        if (stateCharacter != null) {
          if (stateCharacter.isGuessed) {
            characters = state.characters;
          } else {
            final index = state.characters.indexOf(stateCharacter);
            characters = List.from(state.characters);
            characters[index] = stateCharacter.copyWith(
              attemptsNumber: stateCharacter.attemptsNumber + 1,
              isGuessed: false,
            );
          }
        } else {
          characters = List.from(state.characters)
            ..add(loadedState.currentCharacter
                .copyWith(attemptsNumber: 1, isGuessed: false));
        }
        emit(
          state.copyWith(
            characters: characters,
            total: state.total + 1,
            failed: state.failed + 1,
          ),
        );
      }
    }

    loadCharacter();
  }

  void loadSpecificCharacter(CharacterModel character) {
    emit(
      CharacterLoaded(
        currentCharacter: character,
        characters: state.characters,
        total: state.total,
        success: state.success,
        failed: state.failed,
      ),
    );
  }

  void reset() {
    emit(state.copyWith(
      characters: [],
      total: 0,
      success: 0,
      failed: 0,
    ));
    loadCharacter();
  }
}
