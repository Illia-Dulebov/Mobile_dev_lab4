import 'dart:math';

import 'package:edu_books_flutter/bloc/catalog/catalog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_checkbox.dart';

class FiltersWidget extends StatefulWidget {
  const FiltersWidget({Key? key}) : super(key: key);

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  bool isForWhomeOpen = true;
  bool isGradeOpen = true;
  bool isSubjectOpen = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Фільтр',
                style: TextStyle(fontSize: 27, color: Color(0xFF2B2B2B)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Клас',
                          style: TextStyle(
                              fontSize: 21,
                              color: Color(0xFF2B2B2B),
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isGradeOpen = !isGradeOpen;
                            });
                          },
                          borderRadius: BorderRadius.circular(40),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Transform.rotate(
                              angle: isGradeOpen ? 0 : -pi / 2,
                              child: SizedBox(
                                width: 14,
                                height: 14,
                                child: SvgPicture.asset(
                                  'assets/icons/down_arrow.svg',
                                  color: Color(0xFF181725),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  isGradeOpen
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 11,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CustomCheckboxListTile(
                                isChecked: (state as CatalogSuccess).unconfirmedFilters.containsKey('class_id') 
                                  ?  (state.unconfirmedFilters['class_id'] as List<int>).contains(index + 1) 
                                  : false,
                                text: '${index + 1} клас',
                                onTap: () {
                                  BlocProvider.of<CatalogBloc>(context).add(
                                      ToggleKeyTempFilter(
                                          optionId: index + 1,
                                          key: 'class_id'
                                      ));
                                },
                              ),
                            );
                          })
                      : Container()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Предмет',
                          style: TextStyle(
                              fontSize: 21,
                              color: Color(0xFF2B2B2B),
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSubjectOpen = !isSubjectOpen;
                            });
                          },
                          borderRadius: BorderRadius.circular(40),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Transform.rotate(
                              angle: isSubjectOpen ? 0 : -pi / 2,
                              child: SizedBox(
                                width: 14,
                                height: 14,
                                child: SvgPicture.asset(
                                  'assets/icons/down_arrow.svg',
                                  color: Color(0xFF181725),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  isSubjectOpen
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (state as CatalogSuccess).subjectList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CustomCheckboxListTile(
                                text: state.subjectList[index].name,
                                isChecked: state.unconfirmedFilters.containsKey('subject_id') 
                                  ?  (state.unconfirmedFilters['subject_id'] as List<int>).contains(index + 1) 
                                  : false,
                                onTap: () {
                                  BlocProvider.of<CatalogBloc>(context).add(
                                      ToggleKeyTempFilter(
                                          optionId: state.subjectList[index].id,
                                          key: 'subject_id'
                                      ));
                                },
                              ),
                            );
                          })
                      : Container(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
