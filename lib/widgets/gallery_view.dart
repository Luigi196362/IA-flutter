import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../l10n/app_localizations.dart';
import '../config/api_config.dart';
import '../screens/image_detail_screen.dart';
import '../models/image_item.dart';

class GalleryView extends StatefulWidget {
  final String username;

  const GalleryView({super.key, required this.username});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  int _crossAxisCount = 2;
  String _searchQuery = '';
  String _selectedCategory = 'All';
  List<ImageItem> _images = [];
  bool _isLoading = true;
  String? _errorMessage;

  final List<String> _categories = [
    'All',
    'Animals',
    'Cars',
    'Food',
    'Plants',
    'Clothes',
  ];

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/images',
      ).replace(queryParameters: {'username': widget.username});

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          _images = jsonList.map((json) => ImageItem.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load images: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading images: $e';
        _isLoading = false;
      });
    }
  }

  void _toggleGridSize() {
    setState(() {
      if (_crossAxisCount == 2) {
        _crossAxisCount = 3;
      } else if (_crossAxisCount == 3) {
        _crossAxisCount = 1;
      } else {
        _crossAxisCount = 2;
      }
    });
  }

  String _getCategoryLabel(BuildContext context, String category) {
    switch (category) {
      case 'Animals':
        return AppLocalizations.of(context)!.categoryAnimals;
      case 'Cars':
        return AppLocalizations.of(context)!.categoryCars;
      case 'Food':
        return AppLocalizations.of(context)!.categoryFood;
      case 'Plants':
        return AppLocalizations.of(context)!.categoryPlants;
      case 'Clothes':
        return AppLocalizations.of(context)!.categoryClothes;
      default:
        return AppLocalizations.of(context)!.categoryAll;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.filterLabel}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _selectedCategory,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedCategory = newValue;
                            });
                          }
                        },
                        items: _categories.map<DropdownMenuItem<String>>((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(_getCategoryLabel(context, value)),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      _crossAxisCount == 1
                          ? Icons.grid_view
                          : _crossAxisCount == 2
                          ? Icons.view_comfy
                          : Icons.view_list,
                    ),
                    onPressed: _toggleGridSize,
                    tooltip: 'Change Grid Size',
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage != null
              ? Center(
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchImages,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8, // Adjusted for card content
                    ),
                    itemCount: _getFilteredImages().length,
                    itemBuilder: (context, index) {
                      final image = _getFilteredImages()[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ImageDetailScreen(image: image),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: 'image_${image.id}',
                                  child: Image.memory(
                                    image.data,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      image.classification,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFF6A11CB),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
    );
  }

  String _mapCategoryToApiValue(String category) {
    switch (category) {
      case 'Animals':
        return 'Animales';
      case 'Cars':
        return 'Autos';
      case 'Food':
        return 'Comida';
      case 'Plants':
        return 'Plantas';
      case 'Clothes':
        return 'Ropa';
      default:
        return category;
    }
  }

  List<ImageItem> _getFilteredImages() {
    return _images.where((image) {
      final matchesSearch =
          image.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          image.classification.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

      final apiCategory = _mapCategoryToApiValue(_selectedCategory);
      final matchesCategory =
          _selectedCategory == 'All' ||
          image.classification.toLowerCase() == apiCategory.toLowerCase();

      return matchesSearch && matchesCategory;
    }).toList();
  }
}
