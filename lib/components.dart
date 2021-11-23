import 'package:flutter/material.dart';


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
   Function()? onSubmit,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: (value){
        onSubmit!();
      }
      ,
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 20),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {},
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultButton(
        {required String text,
        required Function() function,
        Color background = Colors.blue,
        double width = double.infinity,
        double radius = 4.0,
        bool isUpperCase = true}) =>
    Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );

Widget defaultTextButton({required Function() function, required String text}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));

 void navigatTo(context, widget)=>
     Navigator.push(
         context,
         MaterialPageRoute(
             builder: (context) =>
                 widget));
 void navigatAndFinish( context,  widget)=>
     Navigator.pushAndRemoveUntil(context,
         MaterialPageRoute(builder: (context) =>  widget), (
             route) => false);
