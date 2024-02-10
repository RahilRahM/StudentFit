import 'dart:ui';
import 'package:flutter/material.dart';


class FavoriteButton extends StatefulWidget {
  final Function(bool isFavorite) onFavoriteChanged;

  FavoriteButton({required this.onFavoriteChanged});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.0,
      height: 32.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: isFavorite
            ? const Color.fromRGBO(255, 255, 255, 0.20)
            : Colors.transparent,
      ),
      child: BackdropFilter(
        filter: isFavorite
            ? ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0)
            : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
        child: IconButton(
          icon: Transform(
            transform: Matrix4.rotationZ(isFavorite ? 0 : 0),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
          ),
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
              widget.onFavoriteChanged(isFavorite);
            });
          },
        ),
      ),
    );
  }
}

//image card
Widget buildCard(String imagePath, String title, bool isFavorite,
    Function() onFavoritePressed) {
  return Container(
    margin: const EdgeInsets.all(16),
    width: 175.0,
    height: 175.0,
    child: Stack(
      children: [
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
            onTap: () {
              // Handle image tap
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 1.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -4.0,
          right: 15.0,
          child: FavoriteButton(
            onFavoriteChanged: (bool isFavorite) {
              onFavoritePressed();
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildCardWithoutFavoriteIcon(Map<String, dynamic> imageData) {
  final String imagePath = imageData['path'] as String; // Cast as String

  return Container(
    margin: const EdgeInsets.all(16),
    width: 175.0,
    height: 175.0,
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          // Handle image tap
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network( // Changed to Image.network
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Text('Image not available'));
                  },
                ),
              ),
            ),
            const SizedBox(height: 1.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  imageData['title'] as String, // Cast as String
                  style: const TextStyle(fontSize: 12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


//empty favorites error
Widget buildEmptyFavoritesDialog(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    elevation: 16.0,
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning,
            color: Color.fromARGB(255, 255, 113, 139),
            size: 48.0,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Empty Favorites',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'You have no favorite images.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(88, 30),
              backgroundColor: const Color.fromARGB(255, 255, 113, 139),
            ),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
