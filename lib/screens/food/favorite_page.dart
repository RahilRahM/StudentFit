import 'commons.dart';
import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';

class FavoritePage extends StatelessWidget {
  final List<String> favoriteImages;
  final List<Map<String, String>> imageData;

  FavoritePage(this.favoriteImages, this.imageData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Favorites',
        showFavoriteIcon: false,
        onFavoritePressed: () {
          // Handle favorite pressed
        },
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth = constraints.maxWidth / 2 - 10;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: cardWidth / (cardWidth + 80),
              ),
              itemCount: favoriteImages.length,
              itemBuilder: (context, index) {
                final favoriteImagePath = favoriteImages[index];

                final imageDataForFavorite = imageData.firstWhere(
                  (data) => data['path'] == favoriteImagePath,
                  orElse: () => {},
                );

                return buildCardWithoutFavoriteIcon(imageDataForFavorite);
              },
            );
          },
        ),
      ),
    );
  }
}
