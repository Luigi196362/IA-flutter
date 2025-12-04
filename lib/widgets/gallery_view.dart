import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  int _crossAxisCount = 2;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Animals',
    'Cars',
    'Food',
    'Plants',
    'Clothes',
  ];

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
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: 12, // Example count
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
