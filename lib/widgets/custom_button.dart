import 'package:flutter/material.dart';

class CustomGameButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final double width;

  const CustomGameButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.width = 250,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 52,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        // Garis tepi tebal khas komik
        border: Border.all(color: Colors.black, width: 3),
        // Bayangan kaku (Retro Shadow)
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(5),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}