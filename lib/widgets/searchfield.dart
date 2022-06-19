import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final Function(String) onSearch;

  const SearchField({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 50),
      padding: const EdgeInsets.only(left: 20, top: 5, right: 5, bottom: 00),
      height: 50,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFF006064))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(hintText: 'Search'),
              onSubmitted: (String gifName) => widget.onSearch(gifName),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.teal[700],
            onPressed: () {
              widget.onSearch(_controller.text);
            },
          )
        ],
      ),
    );
  }
}
