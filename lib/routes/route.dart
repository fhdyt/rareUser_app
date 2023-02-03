import 'package:app_rareuser/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerate {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "Detail":
        var arg = settings.arguments as ModelRoute;
        return MaterialPageRoute(builder: (_) => DetailScreen(args: arg.id!));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(),
        );
    }
  }
}

class ModelRoute {
  final String? id;
  final String? gender;
  ModelRoute({this.id, this.gender});
}
