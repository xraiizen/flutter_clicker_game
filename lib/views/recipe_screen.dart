import 'package:flutter/material.dart';
import 'package:flutter_clicker_game/models/recipe.dart';
import 'package:flutter_clicker_game/providers/recipe_provider.dart';
import 'package:flutter_clicker_game/constants/globals.dart' as global;
import 'package:flutter_clicker_game/providers/resource_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// La classe [RecipeScreen] représente l'écran de création des recettes en jeu.
class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  RecipeScreenState createState() => RecipeScreenState();
}

class RecipeScreenState extends State<RecipeScreen> {
  /// Cette fonction prend en paramètre un objet [Recipe] et retourne un [Map] qui associe les noms des ressources nécessaires pour cette recette à leurs valeurs correspondantes.
  /// Les ressources nécessaires sont extraites de la propriété 'cost' de l'objet [Recipe], et le [Map] résultant associe les noms des ressources (extraites de l'objet 'resource') aux quantités nécessaires pour la recette.
  ///
  /// Paramètres :
  ///   - [recipe]: L'objet [Recipe] pour lequel les ressources sont extraites.
  ///
  /// Retour :
  ///   Un [Map] de type [String, int] où les clés sont les noms des ressources et les valeurs sont les quantités nécessaires pour la recette.
  ///
  /// Exemple d'utilisation :
  /// ```dart
  /// Recipe myRecipe = Recipe(
  ///   name: 'Ma recette',
  ///   cost: {'RessourceA': 2, 'RessourceB': 5},
  /// );
  ///
  Map<String, int> getResourceName(Recipe recipe) {
    Map<String, int> resourcesRecipeNameValue = {};
    for (var resource in global.resources) {
      recipe.cost.forEach((key, value) {
        if (key == resource.type) {
          resourcesRecipeNameValue[resource.name] = value;
        }
      });
    }
    return resourcesRecipeNameValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recette'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
              icon: const Icon(Icons.receipt_long),
              onPressed: () {
                GoRouter.of(context).pushNamed('inventory');
              },
            ),
          ),
        ],
      ),
      body: Consumer<RecipeProvider>(
        builder: (BuildContext context, RecipeProvider recipeProvider,
            Widget? child) {
          var resourceProvider = Provider.of<ResourceProvider>(context);
          return ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: recipeProvider.recipes.length,
            itemBuilder: (BuildContext context, int index) {
              Recipe recipe = recipeProvider.recipes[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  tileColor: Colors.grey[850],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey[700]!),
                  ),
                  enabled: recipeProvider.canCreateRecipe(
                      recipe, resourceProvider, context),
                  title: Text(
                    recipe.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    recipe.description,
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: getResourceName(recipe).entries.map((entry) {
                      return Text(
                        "${entry.key}: ${entry.value}",
                      );
                    }).toList(),
                  ),
                  onTap: recipeProvider.canCreateRecipe(
                          recipe, resourceProvider, context)
                      ? () {
                          recipeProvider.create(
                              recipe, resourceProvider, context);
                        }
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
