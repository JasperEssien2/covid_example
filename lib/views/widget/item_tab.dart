import 'package:covid_example/theme/colors.dart';
import 'package:flutter/material.dart';

class ItemTabWidget extends StatelessWidget {
  const ItemTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(42),
        color: colorTabUnselected,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Expanded(child: ItemTab(isSelected: true, text: 'My Country')),
          Expanded(child: ItemTab(isSelected: false, text: 'Global')),
        ],
      ),
    );
  }
}

class ItemTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  const ItemTab({Key? key, required this.isSelected, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(42),
        color: isSelected ? Colors.white : colorTabUnselected,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
