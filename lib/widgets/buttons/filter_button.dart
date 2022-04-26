import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterButton extends StatelessWidget{
  const FilterButton({Key? key, required this.onTap}) : super(key: key);

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/filter.svg', width: 14, height: 14,),
              const Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Text('Фільтр', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
              )
            ],
          ),
        )
      ),
    );
  }
  
}