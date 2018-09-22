import 'package:dgsw_sns/model/member.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double _size;
  final Member _member;

  ProfileImage(double size, Member member):
      _size = size, _member = member;

  final List<Color> _notRead = [
    Color.fromARGB(0xFF, 0xFC, 0xA5, 0x49),
    Color.fromARGB(0xFF, 0xBF, 0x08, 0x85)
  ];

  List<Color> _getGradientColorByStory() {
    return _notRead;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: new LinearGradient(
          colors: _getGradientColorByStory(),
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(1.5),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.0),
          ),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color.fromARGB(0xFF, 0xC6, 0xC6, 0xC6), width: 0.5),
                color: Colors.white,
                image: DecorationImage(
                  image: Image.network(_member.profileImage).image,
                  fit: BoxFit.fill,
                )
            ),
          )
        ),
      ),
    );
  }
}
