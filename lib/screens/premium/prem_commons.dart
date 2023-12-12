import '../../commons/colors.dart';
import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {
  final bool isSelected;
  final Function() onPressed;

  SelectionButton({required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isSelected ? AppColors.primaryColor : Colors.grey,
        size: 32.0, // Adjust the size as needed
      ),
      onPressed: onPressed,
    );
  }
}

class SelectedItemsCountWidget extends StatelessWidget {
  final int selectedCount;

  SelectedItemsCountWidget({required this.selectedCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Text(
        '$selectedCount items selected',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
