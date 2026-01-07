import 'package:flutter/material.dart';
import '../models/image_item.dart';
import '../l10n/app_localizations.dart';
import '../utils/file_saver.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ImageDetailScreen extends StatefulWidget {
  final ImageItem image;
  final VoidCallback? onDelete;

  const ImageDetailScreen({super.key, required this.image, this.onDelete});

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  final List<String> _categories = [
    'Animals',
    'Cars',
    'Food',
    'Motorcycles',
    'Plants',
    'Clothes',
  ];

  String _getCategoryLabel(BuildContext context, String category) {
    switch (category) {
      case 'Animals':
        return AppLocalizations.of(context)!.categoryAnimals;
      case 'Cars':
        return AppLocalizations.of(context)!.categoryCars;
      case 'Food':
        return AppLocalizations.of(context)!.categoryFood;
      case 'Motorcycles':
        return AppLocalizations.of(context)!.categoryMotorcycles;
      case 'Plants':
        return AppLocalizations.of(context)!.categoryPlants;
      case 'Clothes':
        return AppLocalizations.of(context)!.categoryClothes;
      default:
        return category;
    }
  }

  int _mapCategoryToInt(String category) {
    switch (category) {
      case 'Animals':
        return 0;
      case 'Cars':
        return 1;
      case 'Food':
        return 2;
      case 'Motorcycles':
        return 3;
      case 'Plants':
        return 4;
      case 'Clothes':
        return 5;
      default:
        return 0;
    }
  }

  Future<void> _updateClassification(String category) async {
    final int classId = _mapCategoryToInt(category);
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}/api/images/${widget.image.id}/classification',
    ).replace(queryParameters: {'classification': classId.toString()});

    try {
      final response = await http.put(uri);

      if (mounted) {
        if (response.statusCode == 200) {
          Navigator.pop(context); // Close dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.classificationUpdated,
              ),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error updating classification: ${response.statusCode}',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showCorrectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String tempSelectedCategory = _categories.first;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.correctClassification),
              content: DropdownButton<String>(
                value: tempSelectedCategory,
                isExpanded: true,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      tempSelectedCategory = newValue;
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
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.cancelButton),
                ),
                ElevatedButton(
                  onPressed: () => _updateClassification(tempSelectedCategory),
                  child: Text(AppLocalizations.of(context)!.confirmButton),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _deleteImage() async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/images/${widget.image.id}');

    try {
      final response = await http.delete(uri);

      if (mounted) {
        if (response.statusCode == 200) {
          widget.onDelete?.call();
          Navigator.pop(context); // Return to gallery
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.deleteSuccess),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(
                  context,
                )!.deleteFailed(response.statusCode.toString()),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.deleteFailed(e.toString()),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.deleteConfirmTitle),
          content: Text(AppLocalizations.of(context)!.deleteConfirmContent),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancelButton),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                _deleteImage();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                AppLocalizations.of(context)!.confirmButton,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _downloadImage() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.downloadStarted),
          backgroundColor: Colors.blue,
        ),
      );

      String filename = widget.image.name;
      if (filename.isEmpty ||
          filename.startsWith('.') ||
          !filename.contains('.')) {
        final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
        filename = 'foto_$timestamp.jpg';
      }

      await FileSaver.saveFile(filename, widget.image.data);

      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Download completed!'), // TODO: Add to l10n
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download failed: $e'), // TODO: Add to l10n
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: 'image_${widget.image.id}',
          child: Image.memory(
            widget.image.data,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.broken_image,
                color: Colors.white,
                size: 100,
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse:
                true, // To make them appear "de derecha a izquierda" as requested? Or just standard?
            // The user said "vuelvan a aparecer de derecha a izquierda".
            // If they mean the previous state (Row) was "right to left", that's odd because it was MainAxisAlignment.spaceEvenly.
            // Maybe they mean "horizontalmente" (from left to right, implied).
            // However, "reverse: true" on a horizontal scroll view starts from the end (right).
            // Let's try standard Row first but maybe with `MainAxisAlignment.end` if it wasn't scrolling.
            // But for scrolling, `reverse: true` makes it start at the right? No, standard is left.
            // Let's stick to standard Left-to-Right scrolling Row, but maybe the user meant they want the buttons aligned to the right?
            // "Eliminar" was the one overflowing on the right.
            // Let's just make it a scrolling Row.
            // Wait, "vuelvan a aparecer de derecha a izquierda" -> "appear again from right to left".
            // Maybe they want the order reversed?
            // "Download", "Correct", "Delete".
            // Previous code: Download (Left), Correct (Middle), Delete (Right).
            // "Eliminar se sale de la pantalla del lado derecho" -> Delete went off screen right.
            // "Ahora se salen por la parte de abajo" -> Wrap made them stack down.
            // "Quiero que vuelvan a aparecer de derecha a izquierda" -> Maybe "Izquierda a Derecha"? (Left to Right).
            // Just standard horizontal flow. I will assume they misspoke or meant "Horizontal".
            // I will use SingleChildScrollView with horizontal axis.
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _downloadImage,
                  icon: const Icon(Icons.download, size: 18),
                  label: Text(
                    AppLocalizations.of(context)!.downloadButton,
                    style: const TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _showCorrectionDialog,
                  icon: const Icon(Icons.edit, size: 18),
                  label: Text(
                    AppLocalizations.of(context)!.correctButton,
                    style: const TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _showDeleteConfirmationDialog,
                  icon: const Icon(Icons.delete, size: 18),
                  label: Text(
                    AppLocalizations.of(context)!.deleteButton,
                    style: const TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
