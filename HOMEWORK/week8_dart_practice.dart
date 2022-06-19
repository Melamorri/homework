void main() async {
  print("Список бабочек");
  print(butterflies);
  await addButterfly('Махаон');
  await addButterfly('Капустница');
  await addButterfly('Редиска');
}

var butterflies = [
  'Крапивница',
  'Павлиний глаз',
  'Капустница',
  'Голубянка алексис',
];

Future<void> addButterfly(String butterfly) {
  print("Проверяем наличие бабочки...");
  return Future.delayed(Duration(seconds: 3), () {
    try {
      if (!butterflies.contains(butterfly)) {
        butterflies.add(butterfly);
        print('Бабочка успешно добавлена!');
        print(butterflies);
      } else {
        throw DuplicateException();
      }
    } on DuplicateException catch (e) {
      print(e.errorMessage());
    }
  });
}

class DuplicateException implements Exception {
  @override
  String errorMessage() {
    return "Такая бабочка уже есть в списке";
  }
}