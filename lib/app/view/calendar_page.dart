import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  TextEditingController subjectController = TextEditingController();
  TextEditingController startTimeController =
      TextEditingController(text: '00:00');
  TextEditingController endTimeController =
      TextEditingController(text: '00:00');
  TextEditingController noteController = TextEditingController();

   
  DateTime selectedDate = DateTime.now();

  
  List<Map<String, String>> todoList = [
    {'task': 'Jogging', 'start': '09:00 AM', 'end': '09:30 AM'},
    {'task': 'Jogging', 'start': '09:00 AM', 'end': '09:30 AM'},
  ];

  @override
  Widget build(BuildContext context) {
      
    final Color backgroundColor = const Color(0xFFEAF2F8);
    final Color mainBlue = const Color(0xFF377DFF);
    final Color purple = const Color(0xFF6B46C1);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: mainBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.arrow_back, color: mainBlue, size: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Your calendar',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            _buildCalendarSection(mainBlue),
            const SizedBox(height: 30),

              
            _buildInputFields(mainBlue),
            const SizedBox(height: 30),

              
            _buildTodoList(mainBlue),
            const SizedBox(height: 30),

              
            _buildNoteSection(purple),
            const SizedBox(height: 40),

          
            _buildSaveButton(mainBlue),
          ],
        ),
      ),
    );
  }

  
  Widget _buildCalendarSection(Color mainBlue) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'January',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),

        
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                .map((day) => Text(
                      day,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 15),

         
          _buildCalendarDays(mainBlue),
        ],
      ),
    );
  }

  
  Widget _buildCalendarDays(Color mainBlue) {
    List<Widget> days = [];
    int daysInMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
    int firstDayOfWeek =
        DateTime(selectedDate.year, selectedDate.month, 1).weekday;

       
    for (int i = 1; i < firstDayOfWeek; i++) {
      days.add(SizedBox(width: 40, height: 40));
    }

    
    for (int day = 1; day <= daysInMonth; day++) {
      bool isSelected = day == selectedDate.day;
      days.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDate =
                  DateTime(selectedDate.year, selectedDate.month, day);
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected ? mainBlue : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: days,
    );
  }

    
  Widget _buildInputFields(Color mainBlue) {
    return Column(
      children: [
          
        TextField(
          controller: subjectController,
          decoration: InputDecoration(
            hintText: 'Subject',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
        const SizedBox(height: 15),

          
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: startTimeController,
                decoration: InputDecoration(
                  hintText: '00:00',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: TextField(
                controller: endTimeController,
                decoration: InputDecoration(
                  hintText: '00:00',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

 
  Widget _buildTodoList(Color mainBlue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ToDo List',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 15),
        ...todoList
            .map((todo) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          todo['task']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: mainBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          todo['start']!,
                          style: TextStyle(
                            color: mainBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: mainBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          todo['end']!,
                          style: TextStyle(
                            color: mainBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            ,
      ],
    );
  }

    
  Widget _buildNoteSection(Color purple) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NOTE',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: purple,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: noteController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'What you thinking ?',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(20),
              suffixIcon: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: purple.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.keyboard_arrow_down, color: purple),
              ),
            ),
          ),
        ),
      ],
    );
  }

   
  Widget _buildSaveButton(Color mainBlue) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          _saveCalendar();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: mainBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

   
  void _saveCalendar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('calendar saved successfully'),
        backgroundColor: Color(0xFF377DFF),
      ),
    );
  }
}
