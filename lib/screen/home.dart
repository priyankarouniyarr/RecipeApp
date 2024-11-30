import 'package:flutter/material.dart';
import 'package:recip_app/models/reciepemodel.dart';
import 'package:recip_app/screen/descriptionscreen.dart';
import 'package:recip_app/services/recipes_service.dart';

class RecipeHomeScreen extends StatefulWidget {
  const RecipeHomeScreen({super.key});

  @override
  State<RecipeHomeScreen> createState() => _RecipeHomeScreenState();
}

class _RecipeHomeScreenState extends State<RecipeHomeScreen> {
  List<Recipe> _recipes = [];
  List<Recipe> filteredRecipes = [];
  TextEditingController _searchController = TextEditingController();

  // Fetching all recipes
  void myRecipes() {
    recipesItems().then((value) {
      setState(() {
        _recipes = value;
        filteredRecipes = value; // Show all recipes when data is fetched
      });
    });
  }

  // Filtering recipes based on search query
  void filterRecipes(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredRecipes = _recipes; // If the search is empty, show all recipes
      });
    } else {
      setState(() {
        filteredRecipes = _recipes.where((recipe) {
          return recipe.name.toLowerCase().contains(query.toLowerCase()) ||
              recipe.cuisine.toLowerCase().contains(query.toLowerCase());
        }).toList(); // Filter recipes based on name or cuisine
      });
    }
  }

  @override
  void initState() {
    super.initState();
    myRecipes(); // Fetch and show all recipes initially
    _searchController.addListener(() {
      filterRecipes(_searchController.text); // Call filter when input changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade700, Colors.green.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Food Recipes',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search bar at the top
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search for recipes...',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: filteredRecipes.isEmpty
                  ? Center(
                      child: Text(
                        'No recipes found. Try a different search!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : GridView.builder(
                      itemCount: filteredRecipes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final recipe = filteredRecipes[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DescriptionScreen(recipe: recipe),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 5,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                  child: Image.network(
                                    recipe.image,
                                    height: 140,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      return loadingProgress == null
                                          ? child
                                          : Center(
                                              child:
                                                  CircularProgressIndicator());
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        recipe.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  color: Colors.orange,
                                                  size: 16),
                                              const SizedBox(width: 4),
                                              Text(
                                                recipe.rating.toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.restaurant_menu,
                                                  color: Colors.green,
                                                  size: 16),
                                              const SizedBox(width: 4),
                                              Text(
                                                recipe.cuisine,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(Icons.timer,
                                              color: Colors.grey, size: 16),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${recipe.cookTimeMinutes} mins",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
}
