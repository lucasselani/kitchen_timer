class Strings {
  // general
  static const createButton = 'CRIAR';
  static const newButton = 'NOVO';
  static const favoriteButton = 'FAVORITOS';

  // notification
  static const timerExpiredTitle = 'Temporizador encerrado';

  static String timerExpiredDescription(String title) => '$title está pronto!';

  // main.dart
  static const appTitle = 'Kitchen Timer';

  // timer_screen.dart
  static const timerTitle = 'Temporizadores';

  static String noTimers(hasFavorite) =>
      'Clique em "Novo"${hasFavorite ? ' ou em "Favoritos"' : ''} para incluir um temporizador!';

  // add_timer_screen.dart
  static const addTimerTitle = 'Novo temporizador';
  static const timerCreated = 'Temporizador criado com suceso!';
  static const noTimeSelected = 'Selecione um tempo!';

  // favorites_screen.dart
  static const favoritesTitle = 'Favoritos';
}
