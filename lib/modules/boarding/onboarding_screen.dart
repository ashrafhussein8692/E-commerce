
import 'package:e_commerce/modules/login/login_screen.dart';
import 'package:e_commerce/network/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../components.dart';

class BoardingModel {
  String title;
  String image;
  String body;

  BoardingModel(this.title, this.image, this.body);
}

class OnBoardingScreen extends StatelessWidget {
  List<BoardingModel> model = [
    BoardingModel('Welcome to E-Mart', 'image/boarding1.jpg',
        "The world's largest shopping and travel community"),
    BoardingModel('Welcome to E-Mart', 'image/boarding1.jpg',
        "The world's largest shopping and travel community"),
    BoardingModel('Welcome to E-Mart', 'image/boarding1.jpg',
        "The world's largest shopping and travel community"),
  ];
  var pageController = PageController();
  void submit( context){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){

       navigatAndFinish(context, LoginScreen());
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
         defaultTextButton(function: (){
           submit(context);
           // navigatAndFinish(context, LoginScreen());
         }, text: ('skip'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildOnBoarding(model[index]),
                itemCount: model.length,
                controller: pageController,
              ),

            ),
            const SizedBox(
              height: 20,
            ),
            SmoothPageIndicator(
                controller: pageController,
                count: model.length,
                effect: WormEffect(
                    dotColor: Colors.blue.shade100,
                    activeDotColor: Colors.blue
                )

            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,

              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(8))

              ),
              child: MaterialButton(
                  onPressed: () {
                 // navigatAndFinish(context, LoginScreen());
                   submit(context);
                  },
                  child: const Text('Continue',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white
                  ),
                  )),
            )
          ],
        ),
      ),


    );
  }

  Widget buildOnBoarding(BoardingModel model) =>
      Column(

        children: [
          Image(
            image: AssetImage(
              model.image,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              model.title,
              style: const TextStyle(fontSize: 20,

              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Text(

              model.body,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20,

              ),
            ),
          ),
        ],
      );
}
