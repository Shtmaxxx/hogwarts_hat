part of 'details_cubit.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  const DetailsLoaded({required this.character});

  final CharacterModel character;
}

class DetailsError extends DetailsState {
  const DetailsError({
    required this.failure,
  });

  final Failure failure;
}
