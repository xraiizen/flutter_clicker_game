import 'package:flutter/material.dart';
import 'package:flutter_clicker_game/models/recipe.dart';
import 'package:flutter_clicker_game/models/resource.dart';
import 'package:flutter_clicker_game/providers/recipe_provider.dart';
import 'package:flutter_clicker_game/providers/resource_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// La classe [InventoryScreen] représente l'écran de l'inventaire du jeu.
class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  InventoryScreenState createState() => InventoryScreenState();
}

class InventoryScreenState extends State<InventoryScreen> {
  List<Recipe> listrecipe = [];
  @override
  void initState() {
    super.initState();
    // Initialiser la liste des recettes
    var recipes = Provider.of<RecipeProvider>(context, listen: false).recipes;

    listrecipe = recipes.where((element) => element.isUnlocked).toList();
  }

  void sortByName() {
    setState(() {
      listrecipe.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void sortByQuantity() {
    var resourceProvider =
        Provider.of<ResourceProvider>(context, listen: false);

    setState(() {
      listrecipe.sort((a, b) {
        var resourceA = resourceProvider.resources
            .firstWhere((res) => res.type == a.resourceType);
        var resourceB = resourceProvider.resources
            .firstWhere((res) => res.type == b.resourceType);
        return resourceA.quantity.compareTo(resourceB.quantity);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var resources =
        Provider.of<ResourceProvider>(context, listen: false).resources;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Inventaire'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                  icon: const Icon(Icons.sort_by_alpha), onPressed: sortByName),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                  icon: const Icon(Icons.sort_outlined),
                  onPressed: sortByQuantity),
            ),
            const VerticalDivider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
              child: IconButton(
                icon: const Icon(Icons.home_filled),
                onPressed: () {
                  GoRouter.of(context).goNamed('home');
                },
              ),
            ),
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: listrecipe.length,
          itemBuilder: (BuildContext context, int index) {
            var recipeCreate = listrecipe[index];
            Resource? resourceLikeRecipeCreate;
            for (var resource in resources) {
              if (resource.type == recipeCreate.resourceType) {
                resourceLikeRecipeCreate = resource;
              }
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: ListTile(
                tileColor: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey[700]!),
                ),
                title: Text(
                  recipeCreate.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  recipeCreate.description,
                  style: TextStyle(color: Colors.grey[400]),
                ),
                trailing: Text(resourceLikeRecipeCreate!.quantity.toString()),
              ),
            );
          },
        ));
  }
}
