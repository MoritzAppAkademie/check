import 'package:flutter/material.dart';
import '../helper/itemService.dart';

class ListScreen extends StatefulWidget {
  final Function(int) updateItemCount; // Neuer benannter Parameter

  ListScreen({required this.updateItemCount}); // Initialisiert den Parameter

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late ItemService _itemService;
  List<String> _items = [];
  bool isLoading = true; // Neu: Ladezustand
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _itemService = ItemService(onUpdate: (items) {
      setState(() {
        _items = items;
        isLoading = false; // Ladezustand beenden, wenn die Daten geladen sind
        widget.updateItemCount(
            _items.length); // Aktualisiert die Anzahl der Aufgaben
      });
    });
    _itemService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meine Checkliste'),
      ),
      body: isLoading
          ? Center(child: SizedBox()) // Ladeindikator anzeigen
          : Column(
              children: [
                Expanded(
                  child:
                      _items.isEmpty ? _buildEmptyContent() : _buildItemList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Task Hinzufügen',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            _itemService.addItem(_controller.text);
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _itemService.addItem(value);
                        _controller.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildItemList() {
    return ListView.separated(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return Container(
          child: ListTile(
            title: Text(_items[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _itemService.startEditItem(index, context),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _itemService.deleteItem(index),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
        color: Colors.white10,
      ),
    );
  }

  Widget _buildEmptyContent() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.sentiment_satisfied_alt, size: 64),
          SizedBox(height: 10),
          Text('Alle Aufgaben erledigt'),
        ],
      ),
    );
  }
}
