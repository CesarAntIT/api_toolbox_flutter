import 'package:flutter/material.dart';

class SingleFieldForm extends StatelessWidget {
  const SingleFieldForm({
    super.key,
    required this.label,
    required this.inputController,
    required this.b1Text,
    required this.b2Text,
    required this.onBtn1Press,
    required this.onBtn2Press
  });

  final String label;
  final TextEditingController inputController;
  final String b1Text;
  final String b2Text;
  final ValueChanged<String> onBtn1Press;
  final VoidCallback onBtn2Press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        margin: EdgeInsets.all(6),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 16)),
              TextField(
                keyboardType: TextInputType.name,
                controller: inputController,
                onSubmitted: onBtn1Press,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => onBtn1Press(inputController.text),
                    label: Text(b1Text),
                    icon: Icon(Icons.search),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: onBtn2Press,
                    label: Text(b2Text),
                    icon: Icon(Icons.clear_all),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
