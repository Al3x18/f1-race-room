import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:race_room/utils/app_colors.dart';

class SelectYearView extends StatefulWidget {
  const SelectYearView({super.key, required this.currentYearSelected});

  final String currentYearSelected;

  @override
  State<SelectYearView> createState() => _SelectYearViewState();
}

class _SelectYearViewState extends State<SelectYearView> {
  final List<int> years = List.generate(DateTime.now().year - 2005, (index) => DateTime.now().year - index);
  final ScrollController _scrollController = ScrollController();

  int? selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = int.parse(widget.currentYearSelected);

    // Add next year if December 15th or later
    // final currentDate = DateTime.now();
    // if (currentDate.month == 12 && currentDate.day > 15) {
    //   years.insert(0, currentDate.year + 1);
    // }

    final selectedIndex = years.indexOf(selectedYear!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(selectedIndex * 26);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: TextButton(
              onPressed: () => Get.back(result: selectedYear.toString()),
              child: const Text("Done", style: TextStyle(color: AppColors.selectYearAppBarButton, fontWeight: FontWeight.w700, fontSize: 13.5)),
            ),
          ),
        ],
        title: const Text("Select Year", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.5)),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedYear = year;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: selectedYear == year ? AppColors.selectYearDecorationColorYearSelected : AppColors.selectYearDecorationColorYearNotSelected,
                ),
                child: ListTile(
                  dense: true,
                  title: Text(
                    year.toString(),
                    style: TextStyle(
                      fontFamily: "Formula1",
                      fontSize: 15.8,
                      fontWeight: FontWeight.w600,
                      color: selectedYear == year
                          ? AppColors.selectYearTextYearSelected
                          : Get.isDarkMode
                              ? AppColors.selectYearTextYearNotSelectedDark
                              : AppColors.selectYearTextYearNotSelectedLight,
                    ),
                  ),
                  trailing: selectedYear == year ? const Icon(Icons.check, color: AppColors.selectedYearTrailingIcon, size: 26) : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
