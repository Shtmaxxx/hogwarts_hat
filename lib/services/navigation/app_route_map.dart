import 'package:flutter/material.dart';
import 'package:hogwarts_hat/screens/details/details_page.dart';
import 'package:routemaster/routemaster.dart';
import 'package:hogwarts_hat/screens/main/main_page.dart';
import 'package:hogwarts_hat/screens/main/tabs/home/home_page.dart';
import 'package:hogwarts_hat/screens/main/tabs/list/list_page.dart';

class AppRouteMap extends RouteMap {
  AppRouteMap()
      : super(
          onUnknownRoute: _onUnknownRoute,
          routes: _routes(),
        );

  static RouteSettings _onUnknownRoute(String route) => const Redirect('/');

  static Map<String, PageBuilder> _routes() {
    return {
      MainPage.path: (_) => const TabPage(
            child: MainPage(),
            paths: [HomePage.path, ListPage.path],
          ),
      HomePage.path: (_) => _createMaterialPage(
            const HomePage(),
          ),
      ListPage.path: (routeData) => _createMaterialPage(
            const ListPage(),
          ),
      DetailsPage.path: (routeData) => _createMaterialPage(DetailsPage(
            characterId: routeData.queryParameters['characterId']!,
            isGuessed:
                routeData.queryParameters['isGuessed'] == '1' ? true : false,
          )),
    };
  }

  static MaterialPage<dynamic> _createMaterialPage(Widget page) {
    return MaterialPage(
      child: page,
      name: page.toString(),
    );
  }
}
