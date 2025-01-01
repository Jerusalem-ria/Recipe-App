import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userImage;
  final List<Map<String, String>> userRecipes;

  const AccountPage({
    required this.userName,
    required this.userEmail,
    required this.userImage,
    required this.userRecipes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(userImage),
              ),
              SizedBox(height: 16),
              Text(
                userName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                userEmail,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                'Your Recipes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                children: userRecipes.map((recipe) {
                  return _buildRecipeCard(
                    context: context,
                    imageUrl: recipe['imageUrl']!,
                    title: recipe['title']!,
                    author: recipe['author']!,
                    duration: recipe['duration']!,
                  );
                }).toList(),
              ),
            ],
          ),
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
        // Navigate to RecipeDetail... if needed
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imageUrl,
                height: 150,
                width: double.infinity,
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
