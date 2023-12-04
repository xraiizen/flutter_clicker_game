import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_clicker_game/models/recipe.dart';
import 'package:flutter_clicker_game/providers/recipe_provider.dart';
import 'package:flutter_clicker_game/providers/resource_provider.dart';
import 'package:provider/provider.dart';

/// La classe [InventoryProvider] est responsable de la gestion de l'inventaire
/// des recettes disponibles. Elle étend [ChangeNotifier] pour informer les widgets
/// écoutant de tout changement dans l'inventaire.
class InventoryProvider extends ChangeNotifier {
  // La liste privée [_inventory] contient les recettes disponibles dans l'inventaire.
  final List<Recipe> _inventory = [];

  InventoryProvider(context) {
    init(context);
  }

  // Un getter pour accéder à la liste des recettes de l'inventaire depuis l'extérieur de la classe.
  List<Recipe> get inventory => _inventory;

  /// La fonction [init] initialise l'inventaire en parcourant les ressources et les recettes disponibles.
  /// Elle ajoute les recettes à l'inventaire si les conditions sont remplies.
  ///
  /// Paramètres :
  ///   - [context]: Le contexte de construction actuel.
  init(context) {
    var recipes = Provider.of<RecipeProvider>(context, listen: false).recipes;
    var resources =
        Provider.of<ResourceProvider>(context, listen: false).resources;
    for (var resource in resources) {
      for (var recipe in recipes) {
        if (resource.type == recipe.resourceType && resource.quantity > 0) {
          print("${recipe.name} - ${resource.quantity}");
          _inventory.add(recipe);
        }
      }
    }
    notifyListeners();
  }

  /// La fonction [addRecipe] permet d'ajouter une recette à l'inventaire.
  ///
  /// Paramètres :
  ///   - [recipe]: L'objet [Recipe] à ajouter à l'inventaire.
  addRecipe(Recipe recipe) {
    inventory.add(recipe);
    notifyListeners();
  }
}
