
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
 
}

class _MyAppState extends State<MyApp> {
  int currentFloor = 1;
  final AudioPlayer audioPlayer = AudioPlayer();
  String elevatorStatus = 'Elevator is Idle';
  String doorStatus = 'Door is Closed';
  bool isDoorOpen = false;
  void goToFloor(int selectedFloor) {
 if (isDoorOpen) {
    debugPrint('Please Close the door first');
    return;
  }

  if (selectedFloor == currentFloor) {
    elevatorStatus = 'Elevator is Idle';
    return;
  }

  setState(() {

    if (selectedFloor > currentFloor) {
      elevatorStatus = 'Elevator is Moving Up';
    } else {
      elevatorStatus = 'Elevator is Moving Down';
    }

  });

  Future.delayed(const Duration(seconds: 2), () async {

    setState(() {
      currentFloor = selectedFloor;
      elevatorStatus = 'Elevator is Idle';
    });
    await audioPlayer.setVolume(1.0);


   await audioPlayer.play(
  AssetSource('sounds/mitsubishi_arrival_chime.mp3'),
);

    debugPrint('Elevator arrived at Floor $selectedFloor');

  });

}
//////////////////////////////////Open Door Function////////////////////////
  void openDoor() {
    if (elevatorStatus != 'Elevator is Idle') {
    debugPrint('Elevator is moving. Cannot open door!');
    return;
  }
    setState(() {
      doorStatus = 'Door is Open';
      isDoorOpen = true;
    });
  }
///////////////////////////////Close Door Function///////////////////////////

void closeDoor(){
  setState(() {
    doorStatus = 'Door is Closed';
    isDoorOpen = false;
  });
}

///////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0B1420),

        appBar: AppBar(
          title: const Text('Elevator App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          ),
          backgroundColor: const Color(0xFF111F30),
          centerTitle: true,
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
Container(
  width: double.infinity,
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: const Color(0xFF111F30),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: const Color(0xFF00BFFF),
      width: 1.5,
    ),
  ),

  child: Column(
    children: [

      Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    const Text(
      'CURRENT FLOOR',
      style: TextStyle(
        fontSize: 18,
        color: Colors.white70,
        fontWeight: FontWeight.bold,
      ),
    ),

    const SizedBox(width: 15),

    Container(
      width: 55,
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF00BFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$currentFloor',
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),

  ],
),

      const SizedBox(height: 10),

      Text(
        elevatorStatus,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
const SizedBox(height: 10),
////////////////////Door Status //////////////////////////////////
Text(
  doorStatus,
  style: const TextStyle(
    fontSize: 16,
    color: Color(0xFF00BFFF),
    fontWeight: FontWeight.bold,
  ),
),

    ],
  ),
),
const SizedBox(height: 15),
//////////////////////Lammps////////////////////////////

Container(
  width: 22,
  height: 22,
  decoration: BoxDecoration(
    color: isDoorOpen
        ? Colors.green
        : Colors.red,
    shape: BoxShape.circle,

    boxShadow: [
      BoxShadow(
        color: isDoorOpen
            ? Colors.green
            : Colors.red,
        blurRadius: 12,
        spreadRadius: 2,
      ),
    ],
  ),
),
const SizedBox(height: 10),

AnimatedContainer(
  duration: const Duration(milliseconds: 700),
  width: isDoorOpen ?  200:180,
  height: 90,
  decoration: BoxDecoration(
    color: const Color(0xFF111F30),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: const Color(0xFF00BFFF),
      width: 2,
    ),
  ),

  child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

    AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      width: isDoorOpen ? 96:86,
      height: 90,
      alignment: isDoorOpen
      ? Alignment.centerLeft
      : Alignment.center,

  child: AnimatedContainer(
    duration: const Duration(milliseconds: 700),
    width: isDoorOpen ? 35 : 88,
    height: 120,
    color: const Color(0xFF526779),
  ),
),

    AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      width: isDoorOpen ? 96:86,
      height: 90,
      alignment: isDoorOpen
      ? Alignment.centerRight
      : Alignment.center,

  child: AnimatedContainer(
    duration: const Duration(milliseconds: 700),
    width: isDoorOpen ? 35 : 88,
    height: 120,
    color: const Color(0xFF526779),
  
  ),
),
  ],
  ),
),

  const SizedBox(height: 15),

         
            


         //////////////////////////////Buttons///////////////////////////////    
GridView.count(
  crossAxisCount: 3,
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  childAspectRatio: 1.8,
  children: [
    ElevatedButton(
      onPressed: () {
        goToFloor(1);
        debugPrint('Floor 1 selected');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: currentFloor == 1
        ? const Color(0xFF00BFFF)
        : const Color(0xFF111F30),
        foregroundColor: Colors.white,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  child: const Text(
    '1',
    style: TextStyle(
      fontSize: 22,
    ),
  ),
),
///////////////////////2/////////////////////////////////////////////

  

   ElevatedButton(
    onPressed: () {
      goToFloor(2);
      debugPrint('Floor 2 selected');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: currentFloor == 2
          ? const Color(0xFF00BFFF)
          : const Color(0xFF111F30),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: const Text('2', style: TextStyle(fontSize: 22)),
  ),

    ElevatedButton(
    onPressed: () {
      goToFloor(3);
      debugPrint('Floor 3 selected');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: currentFloor == 3
          ? const Color(0xFF00BFFF)
          : const Color(0xFF111F30),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: const Text('3', style: TextStyle(fontSize: 22)),
  ),

    ElevatedButton(
    onPressed: () {
      goToFloor(4);
      debugPrint('Floor 4 selected');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: currentFloor == 4
          ? const Color(0xFF00BFFF)
          : const Color(0xFF111F30),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: const Text('4', style: TextStyle(fontSize: 22)),
  ),

    ElevatedButton(
    onPressed: () {
      goToFloor(5);
      debugPrint('Floor 5 selected');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: currentFloor == 5
          ? const Color(0xFF00BFFF)
          : const Color(0xFF111F30),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: const Text('5', style: TextStyle(fontSize: 22)),
  ),

    ElevatedButton(
    onPressed: () {
      goToFloor(6);
      debugPrint('Floor 6 selected');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: currentFloor == 6
          ? const Color(0xFF00BFFF)
          : const Color(0xFF111F30),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
child: const Text('6', style: TextStyle(fontSize: 22)),
  ),
    ElevatedButton(
    onPressed: () {
      goToFloor(7);
      debugPrint('Floor 7 selected');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: currentFloor == 7
          ? const Color(0xFF00BFFF)
          : const Color(0xFF111F30),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: const Text('7', style: TextStyle(fontSize: 22)),
  ),
    ElevatedButton(
    onPressed: () {
      goToFloor(8);
      debugPrint('Floor 8 selected');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: currentFloor == 8
          ? const Color(0xFF00BFFF)
          : const Color(0xFF111F30),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: const Text('8', style: TextStyle(fontSize: 22)),
  ),

    ElevatedButton(
    onPressed: () {
      goToFloor(9);
      debugPrint('Floor 9 selected');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: currentFloor == 9
          ? const Color(0xFF00BFFF)
          : const Color(0xFF111F30),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: const Text('9', style: TextStyle(fontSize: 22)),
  ),
    const SizedBox(),

  ElevatedButton(
    onPressed: () {
      goToFloor(0);
      debugPrint('Ground Floor selected');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: currentFloor == 0
          ? const Color(0xFF00BFFF)
          : const Color(0xFF111F30),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: const Text('G', style: TextStyle(fontSize: 22)),
  ),

  const SizedBox(),
],),
const SizedBox(height: 20),
///////////////////Dooors /////////////////////////////////
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ElevatedButton.icon(
      onPressed: openDoor,
      icon: const Icon(Icons.door_front_door),
      label: const Text('OPEN'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF111F30),
        foregroundColor: const Color(0xFF00BFFF),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: Color(0xFF00BFFF),
          ),
        ),
      ),
    ),
//////////////Close Code///////////////
///
const SizedBox(width: 20),
    ElevatedButton.icon(
      onPressed: closeDoor,
      icon: const Icon(Icons.door_sliding),
      label: const Text('CLOSE'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF111F30),
        foregroundColor: const Color(0xFF00BFFF),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: Color(0xFF00BFFF),
          ),
        ),
      ),
    ),

  ],
), // Column 
  ], //  Column
), // Column
), // Center // SingleChildScrollView
), // Scaffold
); 
  }
}