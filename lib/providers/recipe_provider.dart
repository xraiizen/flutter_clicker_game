import 'package:flutter/material.dart' show BuildContext, ChangeNotifier;
import 'package:flutter_clicker_game/constants/globals.dart' as global;
import 'package:flutter_clicker_game/models/recipe.dart';
import 'package:flutter_clicker_game/models/resource.dart';
import 'package:flutter_clicker_game/providers/resource_provider.dart';

/// La classe [RecipeProvider] est responsable de la gestion des recettes de jeu.
/// Elle étend [ChangeNotifier] pour informer les widgets écoutant de tout changement de recette.
class RecipeProvider extends ChangeNotifier {
  // La liste privée [_recipes] contient les recettes du jeu.
  final List<Recipe> _recipes = global.recipes;

  RecipeProvider();

  // Un getter pour accéder à la liste des recettes depuis l'extérieur de la classe.
  List<Recipe> get recipes => _recipes;

  /// La fonction [create] permet de créer une recette en utilisant des ressources.
  /// Elle vérifie si toutes les ressources nécessaires sont disponibles, puis débloque la recette
  /// et effectue les actions associées, comme la modification des bonus de collecte.
  ///
  /// Paramètres :
  ///   - [recipe]: L'objet [Recipe] à créer.
  ///   - [resourceProvider]: Le [ResourceProvider] utilisé pour gérer les ressources.
  ///   - [context]: Le contexte de construction actuel.
  create(
      Recipe recipe, ResourceProvider resourceProvider, BuildContext context) {
    var resources = resourceProvider.resources;
    for (var resource in resources) {
      recipe.cost.forEach((key, value) {
        if (resource.type == key) {
          resource.decrement(value);
          resourceProvider.notifyListeners();
        }
      });
      if (resource.type == recipe.resourceType) {
        resourceProvider.incrementResource(recipe.resourceType);
        recipe.isUnlocked = true;
        switch (resource.type) {
          case ResourceType.Hache:
            resources
                .firstWhere((r) => r.type == ResourceType.Bois)
                .collectionBonus = 2;
            break;
          case ResourceType.Pioche:
            resources
                .firstWhere((r) => r.type == ResourceType.Fer)
                .collectionBonus = 4;
            resources
                .firstWhere((r) => r.type == ResourceType.Cuivre)
                .collectionBonus = 4;
            resources
                .firstWhere((r) => r.type == ResourceType.Charbon)
                .collectionBonus = 4;
            break;
          default:
        }
        resourceProvider.notifyListeners();
      }
    }
    notifyListeners();
  }

  /// La fonction [canCreateRecipe] vérifie si une recette peut être créée en vérifiant
  /// si toutes les ressources nécessaires sont disponibles.
  ///
  /// Paramètres :
  ///   - [recipe]: L'objet [Recipe] à vérifier.
  ///   - [resourceProvider]: Le [ResourceProvider] utilisé pour gérer les ressources.
  ///   - [context]: Le contexte de construction actuel.
  ///
  /// Retour :
  ///   [true] si toutes les ressources nécessaires sont disponibles, [false] sinon.
  canCreateRecipe(
      Recipe recipe, ResourceProvider resourceProvider, BuildContext context) {
    var resources = resourceProvider.resources;
    for (var resourceHave in resources) {
      for (var requiredResource in recipe.cost.entries) {
        if (resourceHave.type == requiredResource.key) {
          if (resourceHave.quantity < requiredResource.value) {
            return false;
          }
        }
      }
    }
    return true;
  }
}
