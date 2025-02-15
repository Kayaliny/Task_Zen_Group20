import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onButtonPressed;

  const ToggleButton({
    Key? key,
    required this.selectedIndex,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 60,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: const Color(0xFF90B9A4),
        borderRadius: BorderRadius.circular(8.94),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ToggleButtons(
              isSelected: [selectedIndex == 0, selectedIndex == 1],
              onPressed: (int index) {
                onButtonPressed(
                  index,
                );
              },
              borderWidth: 0.85,
              borderColor: Colors.transparent,
              selectedBorderColor: Colors.transparent,
              selectedColor: Colors.black,
              fillColor: Colors.white,
              color: Colors.black,
              highlightColor: Colors.transparent,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  alignment: Alignment.center,
                  color: selectedIndex == 0 ? Colors.white : Colors.transparent,
                  child: const Text(
                    'Personal Info',
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  alignment: Alignment.center,
                  color: selectedIndex == 1 ? Colors.white : Colors.transparent,
                  child: const Text('Settings', textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
