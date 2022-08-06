import 'package:flutter/material.dart';

Widget Button(
  BuildContext context, {
  String str = "",
  String? routeName,
  GestureTapCallback? onTap,
}) {
  return InkWell(
    onTap: () {
      if (routeName != null) {
        Navigator.pushNamed(context, routeName);
      }
      onTap!.call();
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
  TextEditingController? editcntrl,
}) {
  if (hgt != null) {
    return Container(
      height: hgt,
      width: wgt,
      child: TextField(
        controller: editcntrl,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          // suffixIcon: IconButton(
          //   icon: Icon(Icons.edit),
          //   onPressed: (){},
          // ),
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
          controller: editcntrl,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Input here ',
            labelStyle: TextStyle(
              fontSize: 13
            )
          ),
        ),
      ),
    );
  }
}

Widget text({
  String? str,
  double? size = 12,
  Color clr = Colors.black,
  bool edit = false,
  final VoidCallback? onPresd,
}) {
  if (str == null) {
    return Text("null");
  } else {
    return Row(
      children: [
        Text(
          str,
          style: TextStyle(fontSize: size, color: clr),
        ),
        Expanded(
          child: S(),
        ),
        if (edit)
          IconButton(
              onPressed: () {
                if (onPresd != null) {
                  onPresd.call();
                }
              },
              icon: Icon(
                Icons.edit,
                color: Colors.blueAccent,
                size: 24,
              ))
      ],
    );
  }
}

Widget ListOfText({
  bool herizonatal = true,
  List<Widget> listOfWidget = const <Widget>[],
}) {
  if (herizonatal) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listOfWidget,
    );
  } else {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listOfWidget,
    );
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
Widget txtbtn({
  String? str,
  double? size = 14,
  Color clr = Colors.black,
}) {
  if (str == null) {
    return Text("null");
  } else {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      child: Text(
        str,
        style: TextStyle(fontSize: size, color: clr),
      ),
    );
  }
}
