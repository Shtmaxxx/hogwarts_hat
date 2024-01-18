import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_hat/screens/main/cubit/characters_cubit.dart';
import 'package:hogwarts_hat/services/injectable/injectable_init.dart';
import 'package:routemaster/routemaster.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const String path = '/';

  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: TabBar(
          controller: tabPage.controller,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(
              text: "Home",
              height: 65,
              icon: Icon(Icons.home),
            ),
            Tab(
              text: "List",
              height: 65,
              icon: Icon(Icons.list),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<CharactersCubit>()..loadCharacter(),
        child: TabBarView(
          controller: tabPage.controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (final stack in tabPage.stacks)
              PageStackNavigator(stack: stack),
          ],
        ),
      ),
    );
  }
}
