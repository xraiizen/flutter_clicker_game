import 'dart:async';

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_clicker_game/models/resource.dart';
import 'package:flutter_clicker_game/constants/globals.dart' as global;

/// Le [ResourceProvider] est une classe qui gère la gestion des ressources de jeu.
/// Elle étend [ChangeNotifier], ce qui permet d'informer les widgets écoutant
/// lorsqu'une ressource est modifiée, afin de mettre à jour l'interface utilisateur.
class ResourceProvider extends ChangeNotifier {
  final List<Resource> _resources = global.resources;

  ResourceProvider();

  // Un getter pour accéder à la liste des ressources depuis l'extérieur de la classe.
  List<Resource> get resources => _resources;

  // La fonction [incrementResource] permet d'augmenter la quantité d'une ressource donnée.
  incrementResource(ResourceType type) {
    var resource = _resources.firstWhere((resource) => resource.type == type);
    _gamelogicIncrementResource(type);
    resource.increment();
    notifyListeners();
  }

  //La fonction [_gamelogicIncrementResource] gère également des logiques spécifiques pour certaines ressources.
  _gamelogicIncrementResource(ResourceType type) {
    // Effectue des actions spécifiques en fonction du type de ressource.
    switch (type) {
      case ResourceType.LingotDeFer:
      case ResourceType.LingotDeCuivre:
        checkForUnlockingCharcoal();
        break;
      case ResourceType.Mineur:
        int currentMinerCount = _getResourceCount(ResourceType.Mineur);
        if (currentMinerCount >= 2) {
          startBuilding(_autoCollectMinerals);
        }
        break;
      case ResourceType.Fonderie:
        int currentFonderieCount = _getResourceCount(ResourceType.Fonderie);
        if (currentFonderieCount >= 2) {
          startBuilding(_autoTransformMinerals);
        }
        break;
      default:
        break;
    }
  }

  // La fonction [_getResourceCount] renvoie le nombre de ressources d'un type spécifique.
  int _getResourceCount(ResourceType type) {
    return _resources.where((resource) => resource.type == type).length;
  }

  // La fonction [checkForUnlockingCharcoal] vérifie si les conditions pour débloquer le charbon sont remplies.
  void checkForUnlockingCharcoal() {
    var ironLingot =
        _resources.firstWhere((r) => r.type == ResourceType.LingotDeFer);
    var copperLingot =
        _resources.firstWhere((r) => r.type == ResourceType.LingotDeCuivre);
    var charcoal = _resources.firstWhere((r) => r.type == ResourceType.Charbon);
    if (ironLingot.quantity >= 1000 &&
        copperLingot.quantity >= 1000 &&
        !charcoal.isPrimary) {
      charcoal.isPrimary = true;
      notifyListeners();
    }
  }

  // La fonction [getPrimaryResources] renvoie la liste des ressources principales (isPrimary == true).
  List<Resource> getPrimaryResources() {
    return resources.where((resource) => resource.isPrimary).toList();
  }

  // La fonction [startBuilding] commence une action périodique en utilisant un [Timer].
  void startBuilding(void Function() func) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      func();
    });
  }

// La fonction [_autoCollectMinerals] effectue automatiquement la collecte de minéraux.
  void _autoCollectMinerals() {
    var resourceIron =
        _resources.firstWhere((resource) => resource.type == ResourceType.Fer);
    var resourceCopper = _resources
        .firstWhere((resource) => resource.type == ResourceType.Cuivre);
    resourceIron.incrementCustomNumber(5);
    resourceCopper.incrementCustomNumber(5);
    notifyListeners();
  }

  // La fonction [_autoTransformMinerals] effectue automatiquement la transformation de minéraux en lingots.
  void _autoTransformMinerals() {
    _transformMineralToIngot(ResourceType.Fer, ResourceType.LingotDeFer);
    _transformMineralToIngot(ResourceType.Cuivre, ResourceType.LingotDeCuivre);
    notifyListeners();
  }

// La fonction [_transformMineralToIngot] transforme un minéral en lingot.
  void _transformMineralToIngot(
      ResourceType mineralType, ResourceType ingotType) {
    var mineral = _resources.firstWhere((res) => res.type == mineralType);
    var ingot = _resources.firstWhere((res) => res.type == ingotType);
    mineral.quantity -= 1;
    ingot.quantity += 1;
  }
}
