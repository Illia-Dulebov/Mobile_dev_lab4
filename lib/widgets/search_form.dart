import 'package:edu_books_flutter/bloc/catalog/catalog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'circle_clear_button.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({Key? key, this.searchIsFocused = false}) : super(key: key);

  final bool searchIsFocused;

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  var textController = TextEditingController();
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.searchIsFocused,
      onChanged: (value) {
        BlocProvider.of<CatalogBloc>(context)
            .add(SearchFromCatalog(input: value));
        setState(() {
          _visible = true;
        });
      },
      cursorColor: const Color(0xff181B19),
      style: const TextStyle(
        color: Color(0xff181B19),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      controller: textController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        prefixIcon: Container(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            'assets/icons/search.svg',
            height: 15,
            width: 15,
            color: const Color(0xFFA5A5A5),
          ),
        ),
        filled: true,
        isDense: true,
        hintStyle: const TextStyle(
          color: Color(0xFFA5A5A5),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        hintText: 'Пошук...',
        fillColor: const Color(0xffF2F3F2),
        suffixIcon: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _visible ? 1.0 : 0.0,
          child: CircleClearButton(
            size: 12,
            onPressed: () {
              setState(() {
                _visible = !_visible;
                textController.clear();
                BlocProvider.of<CatalogBloc>(context)
                    .add(SearchFromCatalog(input: ''));
              });
            },
          ),
        ),
      ),
    );
  }
}
