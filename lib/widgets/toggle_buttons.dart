import 'package:flutter/material.dart';

class MyToggleButtons extends StatefulWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const MyToggleButtons({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyToggleButtonsState createState() => _MyToggleButtonsState();
}

class _MyToggleButtonsState extends State<MyToggleButtons> {
  final List<String> tabLabels = ['Details', 'Tasting notes', 'History'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 100;
    final buttonWidth = screenWidth / tabLabels.length;

    return Container(
      color: const Color(0xFF122329),
      child: ToggleButtons(
        isSelected: List.generate(
          tabLabels.length,
          (index) => widget.selectedTab == index,
        ),
        onPressed: (index) {
          widget.onTabChanged(index); // notify parent
        },
        fillColor: const Color(0xFFD49A00),
        color: Colors.white70,
        selectedColor: Colors.black,
        borderRadius: BorderRadius.circular(8),
        constraints: BoxConstraints(minWidth: buttonWidth, minHeight: 40),
        children: tabLabels.map((label) {
          return Text(label);
        }).toList(),
      ),
    );
  }
}
