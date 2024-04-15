import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mt_activity_management/components/BottomNavBar.dart';
import 'package:mt_activity_management/components/addProgramDialog.dart';
import 'package:mt_activity_management/components/programCard.dart';
import 'package:mt_activity_management/model/program.dart';
import 'package:mt_activity_management/pages/loading.dart';
import 'package:mt_activity_management/utilities/utils.dart';

class Programs extends StatefulWidget {
  const Programs({super.key});

  @override
  State<Programs> createState() => _ProgramsState();
}

class _ProgramsState extends State<Programs> {
  bool isLoading = true;
  int selectedIndex = 0;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth = DateTime(3);
  late DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
  var currentDate = DateTime.now();
  List<Program> listPrograms = [];
  List<bool> selectedToggle = <bool>[false, true];
  int selectedToggleIndex = -1;

  @override
  void initState() {
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    isLoading = false;
    setState(() {
      Utils.getPrograms(firstDayOfMonth).then((value) => listPrograms = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final monthName = DateFormat('MMMM').format(lastDayOfMonth);

    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: const Color(0xFF424242),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          backgroundColor: const Color(0xFF757575),
          toolbarHeight: 162.0,
          title: Column(
            children: [
              Text(
                monthName,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Raleway",
                ),
              ),
              const SizedBox(height: 4.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: Row(
                  children: List.generate(
                    lastDayOfMonth.day,
                    (index) {
                      currentDate = firstDayOfMonth.add(Duration(days: index));
                      final dayName = DateFormat('E').format(currentDate);
                      return Padding(
                        padding: EdgeInsets.only(
                            left: index == 0 ? 16.0 : 0.0, right: 16.0),
                        child: GestureDetector(
                          onTap: () async {
                            selectedIndex = index;
                            currentDate = firstDayOfMonth
                                .add(Duration(days: selectedIndex));
                            listPrograms = await Utils.getPrograms(currentDate);

                            setState(() {
                              selectedToggle = <bool>[false, true];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? const Color(0xFFF89A1C)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(44.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 39.0,
                                  width: 57.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                    dayName.substring(0, 2),
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? Colors.black
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(44.0),
                                  ),
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
            child: Center(
              child: SizedBox(
                width: 360,
                child: isLoading
                    ? const Loading()
                    : Center(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      listPrograms.isNotEmpty
                                          ? "Daily programs"
                                          : "No activities for\n this day",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Raleway")),

                                  Container(
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                                      border: Border.all(color: const Color(0xFFF89A1C), width: 1.0),
                                    ),
                                    child: ToggleButtons(
                                      direction: Axis.horizontal,
                                      onPressed: (int index) async{
                                        selectedToggleIndex = index;
                                        bool private = false;
                                        for (int i = 0; i < selectedToggle.length; i++) {
                                          selectedToggle[i] = i == index;
                                          private = i == index;
                                        }
                                        currentDate = firstDayOfMonth
                                            .add(Duration(days: selectedIndex));
                                        listPrograms = await Utils.getPrograms(currentDate, private: private);

                                        setState(() {

                                        });
                                      },
                                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                                      selectedColor: Colors.white,
                                      fillColor: const Color(0xFFF89A1C),
                                      color: const Color(0xFF757575),
                                      isSelected: selectedToggle,
                                      children: const [Text("All", style: TextStyle(fontFamily: "Raleway"),), Text("My", style: TextStyle(fontFamily: "Raleway"))],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              RefreshIndicator(
                                color: Colors.white,
                                backgroundColor: const Color(0xFFF89A1C),
                                onRefresh: () async {
                                  bool private = false;
                                  for (int i = 0; i < selectedToggle.length; i++) {
                                    selectedToggle[i] = i == selectedToggleIndex;
                                    private = i == selectedToggleIndex;
                                  }
                                  currentDate = firstDayOfMonth
                                      .add(Duration(days: selectedIndex));
                                  listPrograms = await Utils.getPrograms(currentDate, private: private);

                                  setState(() {

                                  });

                                  return Future<void>.delayed(const Duration(seconds: 1));
                                },

                                child: Container(
                                  child: ListView.builder(
                                    itemCount: listPrograms.length,
                                    shrinkWrap: true,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 10.0),
                                        child:
                                            ProgramCard(program: listPrograms[index]),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),

        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                useRootNavigator: false,
                builder: (BuildContext context) {
                  return const AddProgramDialog();
                });
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 4,
              color: Color(0xFF757575),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          label: const Text(
            "Add",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Raleway"),
          ),
          backgroundColor: const Color(0xFFF89A1C),
        ),
        bottomNavigationBar: const BottomNavBar(
          currentIndex: 0,
        ),
      ),
    );
  }
}
