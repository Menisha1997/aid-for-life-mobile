import 'package:ambulance_app_v1/const/app_size_const.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({Key? key, required this.lable, required this.onPressed})
      : super(key: key);

  final String lable;
  final VoidCallback onPressed;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  //
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(40, 10),
        // maximumSize: const Size(80, 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.DEFAULT_RADIUS),
        ),
        elevation: 2.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          widget.lable,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class CustomMegaButton extends StatelessWidget {
  const CustomMegaButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.color,
      required this.labelColor})
      : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final Color color;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(300, 50),
          maximumSize: const Size(300, 50),
          primary: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          label,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: labelColor,
              ),
        ),
      ),
    );
  }
}
