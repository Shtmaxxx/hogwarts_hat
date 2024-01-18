import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_hat/screens/main/cubit/characters_cubit.dart';
import 'package:hogwarts_hat/screens/main/tabs/home/helpers/house_names.dart';
import 'package:hogwarts_hat/screens/main/tabs/home/widgets/character_image.dart';
import 'package:hogwarts_hat/services/project_assets.dart';
import 'package:hogwarts_hat/widgets/circular_loading.dart';
import 'package:hogwarts_hat/widgets/info_item.dart';
import 'package:hogwarts_hat/widgets/primary_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String path = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: context.read<CharactersCubit>().reset,
            child: const Text('Reset'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: context.read<CharactersCubit>().loadCharacter,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: BlocBuilder<CharactersCubit, CharactersState>(
            builder: (context, state) {
              final charactersCubit = context.read<CharactersCubit>();

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 25,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InfoItem(
                            number: state.total.toString(),
                            info: 'Total',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: InfoItem(
                            number: state.success.toString(),
                            info: 'Success',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: InfoItem(
                            number: state.failed.toString(),
                            info: 'Failed',
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state is CharacterLoading) ...{
                    const Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 70),
                      child: CircularLoading(),
                    ),
                  } else if (state is CharacterLoaded) ...{
                    CharacterImage(
                      image: state.currentCharacter.image,
                      name: state.currentCharacter.name,
                    ),
                  } else if (state is CharacterError) ...{
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: Text('Error loading character'),
                    ),
                  },
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                onPressed: () => charactersCubit
                                    .guessHouse(HouseNames.gryffindor),
                                title: HouseNames.gryffindor,
                                icon: ProjectAssets.gryffindor,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: PrimaryButton(
                                onPressed: () => charactersCubit
                                    .guessHouse(HouseNames.slytherin),
                                title: HouseNames.slytherin,
                                icon: ProjectAssets.slytherin,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                onPressed: () => charactersCubit
                                    .guessHouse(HouseNames.ravenclaw),
                                title: HouseNames.ravenclaw,
                                icon: ProjectAssets.ravenclaw,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: PrimaryButton(
                                onPressed: () => charactersCubit
                                    .guessHouse(HouseNames.hufflepuff),
                                title: HouseNames.hufflepuff,
                                icon: ProjectAssets.hufflepuff,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                onPressed: () => charactersCubit
                                    .guessHouse(HouseNames.notInHouse),
                                title: 'Not in House',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
