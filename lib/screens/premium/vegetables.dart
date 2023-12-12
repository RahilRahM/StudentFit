import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import '../home/home_widgets/side_bar.dart';
import 'package:student_fit/screens/premium/fruits.dart';
import 'package:student_fit/screens/premium/prem_commons.dart';

class VegetablesPage extends StatefulWidget {
  @override
  _VegetablesPageState createState() => _VegetablesPageState();
}

class _VegetablesPageState extends State<VegetablesPage> {
  // List of image data (path and title)
  final List<Map<String, String>> imageData = [
    {'path': 'assets/images/tomato.jpeg', 'title': 'Tomato'},
    {'path': 'assets/images/beet.jpeg', 'title': 'Beet'},
    {'path': 'assets/images/bellpepper.png', 'title': 'Bellpepper'},
    {'path': 'assets/images/broccoli.png', 'title': 'Broccoli'},
    {'path': 'assets/images/carrot.png', 'title': 'Healthy cookies'},
    {'path': 'assets/images/califlower.jpeg', 'title': 'Califlower'},
    {'path': 'assets/images/potato.jpeg', 'title': 'Potato'},
    {'path': 'assets/images/onion.jpeg', 'title': 'Onion'},
    {'path': 'assets/images/pumpkin.png', 'title': 'Pumpkin'},
    {'path': 'assets/images/parsley.jpeg', 'title': 'Parsley'},
  ];
  List<String> selectedImages = [];

  @override
  void initState() {
    super.initState();
    // Shuffle the imageData list when the widget initializes
    imageData.shuffle();
    filteredImageData = List.from(imageData);
  }

  // List to store the favorite images
  List<String> favoriteImages = [];
  List<Map<String, String>> filteredImageData = [];

  void toggleSelection(String imagePath) {
    setState(() {
      if (selectedImages.contains(imagePath)) {
        selectedImages.remove(imagePath);
      } else {
        selectedImages.add(imagePath);
      }
    });
  }

  void navigateToSelectedItemsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FruitsPage(),
      ),
    );
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirmation',
            style: TextStyle(color: AppColors.primaryColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Do you want to go to the next page with',
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 8),
              Text(
                '${selectedImages.length} items selected?',
                style: const TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                navigateToSelectedItemsPage();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildCard(String imagePath, String title, bool isSelected,
      Function() onSelectionPressed) {
    final isSelected = selectedImages.contains(imagePath);
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
            child: GestureDetector(
              onTap: () {},
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
                  SizedBox(height: 1.0),
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
          if (isSelected)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.20),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          Positioned(
            top: -4.0,
            right: 5.0,
            child: SelectionButton(
              isSelected: isSelected,
              onPressed: onSelectionPressed,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Vegetables',
        showFavoriteIcon: false,
        onFavoritePressed: () {},
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios,
                color: AppColors.blackColor, size: 30),
            onPressed: () {
              showConfirmationDialog();
            },
          ),
        ],
      ),
      drawer: buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth = constraints.maxWidth / 2 - 10;
            return Column(
              children: [
                SelectedItemsCountWidget(selectedCount: selectedImages.length),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: cardWidth / (cardWidth + 80),
                    ),
                    itemCount: filteredImageData.length,
                    itemBuilder: (context, index) {
                      final data = filteredImageData[index];
                      final imagePath = data['path']!;
                      final title = data['title']!;
                      final isFavorite = favoriteImages.contains(imagePath);
                      return buildCard(imagePath, title, isFavorite, () {
                        toggleSelection(imagePath);
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
