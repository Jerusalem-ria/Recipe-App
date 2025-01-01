import 'package:flutter/material.dart';
import 'recipe_detail.dart';

class RelatedRecipesPage extends StatefulWidget {
  final Set<String> favoriteRecipes;
  final Function toggleFavorite;
  final List<Map<String, String>> relatedRecipes;

  const RelatedRecipesPage(
      {required this.favoriteRecipes,
      required this.toggleFavorite,
      required this.relatedRecipes,
      super.key});

  @override
  RelatedRecipesPageState createState() => RelatedRecipesPageState();
}

class RelatedRecipesPageState extends State<RelatedRecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Related Recipes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.relatedRecipes.map((recipe) {
            return Stack(
              children: [
                _buildRecipeCard(
                  context: context,
                  imageUrl: recipe['imageUrl']!,
                  title: recipe['title']!,
                  author: recipe['author']!,
                  duration: recipe['duration']!,
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      widget.favoriteRecipes.contains(recipe['title']!)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.favoriteRecipes.contains(recipe['title']!)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () {
                      widget.toggleFavorite(recipe['title']!);
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRecipeCard({
    required BuildContext context,
    required String imageUrl,
    required String title,
    required String author,
    required String duration,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetail(
              title: title,
              imageUrl: imageUrl,
              author: author,
              duration: duration,
              description: 'A delicious recipe for $title',
              favoriteRecipes: widget.favoriteRecipes,
              toggleFavorite: widget.toggleFavorite,
              relatedRecipes: widget.relatedRecipes,
            ),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imageUrl,
                height: 150,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'by $author',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(
              duration,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}