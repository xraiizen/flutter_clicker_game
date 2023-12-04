import 'package:flutter_clicker_game/models/resource.dart';

// ignore_for_file: constant_identifier_names,non_constant_identifier_names

// Énumération des types de recettes disponibles dans le jeu.
enum RecipeType { Ore, Tool, Material, Component, Building }

// La classe [Recipe] représente une recette avec des attributs tels que son nom, son type, son coût en ressources,
// sa description, une indication de déverrouillage et une explication du gameplay.
class Recipe {
  final ResourceType resourceType;
  final String name;
  Map<ResourceType, int> cost;
  String gameplay;
  RecipeType type;
  String description;
  bool isUnlocked = false;

  // Constructeur de la classe Recipe qui initialise les attributs nécessaires.
  Recipe({
    required this.name,
    required this.resourceType,
    required this.cost,
    required this.gameplay,
    required this.type,
    required this.description,
  });
}
