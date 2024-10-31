import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SelectYearView extends StatefulWidget {
  const SelectYearView({super.key, required this.currentYearSelected});

  final String currentYearSelected;

  @override
  State<SelectYearView> createState() => _SelectYearViewState();
}

class _SelectYearViewState extends State<SelectYearView> {
  final List<int> years = List.generate(DateTime.now().year - 2007, (index) => DateTime.now().year - index);
  final ScrollController _scrollController = ScrollController();

  int? selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = int.parse(widget.currentYearSelected);

    final selectedIndex = years.indexOf(selectedYear!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(selectedIndex * 26);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, size: 32),
          onPressed: () => Get.back(result: selectedYear.toString()),
        ),
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
            child: Container(
              color: selectedYear == year ? Colors.red : Colors.transparent,
              child: ListTile(
                title: Text(
                  year.toString(),
                  style: TextStyle(
                    fontFamily: "Formula1",
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: selectedYear == year ? Colors.white : Colors.black,
                  ),
                ),
                trailing: selectedYear == year ? const Icon(Icons.check, color: Colors.white, size: 26) : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
