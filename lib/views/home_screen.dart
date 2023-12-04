import 'package:flutter/material.dart';
import 'package:flutter_clicker_game/models/resource.dart';
import 'package:flutter_clicker_game/providers/resource_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// La classe [HomeScreen] représente l'écran de minage des resources du jeu.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  /// Cette fonction prend en paramètre un objet [Resource] et retourne la couleur associée au type de ressource spécifié.
  /// La couleur est déterminée en fonction du type de ressource et est renvoyée sous forme d'objet [Color].
  ///
  /// Paramètres :
  ///   - [resource]: L'objet [Resource] pour lequel la couleur primaire est recherchée.
  ///
  /// Retour :
  ///   Un objet [Color] représentant la couleur associée au type de ressource. Si le type de ressource n'est pas reconnu, la couleur par défaut est renvoyée (rouge).
  ///
  /// Exemple d'utilisation :
  /// ```dart
  /// Resource myResource = Resource(
  ///   name: 'RessourceA',
  ///   type: ResourceType.Fer,
  ///   // ...
  /// );
  ///
  ////// Color primaryColor = getColorPrimaryResource(myResource);
  /// ```
  Color getColorPrimaryResource(Resource resource) {
    switch (resource.type) {
      case ResourceType.Bois:
        return const Color(0xff967969);
      case ResourceType.Fer:
        return const Color.fromARGB(255, 127, 138, 148);
      case ResourceType.Cuivre:
        return const Color(0xffd9480f);
      case ResourceType.Charbon:
        return const Color(0xff000000);
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ressources'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
              icon: const Icon(Icons.cookie),
              onPressed: () {
                GoRouter.of(context).pushNamed('recipe');
              },
            ),
          ),
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
      body: Consumer<ResourceProvider>(
        builder: (BuildContext context, ResourceProvider resourceProvider,
            Widget? child) {
          var primaryResources = resourceProvider.getPrimaryResources();

          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: primaryResources.length,
              itemBuilder: (context, index) {
                var resource = primaryResources[index];
                return GestureDetector(
                  onTap: () {
                    resourceProvider.incrementResource(resource.type);
                  },
                  child: Container(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: getColorPrimaryResource(resource),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            resource.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Text(
                            resource.quantity.toString(),
                            style: const TextStyle(fontSize: 34),
                          ),
                        ],
                      )),
                );
              });
        },
      ),
    );
  }
}
