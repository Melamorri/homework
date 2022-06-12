void main() {
  Worker worker = Worker('Иван', 'Иванов', 10, 31);

  worker.getSalary();
}

class Worker {
  String name;
  String surname;
  int rate;
  int days;

  Worker(this.name, this.surname, this.rate, this.days);

  void getSalary() {

    print("Имя: $name");
    print("Фамилия: $surname");
    print("Количество дней: $days");
    print("Ставка: $rate");
    print("Итого зарплата: ($rate * $days");
  }
}
