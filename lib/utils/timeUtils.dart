String formatTime(int timeInSeconds) {
  var time = timeInSeconds;
  var hours = timeInSeconds ~/ 3600;
  time -= hours * 3600;
  var minutes = time ~/ 60;
  time -= minutes * 60;
  var seconds = time % 60;
  var formatted = '';
  if (hours > 0) formatted += '${hours.toString().padLeft(2, '0')}:';
  formatted += '${minutes.toString().padLeft(2, '0')}:';
  return '$formatted${seconds.toString().padLeft(2, '0')}';
}
