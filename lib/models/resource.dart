// ignore_for_file: constant_identifier_names
// Cette classe représente une ressource dans le jeu, comme le bois, le minerai de fer brut, etc.

// Énumération des types de ressources disponibles dans le jeu.
enum ResourceType {
  Bois,
  Fer,
  Cuivre,
  Charbon,
  Hache,
  Pioche,
  LingotDeFer,
  PlaqueDeFer,
  LingotDeCuivre,
  TigeEnMetal,
  FilElectrique,
  Mineur,
  Fonderie
}

// La classe [Resource] représente une ressource avec des attributs tels que son type, son nom, sa quantité,
// son statut en tant que ressource principale et un bonus de collecte.
class Resource {
  final ResourceType type;
  String name;
  int quantity;
  bool isPrimary;
  int collectionBonus;

  // Constructeur de la classe Resource avec des valeurs par défaut pour la quantité, le statut principal
  // et le bonus de collecte.
  Resource({
    required this.type,
    required this.name,
    this.quantity = 0,
    this.isPrimary = false,
    this.collectionBonus = 0,
  });

// Incrémente la quantité de la ressource en tenant compte du bonus de collecte.
  void increment() {
    quantity += 1 + collectionBonus;
  }

  // Décrémente la quantité de la ressource en fonction de la valeur passée en argument.
  void decrement(int value) {
    quantity = quantity - value;
  }

  // Incrémente la quantité de la ressource en fonction de la valeur personnalisée passée en argument.
  void incrementCustomNumber(int value) {
    quantity += value;
  }
}
