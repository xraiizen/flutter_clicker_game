import 'package:flutter/material.dart';
import 'package:flutter_clicker_game/providers/recipe_provider.dart';
import 'package:flutter_clicker_game/providers/resource_provider.dart';
import 'package:flutter_clicker_game/views/home_screen.dart';
import 'package:flutter_clicker_game/views/inventory_screen.dart';
import 'package:flutter_clicker_game/views/recipe_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
        ChangeNotifierProvider(create: (context) => ResourceProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: 'recipe',
          path: 'recipe',
          builder: (context, state) => const RecipeScreen(),
        ),
        GoRoute(
          name: 'inventory',
          path: 'inventory',
          builder: (context, state) => const InventoryScreen(),
        ),
      ],
    ),
  ],
);
