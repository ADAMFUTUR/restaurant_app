import '../models/dish.dart';

class SampleDishes {
  static List<Dish> getAllDishes() {
    return [
      // ENTRÉES
      Dish(
        id: 'entree_001',
        name: 'Tartare de saumon',
        description: 'Saumon frais dé à l\'avocat, crème d\'aneth et pain grillé',
        price: 16.50,
        imageUrl: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=500&h=300&fit=crop',
        category: DishCategory.entrees,
        ingredients: ['Saumon frais', 'Avocat', 'Aneth', 'Citron', 'Pain de seigle'],
        nutritionalInfo: {
          'calories': 220,
          'proteins': 18,
          'carbs': 8,
          'fats': 12,
        },
      ),

      Dish(
        id: 'entree_002',
        name: 'Foie gras poêlé',
        description: 'Foie gras du Périgord, compotée de figues et pain briché',
        price: 22.00,
        imageUrl: 'https://images.unsplash.com/photo-1606787620819-8bdf0c44c293?w=500&h=300&fit=crop',
        category: DishCategory.entrees,
        ingredients: ['Foie gras', 'Figues', 'Pain brioché', 'Miel'],
        nutritionalInfo: {
          'calories': 380,
          'proteins': 12,
          'carbs': 15,
          'fats': 32,
        },
      ),

      Dish(
        id: 'entree_003',
        name: 'Velouté de châtaignes',
        description: 'Velouté onctueux aux châtaignes, chantilly de truffe',
        price: 14.00,
        imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=500&h=300&fit=crop',
        category: DishCategory.entrees,
        ingredients: ['Châtaignes', 'Crème', 'Truffe', 'Bouillon de volaille'],
        nutritionalInfo: {
          'calories': 280,
          'proteins': 8,
          'carbs': 25,
          'fats': 16,
        },
      ),

      Dish(
        id: 'entree_004',
        name: 'Carpaccio de bœuf',
        description: 'Fines tranches de bœuf, roquette, parmesan et pignons',
        price: 18.50,
        imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=500&h=300&fit=crop',
        category: DishCategory.entrees,
        ingredients: ['Bœuf', 'Roquette', 'Parmesan', 'Pignons', 'Huile d\'olive'],
        nutritionalInfo: {
          'calories': 320,
          'proteins': 24,
          'carbs': 4,
          'fats': 22,
        },
      ),

      // PLATS PRINCIPAUX
      Dish(
        id: 'main_001',
        name: 'Filet de bœuf Wellington',
        description: 'Filet de bœuf en croûte, duxelles de champignons, sauce au porto',
        price: 42.00,
        imageUrl: 'https://images.unsplash.com/photo-1558030006-450675393462?w=500&h=300&fit=crop',
        category: DishCategory.mains,
        ingredients: ['Filet de bœuf', 'Pâte feuilletée', 'Champignons', 'Porto'],
        nutritionalInfo: {
          'calories': 650,
          'proteins': 45,
          'carbs': 28,
          'fats': 38,
        },
      ),

      Dish(
        id: 'main_002',
        name: 'Saumon grillé',
        description: 'Pavé de saumon grillé, risotto aux petits légumes',
        price: 28.50,
        imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=500&h=300&fit=crop',
        category: DishCategory.mains,
        ingredients: ['Saumon', 'Riz arborio', 'Courgettes', 'Tomates cerises'],
        nutritionalInfo: {
          'calories': 520,
          'proteins': 35,
          'carbs': 45,
          'fats': 22,
        },
      ),

      Dish(
        id: 'main_003',
        name: 'Magret de canard',
        description: 'Magret de canard aux cerises, purée de panais',
        price: 32.00,
        imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=500&h=300&fit=crop',
        category: DishCategory.mains,
        ingredients: ['Magret de canard', 'Cerises', 'Panais', 'Miel'],
        nutritionalInfo: {
          'calories': 580,
          'proteins': 38,
          'carbs': 22,
          'fats': 35,
        },
      ),

      Dish(
        id: 'main_004',
        name: 'Risotto aux champignons',
        description: 'Risotto crémeux aux cèpes et champignons de Paris',
        price: 24.00,
        imageUrl: 'https://images.unsplash.com/photo-1476124369491-e7addf5db371?w=500&h=300&fit=crop',
        category: DishCategory.mains,
        ingredients: ['Riz arborio', 'Cèpes', 'Champignons de Paris', 'Parmesan'],
        nutritionalInfo: {
          'calories': 420,
          'proteins': 15,
          'carbs': 52,
          'fats': 18,
        },
      ),

      Dish(
        id: 'main_005',
        name: 'Côte de bœuf',
        description: 'Côte de bœuf maturée 28 jours, légumes rôtis',
        price: 45.00,
        imageUrl: 'https://images.unsplash.com/photo-1448043552756-e747b7d2b04e?w=500&h=300&fit=crop',
        category: DishCategory.mains,
        ingredients: ['Côte de bœuf', 'Carottes', 'Courgettes', 'Pommes de terre'],
        nutritionalInfo: {
          'calories': 720,
          'proteins': 52,
          'carbs': 18,
          'fats': 48,
        },
      ),

      // DESSERTS
      Dish(
        id: 'dessert_001',
        name: 'Tarte au chocolat',
        description: 'Tarte au chocolat noir 70%, crème anglaise à la vanille',
        price: 12.50,
        imageUrl: 'https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?w=500&h=300&fit=crop',
        category: DishCategory.desserts,
        ingredients: ['Chocolat noir', 'Œufs', 'Crème', 'Vanille'],
        nutritionalInfo: {
          'calories': 380,
          'proteins': 8,
          'carbs': 42,
          'fats': 20,
        },
      ),

      Dish(
        id: 'dessert_002',
        name: 'Tiramisu maison',
        description: 'Tiramisu traditionnel aux biscuits imbibés de café',
        price: 11.00,
        imageUrl: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=500&h=300&fit=crop',
        category: DishCategory.desserts,
        ingredients: ['Mascarpone', 'Café', 'Biscuits', 'Cacao'],
        nutritionalInfo: {
          'calories': 420,
          'proteins': 12,
          'carbs': 38,
          'fats': 24,
        },
      ),

      Dish(
        id: 'dessert_003',
        name: 'Crème brûlée',
        description: 'Crème brûlée à la vanille de Madagascar',
        price: 10.50,
        imageUrl: 'https://images.unsplash.com/photo-1470324161839-ce2bb6fa6bc3?w=500&h=300&fit=crop',
        category: DishCategory.desserts,
        ingredients: ['Crème', 'Vanille', 'Œufs', 'Sucre'],
        nutritionalInfo: {
          'calories': 320,
          'proteins': 6,
          'carbs': 28,
          'fats': 20,
        },
      ),

      Dish(
        id: 'dessert_004',
        name: 'Mille-feuille',
        description: 'Mille-feuille traditionnel, crème pâtissière à la vanille',
        price: 13.00,
        imageUrl: 'https://images.unsplash.com/photo-1508736793122-f516e3ba5569?w=500&h=300&fit=crop',
        category: DishCategory.desserts,
        ingredients: ['Pâte feuilletée', 'Crème pâtissière', 'Vanille', 'Sucre glace'],
        nutritionalInfo: {
          'calories': 450,
          'proteins': 8,
          'carbs': 52,
          'fats': 24,
        },
      ),

      // BOISSONS
      Dish(
        id: 'drink_001',
        name: 'Vin rouge Bordeaux',
        description: 'Château Margaux 2018, accompagne parfaitement nos viandes',
        price: 8.50,
        imageUrl: 'https://images.unsplash.com/photo-1506377247379-753c2684c817?w=500&h=300&fit=crop',
        category: DishCategory.drinks,
        ingredients: ['Raisin rouge', 'Tanins'],
        nutritionalInfo: {
          'calories': 120,
          'proteins': 0,
          'carbs': 4,
          'fats': 0,
        },
      ),

      Dish(
        id: 'drink_002',
        name: 'Champagne Brut',
        description: 'Champagne Dom Pérignon, bulles fines et élégantes',
        price: 15.00,
        imageUrl: 'https://images.unsplash.com/photo-1547595628-c61a29f496f0?w=500&h=300&fit=crop',
        category: DishCategory.drinks,
        ingredients: ['Pinot noir', 'Chardonnay'],
        nutritionalInfo: {
          'calories': 90,
          'proteins': 0,
          'carbs': 2,
          'fats': 0,
        },
      ),

      Dish(
        id: 'drink_003',
        name: 'Cocktail Signature',
        description: 'Cocktail maison aux fruits rouges et gin',
        price: 12.00,
        imageUrl: 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=500&h=300&fit=crop',
        category: DishCategory.drinks,
        ingredients: ['Gin', 'Fruits rouges', 'Citron vert', 'Sirop'],
        nutritionalInfo: {
          'calories': 180,
          'proteins': 0,
          'carbs': 15,
          'fats': 0,
        },
      ),

      Dish(
        id: 'drink_004',
        name: 'Eau minérale',
        description: 'Eau minérale naturelle française',
        price: 4.50,
        imageUrl: 'https://images.unsplash.com/photo-1571068316344-75bc76f77890?w=500&h=300&fit=crop',
        category: DishCategory.drinks,
        ingredients: ['Eau'],
        nutritionalInfo: {
          'calories': 0,
          'proteins': 0,
          'carbs': 0,
          'fats': 0,
        },
      ),

      Dish(
        id: 'drink_005',
        name: 'Café espresso',
        description: 'Café espresso italien, grains torréfiés',
        price: 3.50,
        imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500&h=300&fit=crop',
        category: DishCategory.drinks,
        ingredients: ['Café arabica'],
        nutritionalInfo: {
          'calories': 5,
          'proteins': 0,
          'carbs': 1,
          'fats': 0,
        },
      ),

      Dish(
        id: 'drink_006',
        name: 'Thé Earl Grey',
        description: 'Thé noir aromatisé à la bergamote',
        price: 4.00,
        imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=500&h=300&fit=crop',
        category: DishCategory.drinks,
        ingredients: ['Thé noir', 'Bergamote'],
        nutritionalInfo: {
          'calories': 2,
          'proteins': 0,
          'carbs': 0,
          'fats': 0,
        },
      ),
    ];
  }

  static List<Dish> getDishesByCategory(DishCategory category) {
    return getAllDishes().where((dish) => dish.category == category).toList();
  }

  static List<Dish> getPopularDishes() {
    return getAllDishes().take(6).toList();
  }

  static List<Dish> searchDishes(String query) {
    final lowercaseQuery = query.toLowerCase();
    return getAllDishes()
        .where((dish) =>
            dish.name.toLowerCase().contains(lowercaseQuery) ||
            dish.description.toLowerCase().contains(lowercaseQuery) ||
            dish.ingredients.any((ingredient) =>
                ingredient.toLowerCase().contains(lowercaseQuery)))
        .toList();
  }
}
