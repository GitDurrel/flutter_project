import 'package:flutter/material.dart';

// Classe personnalisée pour une transition de page avec un effet de fondu (Fade).
// Elle hérite de PageRouteBuilder pour permettre une personnalisation complète de la transition.
class FadePageRoute<T> extends PageRouteBuilder<T> {
  // Le widget (page) à afficher après la transition.
  final Widget child;

  // Constructeur qui prend le widget enfant comme argument requis.
  FadePageRoute({required this.child})
      : super(
          // pageBuilder définit comment construire le contenu principal de la route (la page elle-même).
          // Ici, il retourne simplement le widget enfant fourni.
          pageBuilder: (context, animation, secondaryAnimation) => child,

          // transitionsBuilder définit comment la transition entre les pages doit se comporter.
          // Il prend l'animation primaire (pour la page entrante) et secondaire (pour la page sortante).
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Utilise FadeTransition pour créer un effet de fondu basé sur l'animation.
            // L'opacité du widget enfant est animée de 0.0 à 1.0.
            return FadeTransition(opacity: animation, child: child);
          },

          // Durée de la transition. Ici, 300 millisecondes.
          transitionDuration: const Duration(milliseconds: 300),
        );
}

// Comment utiliser cette route :
// Navigator.of(context).push(FadePageRoute(child: VotreNouvellePage()));
