import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_hat/screens/details/cubit/details_cubit.dart';
import 'package:hogwarts_hat/screens/main/tabs/home/widgets/character_image.dart';
import 'package:hogwarts_hat/services/injectable/injectable_init.dart';
import 'package:hogwarts_hat/widgets/circular_loading.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.characterId,
    required this.isGuessed,
    super.key,
  });

  static const String path = '/details';

  final String characterId;
  final bool isGuessed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DetailsCubit>()..loadCharacterById(characterId),
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: state is DetailsLoaded
                  ? Text(state.character.name)
                  : Container(),
              shape: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Row(
                children: [
                  if (state is DetailsLoading) ...{
                    const Expanded(
                      child: Center(
                        child: CircularLoading(),
                      ),
                    ),
                  } else if (state is DetailsLoaded) ...{
                    Expanded(
                      flex: 2,
                      child: CharacterImage(
                        image: state.character.image,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 7),
                          if (isGuessed) ...{
                          Flexible(
                            child: Text(
                              'House: ${state.character.house.isNotEmpty ? state.character.house : 'not in house'}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Date of birth: ${state.character.dateOfBirth ?? 'unknown'}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Gender: ${state.character.gender.isNotEmpty ? state.character.gender : 'unknown'}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Actor: ${state.character.actor.isNotEmpty ? state.character.actor : 'unknown'}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),} else ...{
                            const Flexible(
                            child: Text(
                              'Access Denied!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          }
                        ],
                      ),
                    )
                  } else if (state is DetailsError) ...{
                    const Expanded(
                      child: Center(
                        child: Text('Error loading details'),
                      ),
                    ),
                  }
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
