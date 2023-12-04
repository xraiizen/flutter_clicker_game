library cosntants.globals;

import 'package:flutter_clicker_game/models/recipe.dart';
import 'package:flutter_clicker_game/models/resource.dart';

// Ce fichier contient des listes de ressources et de recettes globales utilisées dans le jeu.
// Ces listes sont accessibles depuis différentes parties de l'application pour définir
// les éléments de jeu tels que les ressources et les recettes disponibles.
// Ces données décrivent les éléments du jeu.

List<Resource> resources = [
  Resource(
    type: ResourceType.Bois,
    name: 'Bois',
    isPrimary: true,
  ),
  Resource(
    type: ResourceType.Fer,
    name: 'Fer',
    isPrimary: true,
  ),
  Resource(
    type: ResourceType.Cuivre,
    name: 'Cuivre',
    isPrimary: true,
  ),
  Resource(
    type: ResourceType.Charbon,
    name: 'Charbon',
  ),
  Resource(
    type: ResourceType.Hache,
    name: 'Hache',
  ),
  Resource(
    type: ResourceType.Pioche,
    name: 'Pioche',
  ),
  Resource(
    type: ResourceType.LingotDeFer,
    name: 'Lingot de fer',
  ),
  Resource(
    type: ResourceType.PlaqueDeFer,
    name: 'Plaque de fer',
  ),
  Resource(
    type: ResourceType.LingotDeCuivre,
    name: 'Lingot de cuivre',
  ),
  Resource(
    type: ResourceType.TigeEnMetal,
    name: 'Tige en métal',
  ),
  Resource(
    type: ResourceType.FilElectrique,
    name: 'Fil électrique',
  ),
  Resource(
    type: ResourceType.Mineur,
    name: 'Mineur',
  ),
  Resource(
    type: ResourceType.Fonderie,
    name: 'Fonderie',
  ),
];

List<Recipe> recipes = [
  Recipe(
    name: 'Hache',
    resourceType: ResourceType.Hache,
    cost: {
      ResourceType.Bois: 2,
      ResourceType.TigeEnMetal: 2,
    },
    gameplay: "Récolter le bois  3 par 3 (3 par click)",
    type: RecipeType.Tool,
    description: "Un outil utile",
  ),
  Recipe(
    name: 'Pioche',
    resourceType: ResourceType.Pioche,
    cost: {
      ResourceType.Bois: 2,
      ResourceType.TigeEnMetal: 3,
    },
    gameplay: "Récolter les minerais 5 par 5 (5 par click)",
    type: RecipeType.Tool,
    description: "Un outil utile",
  ),
  Recipe(
    name: 'Lingot de fer',
    resourceType: ResourceType.LingotDeFer,
    cost: {
      ResourceType.Fer: 1,
    },
    gameplay: "Débloque d'autres recettes",
    type: RecipeType.Material,
    description: "Un lingot de fer pur",
  ),
  Recipe(
    name: 'Plaque de fer',
    resourceType: ResourceType.PlaqueDeFer,
    cost: {
      ResourceType.Fer: 3,
      ResourceType.TigeEnMetal: 2,
    },
    gameplay: "Débloque d'autres recettes",
    type: RecipeType.Material,
    description: "Une plaque de fer pour la construction",
  ),
  Recipe(
    name: 'Lingot de cuivre',
    resourceType: ResourceType.LingotDeCuivre,
    cost: {
      ResourceType.Cuivre: 1,
    },
    gameplay: "Débloque d'autres recettes",
    type: RecipeType.Material,
    description: "Un lingot de cuivre pur",
  ),
  Recipe(
    name: 'Tige en métal',
    resourceType: ResourceType.TigeEnMetal,
    cost: {
      ResourceType.LingotDeFer: 1,
    },
    gameplay: "Débloque d'autres recettes",
    type: RecipeType.Material,
    description: "Une tige de métal",
  ),
  Recipe(
    name: 'Fil électrique',
    resourceType: ResourceType.FilElectrique,
    cost: {
      ResourceType.LingotDeCuivre: 1,
    },
    gameplay: "Débloque d'autres recettes",
    type: RecipeType.Component,
    description:
        "Un fil électrique pour fabriquer des composants électroniques",
  ),
  Recipe(
    name: 'Mineur',
    resourceType: ResourceType.Mineur,
    cost: {
      ResourceType.PlaqueDeFer: 10,
      ResourceType.FilElectrique: 5,
    },
    gameplay: "Permet d’extraire automatiquement du minerai de fer ou cuivre",
    type: RecipeType.Building,
    description: "Un bâtiment qui permet d’automatiser le minage",
  ),
  Recipe(
    name: 'Fonderie',
    resourceType: ResourceType.Fonderie,
    cost: {
      ResourceType.TigeEnMetal: 8,
      ResourceType.FilElectrique: 5,
    },
    gameplay:
        "Permet de transformer automatiquement du minerai de fer ou cuivre en lingot de fer ou cuivre",
    type: RecipeType.Building,
    description: "Un bâtiment qui permet d’automatiser la production",
  ),
];
