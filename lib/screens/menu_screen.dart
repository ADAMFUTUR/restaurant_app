import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../models/dish.dart';
import '../providers/favorites_provider.dart';
import '../providers/comments_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/dish_card.dart';
import '../data/sample_dishes.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  final List<DishCategory> _categories = DishCategory.values;
  List<Dish> _allDishes = [];
  List<Dish> _filteredDishes = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _categories.length,
      vsync: this,
    );

    _tabController.addListener(_onTabChanged);
    _loadDishes();
    _filterDishes();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadDishes() {
    _allDishes = SampleDishes.getAllDishes();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      _filterDishes();
      _scrollToTop();
    }
  }

  void _filterDishes() {
    setState(() {
      final selectedCategory = _categories[_tabController.index];
      _filteredDishes = _allDishes
          .where((dish) => dish.category == selectedCategory)
          .where((dish) =>
              _searchQuery.isEmpty ||
              dish.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              dish.description.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    });
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _filterDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Barre de recherche
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Rechercher un plat...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _onSearchChanged('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),

          // TabBar
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              tabs: _categories.map((category) {
                return Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_getCategoryIcon(category)),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          category.label,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              isScrollable: true,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),

          // Liste des plats
          Expanded(
            child: _filteredDishes.isEmpty
                ? _buildEmptyState()
                : AnimationLimiter(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredDishes.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 400),
                          child: SlideAnimation(
                            verticalOffset: 50,
                            child: FadeInAnimation(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: DishCard(
                                  dish: _filteredDishes[index],
                                  onTap: () => _showDishDetails(_filteredDishes[index]),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(DishCategory category) {
    switch (category) {
      case DishCategory.entrees:
        return Icons.restaurant_rounded;
      case DishCategory.mains:
        return Icons.dinner_dining_rounded;
      case DishCategory.desserts:
        return Icons.cake_rounded;
      case DishCategory.drinks:
        return Icons.local_drink_rounded;
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 50,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Aucun plat trouvé',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Essayez avec d\'autres mots-clés'
                : 'Aucun plat disponible dans cette catégorie',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (_searchQuery.isNotEmpty)
            ElevatedButton.icon(
              onPressed: () => _onSearchChanged(''),
              icon: const Icon(Icons.clear_rounded),
              label: const Text('Effacer la recherche'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showDishDetails(Dish dish) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DishDetailsSheet(dish: dish),
    );
  }
}

class DishDetailsSheet extends StatefulWidget {
  final Dish dish;

  const DishDetailsSheet({
    super.key,
    required this.dish,
  });

  @override
  State<DishDetailsSheet> createState() => _DishDetailsSheetState();
}

class _DishDetailsSheetState extends State<DishDetailsSheet> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          // Handle du modal
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // En-tête avec image
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              children: [
                // Image du plat
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(widget.dish.imageUrl),
                      fit: BoxFit.cover,
                      onError: (error, stackTrace) {},
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Consumer<FavoritesProvider>(
                            builder: (context, favoritesProvider, child) {
                              final isFavorite = favoritesProvider.isFavorite(widget.dish.id);
                              return GestureDetector(
                                onTap: () {
                                  favoritesProvider.toggleFavorite(widget.dish);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? AppColors.favoriteColor : Colors.grey,
                                    size: 24,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Informations du plat
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.dish.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              widget.dish.formattedPrice,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        widget.dish.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                          color: Colors.grey[700],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Actions (Like/Dislike)
                      Consumer<CommentsProvider>(
                        builder: (context, commentsProvider, child) {
                          final likes = commentsProvider.getLikes(widget.dish.id);
                          final dislikes = commentsProvider.getDislikes(widget.dish.id);
                          final userReaction = commentsProvider.getUserReaction(widget.dish.id);

                          return Row(
                            children: [
                              _buildActionButton(
                                icon: Icons.thumb_up_rounded,
                                count: likes,
                                isActive: userReaction == 'like',
                                color: AppColors.likeColor,
                                onTap: () => commentsProvider.toggleLike(widget.dish.id),
                              ),
                              const SizedBox(width: 16),
                              _buildActionButton(
                                icon: Icons.thumb_down_rounded,
                                count: dislikes,
                                isActive: userReaction == 'dislike',
                                color: AppColors.dislikeColor,
                                onTap: () => commentsProvider.toggleDislike(widget.dish.id),
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Section commentaires
                      Text(
                        'Commentaires',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Champ d'ajout de commentaire
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                hintText: 'Ajouter un commentaire...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              maxLines: null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Consumer<CommentsProvider>(
                            builder: (context, commentsProvider, child) {
                              return IconButton(
                                onPressed: () {
                                  if (_commentController.text.trim().isNotEmpty) {
                                    commentsProvider.addComment(
                                      widget.dish.id,
                                      _commentController.text.trim(),
                                    );
                                    _commentController.clear();
                                  }
                                },
                                icon: const Icon(Icons.send_rounded),
                                color: AppColors.primary,
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Liste des commentaires
                      Consumer<CommentsProvider>(
                        builder: (context, commentsProvider, child) {
                          final comments = commentsProvider.getComments(widget.dish.id);

                          if (comments.isEmpty) {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    size: 48,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Aucun commentaire pour le moment',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Soyez le premier à laisser un avis !',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return Column(
                            children: comments.asMap().entries.map((entry) {
                              final index = entry.key;
                              final comment = entry.value;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppColors.primary,
                                      child: Text(
                                        'U',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Utilisateur',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            comment,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        commentsProvider.removeComment(widget.dish.id, index);
                                      },
                                      icon: Icon(
                                        Icons.delete_outline_rounded,
                                        size: 16,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required int count,
    required bool isActive,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? color : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? color : Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Text(
              count.toString(),
              style: TextStyle(
                color: isActive ? color : Colors.grey[600],
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
