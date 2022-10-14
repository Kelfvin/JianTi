import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color? color;
  final String? text;
  final double? radius;
  final double? fontsize;
  final void Function()? onPressed;
  const MyButton(
      {Key? key,
      this.text,
      this.radius,
      this.fontsize,
      this.onPressed,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
          //  color: color
        ),
        clipBehavior: Clip.antiAlias,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(color),
              elevation: MaterialStateProperty.all(0),
              minimumSize: MaterialStateProperty.all(Size.zero)),
          onPressed: onPressed,
          child: Text(
            text ?? "",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: fontsize),
          ),
        ),
      ),
    );
  }
}

class MyOptionWidget extends StatelessWidget {
  final Color? color;
  final String text;
  final double? fontsize;
  final void Function()? onPressed;

  /// 选项的标志：A、B、C、D
  final String mark;

  const MyOptionWidget(
      {super.key,
      this.color,
      required this.text,
      this.fontsize,
      this.onPressed,
      required this.mark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(42),
                ),
                child: CircleAvatar(
                  backgroundColor: color,
                  child: Text(mark),
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: fontsize),
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
    );
  }
}
