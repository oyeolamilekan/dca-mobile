import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/app_config.dart';

class MoveCashDropdownMenu extends StatelessWidget {
  final String? title;
  final String? placeHolder;
  final String? value;
  final Function? onChange;
  final Function? validator;
  final List<Map<String, dynamic>> itemList;
  final String icon;
  final String? prefixIcon;
  final num? marginTop;

  const MoveCashDropdownMenu({
    Key? key,
    this.title,
    required this.itemList,
    this.value,
    this.onChange,
    this.placeHolder,
    this.validator,
    this.icon = "assets/svg/dropdownIcon.svg",
    this.prefixIcon,
    this.marginTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null ? Text(title ?? "") : const SizedBox.shrink(),
        SizedBox(
          height: marginTop as double? ?? 0,
        ),
        DropdownButtonFormField<String>(
          hint: Text(placeHolder ?? ""),
          elevation: 0,
          isExpanded: true,
          icon: SvgPicture.asset(icon),
          value: value,
          onChanged: (value) => onChange!(value),
          items: itemList.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(
              value: value['value'] as String,
              child: Text(value['name'] as String),
            );
          }).toList(),
          validator: (String? value) => validator!(value) as String?,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppConfigService.hexToColor("#494FB1"),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppConfigService.hexToColor("#E0E0E0"),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
