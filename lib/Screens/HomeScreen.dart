import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'listScreen.dart';
import "CounterScreen.dart";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex =
      0; // Hält den aktuellen Index der ausgewählten Registerkarte
  int _taskCount = 0; // Hält die aktuelle Anzahl der Aufgaben
  List<Widget> _widgetOptions =
      []; // Liste der Widgets, die basierend auf der ausgewählten Registerkarte angezeigt werden

  @override
  void initState() {
    super.initState();
    _loadItemCount(); // Lädt die Anzahl der Aufgaben beim Start des Widgets
  }

  // Lädt die Anzahl der Aufgaben aus SharedPreferences
  void _loadItemCount() async {
    final prefs = await SharedPreferences.getInstance();
    final itemCount = prefs.getInt('itemCount') ??
        0; // Lese die Anzahl der Aufgaben oder setze sie auf 0, wenn sie nicht existiert
    setState(() {
      _taskCount = itemCount; // Aktualisiere den taskCount
      _widgetOptions = [
        ListScreen(
            updateItemCount: _updateItemCount), // Erster Tab: Aufgabenliste
        CounterScreen(
            taskCount:
                _taskCount), // Zweiter Tab: Statistik, zeigt die Anzahl der Aufgaben
      ];
    });
  }

  // Aktualisiert die Anzahl der Aufgaben und speichert sie in SharedPreferences
  void _updateItemCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'itemCount', count); // Speichere die aktualisierte Anzahl der Aufgaben
    setState(() {
      _taskCount = count; // Aktualisiere den taskCount
      _widgetOptions[1] = CounterScreen(
          taskCount: _taskCount); // Aktualisiere das CounterScreen-Widget
    });
  }

  // Wird aufgerufen, wenn der Benutzer eine Registerkarte auswählt
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Aktualisiere den ausgewählten Index
    });
  }

  @override
  Widget build(BuildContext context) {
    // Wenn _widgetOptions leer ist (z. B. während des Ladens), zeige einen Ladeindikator
    if (_widgetOptions.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Zeigt einen Ladeindikator an
        ),
      );
    }

    // Baue die Hauptschnittstelle mit einem Scaffold
    return Scaffold(
      body: _widgetOptions.elementAt(
          _selectedIndex), // Zeigt das ausgewählte Widget basierend auf dem aktuellen Index an
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list), // Symbol für die Aufgabenliste
            label: 'Aufgaben', // Beschriftung für die Aufgabenliste
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart), // Symbol für die Statistik
            label: 'Statistik', // Beschriftung für die Statistik
          ),
        ],
        currentIndex: _selectedIndex, // Der aktuell ausgewählte Index
        selectedItemColor:
            Colors.deepPurple[200], // Farbe des ausgewählten Elements
        onTap:
            _onItemTapped, // Callback, wenn eine Registerkarte ausgewählt wird
      ),
    );
  }
}
