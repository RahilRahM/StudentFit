import 'package:flutter/foundation.dart';

class FavoriteImagesModel with ChangeNotifier {
  List<String> _favoriteImages = [];

  List<String> get favoriteImages => _favoriteImages;

  void addFavorite(String imagePath) {
    if (!_favoriteImages.contains(imagePath)) {
      _favoriteImages.add(imagePath);
      notifyListeners();
    }
  }

  void removeFavorite(String imagePath) {
    if (_favoriteImages.contains(imagePath)) {
      _favoriteImages.remove(imagePath);
      notifyListeners();
    }
  }

  void loadFavorites(List<String> favorites) {
    _favoriteImages = favorites;
    notifyListeners();
  }
}
