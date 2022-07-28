import 'package:flutter/material.dart';

Widget Button(
  BuildContext context, {
  String str = "",
  String? routeName,
}) {
  return InkWell(
    onTap: () {
      if (routeName != null) {
        Navigator.pushNamed(context, routeName);
      }
    },
    child: Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(2),
      height: 50,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(str,
          style: TextStyle(
            color: Colors.white,
          )),
    ),
  );
}

Widget textInput({
  double? hgt,
  double? wgt,
  String? lbltxt,
  TextEditingController? textEditingController,
}) {
  if (hgt != null) {
    return Container(
      height: hgt,
      width: wgt,
      child: TextField(
        controller: textEditingController,
        style: TextStyle(
          fontSize: 14
        ),
        decoration: InputDecoration(
          labelText: lbltxt,
          border: OutlineInputBorder(),
        ),
      ),
    );
  } else {
    return Container(
      height: 50,
      width: 300,
      child: Expanded(
        child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Input Hare ...',
          ),
        ),
      ),
    );
  }
}

Widget text({String? str}) {
  if (str == null) {
    return Text("null");
  } else {
    return Text(str);
  }
}

Widget S({double height = 20, double width = 20}) {
  if (height == 20 && width == 20) {
    return const SizedBox(
      height: 20,
      width: 20,
    );
  } else {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
