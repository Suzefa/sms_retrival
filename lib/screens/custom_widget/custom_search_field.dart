import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CustomSearchField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Search: ",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
        Expanded(
          child: TextField(
            onChanged: (text){
              if(onChanged!=null){
                onChanged!(text);
              }
            },
            controller: controller,
            cursorColor: Colors.black26,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              counterText: "",
              hintText: "Search Message",
              counterStyle: TextStyle(
                color: Colors.black,
              ),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.black26,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.black26,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
