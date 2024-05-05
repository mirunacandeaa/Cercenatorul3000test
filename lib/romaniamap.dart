import 'package:flutter/material.dart';
import 'package:countries_world_map/countries_world_map.dart';
import 'Theme/colors.dart';

class SimpleMapExample extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;

  SimpleMapExample({required this.onSelectionChanged});

  @override
  _SimpleMapExampleState createState() => _SimpleMapExampleState();
}

class _SimpleMapExampleState extends State<SimpleMapExample> {
  Map<String, Color> regionColors = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.skin,
      child: SimpleMap(
        instructions: SMapRomania.instructions,
        defaultColor: Colors.grey,
        colors: SMapRomaniaColors(
          roAB: regionColors['RO-AB'] ?? Colors.grey,
          roSB: regionColors['RO-SB'] ?? Colors.grey,
          roAG: regionColors['RO-AG'] ?? Colors.grey,
          roAR: regionColors['RO-AR'] ?? Colors.grey,
          roB: regionColors['RO-B'] ?? Colors.grey,
          roBC: regionColors['RO-BC'] ?? Colors.grey,
          roBH: regionColors['RO-BH'] ?? Colors.grey,
          roBN: regionColors['RO-BN'] ?? Colors.grey,
          roBR: regionColors['RO-BR'] ?? Colors.grey,
          roBT: regionColors['RO-BT'] ?? Colors.grey,
          roBV: regionColors['RO-BV'] ?? Colors.grey,
          roBZ: regionColors['RO-BZ'] ?? Colors.grey,
          roCJ: regionColors['RO-CJ'] ?? Colors.grey,
          roCL: regionColors['RO-CL'] ?? Colors.grey,
          roCS: regionColors['RO-CS'] ?? Colors.grey,
          roCT: regionColors['RO-CT'] ?? Colors.grey,
          roCV: regionColors['RO-CV'] ?? Colors.grey,
          roDB: regionColors['RO-DB'] ?? Colors.grey,
          roDJ: regionColors['RO-DJ'] ?? Colors.grey,
          roGJ: regionColors['RO-GJ'] ?? Colors.grey,
          roGL: regionColors['RO-GL'] ?? Colors.grey,
          roGR: regionColors['RO-GR'] ?? Colors.grey,
          roHD: regionColors['RO-HD'] ?? Colors.grey,
          roHR: regionColors['RO-HR'] ?? Colors.grey,
          roIF: regionColors['RO-IF'] ?? Colors.grey,
          roIL: regionColors['RO-IL'] ?? Colors.grey,
          roIS: regionColors['RO-IS'] ?? Colors.grey,
          roMH: regionColors['RO-MH'] ?? Colors.grey,
          roMM: regionColors['RO-MM'] ?? Colors.grey,
          roMS: regionColors['RO-MS'] ?? Colors.grey,
          roNT: regionColors['RO-NT'] ?? Colors.grey,
          roOT: regionColors['RO-OT'] ?? Colors.grey,
          roPH: regionColors['RO-PH'] ?? Colors.grey,
          roSJ: regionColors['RO-SJ'] ?? Colors.grey,
          roSM: regionColors['RO-SM'] ?? Colors.grey,
          roSV: regionColors['RO-SV'] ?? Colors.grey,
          roTL: regionColors['RO-TL'] ?? Colors.grey,
          roTM: regionColors['RO-TM'] ?? Colors.grey,
          roTR: regionColors['RO-TR'] ?? Colors.grey,
          roVL: regionColors['RO-VL'] ?? Colors.grey,
          roVN: regionColors['RO-VN'] ?? Colors.grey,
          roVS: regionColors['RO-VS'] ?? Colors.grey,
        ).toMap(),
        callback: (id, name, tapdetails) {
          setState(() {
            regionColors.update(id, (value) => AppColors.pink, ifAbsent: () => AppColors.pink);
          });

          List<String> selectedJudete = [];

          regionColors.forEach((key, value) {
            if (value == AppColors.pink) {
              selectedJudete.add(key);
            }
          });

          widget.onSelectionChanged(selectedJudete);
        },
      ),
    );
  }
}
