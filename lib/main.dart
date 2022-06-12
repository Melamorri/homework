import 'package:flutter/material.dart';

List<String> movies = [
  'Крик',
  'Хэллоуин',
  'Я знаю, что вы сделали прошлым летом',
  'Пятница 13-е',
  'Джиперс Криперс'
];

List<String> moviesDescription = [
  'По городу прокатилась волна жестоких убийств, жертвами становятся беззащитные люди. Новой жертвой телефонного маньяка из городка Вудсборо может стать ещё одна девушка — Сидни Прескотт',
  'Убийца-психопат Майкл Майерс, будучи ребенком, совершил убийство собственной сестры в Хэллоуин - День Всех Святых. 15 лет спустя маньяк-убийца снова взялся за старое и терроризирует небольшой городок. Он сбежал из приюта для психически ненормальных, чтобы снова наносить свои смертельные удары в Хэллоуин.',
  'Компания выпускников весело провела вечер на берегу моря. Возвращаясь на машине домой, они сбивают непонятно откуда взявшегося человека. Решив, что он мертв, и не желая лишних неприятностей, они сбрасывают тело в море. А ровно через год получают письмо… Кто-то знает их тайну. Кто-то знает, что они натворили прошлым летом!',
  'Их предупреждали... Их прокляли... В пятницу 13-го их уже ничего не спасёт. Уютный лагерь «Хрустальное озеро» вновь открывается! Вожатые ожидают летнюю смену, приготовив для юных гостей увлекательные мероприятия и забавные игры. Правда, появилась новая игра, о которой вожатые ещё не знают, и она будет пользоваться большой популярностью в этом сезоне. Игра называется «Убей вожатого!»',
  'Если бы Дэрри и Триш знали, во что превратится их обычное путешествие домой на каникулы, то остались бы в колледже навсегда. Брат и сестра заметили его на безлюдной дороге рядом с жуткой, обветшалой церковью. Страшная фигура в длинном чёрном плаще и широкополой шляпе скидывала в подвал свертки, испачканные чем-то красным. После увиденного нужно было немедленно вдавить педаль газа взятой напрокат машины и умчаться от этого проклятого места как можно дальше. '
];


List<String> pictures = [
  'https://icdn.lenta.ru/images/2022/01/11/16/20220111160836538/square_1280_aee40b58884c18bbcda92b128c50f57c.jpg',
  'https://fs.kinomania.ru/file/news/3/35/335539659442f5bc793956f825e7d0e4.jpeg',
  'https://upload.wikimedia.org/wikipedia/ru/thumb/a/a2/I_Know_What_You_Did_Last_Summer.jpg/250px-I_Know_What_You_Did_Last_Summer.jpg',
  'https://www.film.ru/sites/default/files/news/fvjjason.jpg',
  'https://kolesa-uploads.ru/-/da0a3711-2600-4691-b680-10f896c9fc21/1d81a7480b87086aa5294f0900b10fb5.jpg'
];

void main() => runApp(const MyApp());


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _movies = [
    listOfMovies('Крик'),
    listOfMovies('Хэллоуин'),
    listOfMovies('Я знаю, что вы сделали прошлым летом'),
    listOfMovies('Пятница 13-е'),
    listOfMovies('Джиперс Криперс'),
  ];
  late var _filteredList = _movies;
  bool _searchBoolean = false;
  Widget _searchTextField() { //add
    return TextField(
        onChanged: (String s) {
          if (s.isEmpty) {
            _filteredList = _movies;
            return;
          }
          setState(() {
            _filteredList = _movies.where((movie) => movie.name.contains(s)).toList();
            }
            );},
      autofocus: true, //Display the keyboard when TextField is displayed
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search, //Specify the action button on the keyboard
      decoration: const InputDecoration( //Style of TextField
        enabledBorder: UnderlineInputBorder( //Default TextField border
            borderSide: BorderSide(color: Colors.white)
        ),
        focusedBorder: UnderlineInputBorder( //Borders when a TextField is in focus
            borderSide: BorderSide(color: Colors.white)
        ),
        hintText: 'Введите название фильма', //Text that is displayed when nothing is entered.
        hintStyle: TextStyle( //Style of hintText
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
        itemCount:  _filteredList.length,
        itemBuilder: (context, index) {
          var text = _filteredList[index].toString();
          return Card(
              child:
              ListTile(
                  title: Text(text)
              )
          );
        }
          );
        }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: !_searchBoolean ? Text('Фильмы на Хэллоуин') : _searchTextField(),
          automaticallyImplyLeading: false,
          actions:!_searchBoolean
              ? [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _searchBoolean = true;
                    _filteredList = [];
                  });
                })
          ]
              : [
            IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _searchBoolean = false;
                  });
                }
            )
          ]
        ),
        body: !_searchBoolean ? MyStatefulWidget() : _searchListView()
      ),
    );
  }
}

class listOfMovies {
  final String name;


  listOfMovies(this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is listOfMovies && runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;


}

class Movie {
  Movie({
    required this.description,
    required this.title,
    required this.picture,
    this.isExpanded = false,
  });

  String description;
  String title;
  String picture;
  bool isExpanded;
}

List<Movie> generateItems(int numberOfItems) {
  return List<Movie>.generate(numberOfItems, (int index) {
    return Movie(
        title: movies[index],
        description: moviesDescription[index],
        picture: pictures[index]);
  });
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<Movie> _data = generateItems(movies.length);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      animationDuration: Duration(milliseconds: 500),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Movie item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item.picture),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              title: Text(item.title),
            );
          },
          canTapOnHeader: true,
          body: ListTile(
            title: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item.picture),
                  fit: BoxFit.contain,
                ),
                shape: BoxShape.circle,
              ),
            ),
            subtitle: Text(item.description),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
