import 'package:flutter/material.dart';

class BreadcrumbsDisplay extends StatelessWidget {
  const BreadcrumbsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // Define a specific style for breadcrumb text, possibly smaller or different color
    final breadcrumbStyle = textTheme.bodySmall?.copyWith(color: Colors.black54);

    return Container(
      color: Colors.grey[200], // Example background color for the breadcrumb bar
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            "Accueil",
            style: breadcrumbStyle,
          ),
          Text(
            " > ",
            style: breadcrumbStyle,
          ),
          Text(
            "Current Page",
            style: breadcrumbStyle?.copyWith(fontWeight: FontWeight.bold), // Current page might be bold
          ),
        ],
      ),
    );
  }
}
