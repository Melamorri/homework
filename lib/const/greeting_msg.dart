
String greetingMessage(String? name) {
  var timeNow = DateTime.now().hour;
  if (timeNow <= 12) {
    return 'Good morning, $name';
  } else if ((timeNow > 12) && (timeNow <= 16)) {
    return 'Good afternoon, $name';
  } else if ((timeNow > 16) && (timeNow < 20)) {
    return 'Good evening, $name';
  } else {
    return 'Good night, $name';
  }
}