import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeComponent extends StatefulWidget {
  @override
  _HomeComponentState createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  late Future<List<dynamic>> _categories;
  String? _selectedImage; // To hold the currently selected image path

  // Define a mapping from category names to local image paths
  final Map<String, String> _categoryImages = {
    'Drinks': 'assets/drinks.jpg',
    'Snacks': 'assets/snacks.jpg',
    'Meals': 'assets/meals.jpg',
    // Add more mappings as necessary
  };

  @override
  void initState() {
    super.initState();
    _categories = fetchCategories();
  }

  Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse(
        'https://sawfly-glowing-bluebird.ngrok-free.app/api/categories?plane_id=3&country_id=223&business_idea_id=1'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder<List<dynamic>>(
          future: _categories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final categories = snapshot.data ?? [];
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            String categoryName = category['name'];
                            _selectedImage = _categoryImages[categoryName]; // Use local image path
                          });
                        },
                        child: Text(category['name']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, // Button color
                          foregroundColor: Colors.white,  // Text color
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
        SizedBox(height: 20), // Add some space between the buttons and the image
        _selectedImage != null
            ? Container(
                height: 180, // Set a height for the image container
                width: MediaQuery.of(context).size.width * 0.95, // Set a reduced width (95% of screen width)
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                  image: DecorationImage(
                    image: AssetImage(_selectedImage!), // Load image from local assets
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(
                height: 180,
                width: MediaQuery.of(context).size.width * 0.95, // Reduced width for placeholder as well
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners for placeholder
                  color: Colors.grey[200], // Placeholder when no image is selected
                ),
                child: Center(
                  child: Text(
                    'Select a category to view the image',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.home, size: 100, color: Colors.orange),
                SizedBox(height: 20),
                Text('Welcome Home!',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('This is the home page component.',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
