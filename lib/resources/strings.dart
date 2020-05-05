class Strings {
  // general
  static const createButton = 'CRIAR';
  static const addButton = 'ADICIONAR';
  static const newButton = 'NOVO';
  static const favoriteButton = 'FAVORITOS';
  static const title = 'TÍTULO';
  static const time = 'TEMPO';
  static const yes = 'SIM';
  static const no = 'NÃO';

  // exit dialog
  static const exitDialogTitle = 'Tem certeza que deseja sair?';
  static const exitDialogLabel = 'Os temporizadores ativos serão '
      'interrompidos.\n\nDica: Você pode minimizar o app =)';

  // notification
  static const timerExpiredTitle = 'Temporizador encerrado';
  static String timerExpiredDescription(String title) => '$title está pronto!';

  // main.dart
  static const appTitle = 'Kitchen Timer';

  // timer_screen.dart
  static const timerTitle = 'Temporizadores';
  static String noTimers(bool hasFavorite) =>
      'Clique em "Novo"${hasFavorite ? ' ou em "Favoritos"' : ''} para incluir um temporizador!';

  // add_timer_screen.dart
  static const addTimerTitle = 'Novo temporizador';
  static const timerCreated = 'Temporizador criado com suceso!';
  static const timerTitleHint = 'Comida, exercícios, leitura, etc';
  static const timerTitleError = 'O título é obrigatório';
  static const noTimeSelected = 'Selecione um tempo!';

  // favorites_screen.dart
  static const favoritesTitle = 'Favoritos';
  static const timerAdded = 'Temporizadores adicionados com suceso!';
}
