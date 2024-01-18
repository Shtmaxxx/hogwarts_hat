import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_hat/screens/details/details_page.dart';
import 'package:hogwarts_hat/screens/main/cubit/characters_cubit.dart';
import 'package:hogwarts_hat/screens/main/tabs/home/home_page.dart';
import 'package:hogwarts_hat/services/project_assets.dart';
import 'package:hogwarts_hat/widgets/info_item.dart';
import 'package:routemaster/routemaster.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  static const String path = '/list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Screen'),
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
      body: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
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
              Expanded(
                child: ListView.builder(
                    itemCount: state.characters.length,
                    itemBuilder: (context, index) {
                      final character = state.characters[index];

                      return ListTile(
                        onTap: () => Routemaster.of(context).push(
                          DetailsPage.path,
                          queryParameters: {
                            'characterId': character.id,
                            'isGuessed': character.isGuessed ? '1' : '0',
                          },
                        ),
                        title: Text(
                          character.name,
                        ),
                        subtitle: Text('Attempts: ${character.attemptsNumber}'),
                        leading: character.image.isNotEmpty
                            ? Image.network(
                                character.image,
                              )
                            : Image.asset(ProjectAssets.unknown, width: 40),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            !character.isGuessed
                                ? IconButton(
                                    onPressed: () {
                                      context
                                          .read<CharactersCubit>()
                                          .loadSpecificCharacter(character);
                                      Routemaster.of(context)
                                          .replace(HomePage.path);
                                    },
                                    icon: const Icon(
                                      Icons.refresh,
                                      size: 35,
                                    ),
                                  )
                                : Container(),
                            character.isGuessed
                                ? const Icon(
                                    Icons.done,
                                    size: 35,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.close,
                                    size: 35,
                                    color: Colors.red,
                                  ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
