import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageUploader extends StatelessWidget{
  const ImageUploader({super.key, required this.onPressed, required this.images});

  final Function() onPressed;
  final List<Uint8List> images;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
                      child: IconButton(
                          onPressed: () => onPressed(),
                          icon: Icon(Icons.add_a_photo)),
                    ),
                  ),
                  ... images.map((e) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(image: MemoryImage(e), fit: BoxFit.cover),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}