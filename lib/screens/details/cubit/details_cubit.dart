import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_hat/core/errors/failure.dart';
import 'package:hogwarts_hat/models/character_model.dart';
import 'package:hogwarts_hat/repositories/character_repository.dart';
import 'package:injectable/injectable.dart';

part 'details_state.dart';

@injectable
class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.characterRepository) : super(DetailsLoading());

  final CharacterRepositoryI characterRepository;

  Future<void> loadCharacterById(String id) async {
    emit(DetailsLoading());

    final Either<Failure, CharacterModel> result =
        await characterRepository.getCharacter(id);
    result.fold(
      (failture) {
        emit(
          DetailsError(
            failure: failture,
          ),
        );
      },
      (character) {
        emit(
          DetailsLoaded(
            character: character,
          ),
        );
      },
    );
  }
}
