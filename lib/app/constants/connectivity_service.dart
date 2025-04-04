import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'dart:async';

class ConnectivityService {
  // Pour garder une trace de l'état de la connexion Internet
  bool _isConnected = true;

  // StreamSubscription pour écouter les changements de statut de la connexion
  late StreamSubscription<InternetStatus> _internetConnectionStreamSubscription;

  ConnectivityService() {
    // Démarre l'écoute des changements de connexion
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((status) {
      _isConnected = (status == InternetStatus.connected);
    });
  }

  // Méthode pour obtenir le statut actuel de la connexion
  bool get isConnected => _isConnected;

  // Méthode pour arrêter l'écoute quand ce n'est plus nécessaire
  void dispose() {
    _internetConnectionStreamSubscription.cancel();
  }
}
