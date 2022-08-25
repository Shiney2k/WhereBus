import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wherebus/tools/get_bus_controller.dart';
import 'package:wherebus/tools/get_bus_json_model.dart'
    as getBusJsonModelPackage;
import 'package:wherebus/tools/get_user_json_model.dart';
import 'package:wherebus/widgets/big_text.dart';
// import 'package:wherebus/widgets/refresh_list_widget.dart';
import 'package:wherebus/widgets/small_text.dart';

class BusItemCards extends StatefulWidget {
  const BusItemCards({Key? key, required this.data}) : super(key: key);
  final GetUserJsonModel data;

  @override
  State<BusItemCards> createState() => _BusItemCardsState();
}

class _BusItemCardsState extends State<BusItemCards> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = 300;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });

    Get.lazyPut(() => GetBusController(email: widget.data.document.email!));
    Get.find<GetBusController>().getBusesList();
    print('Got data to bus item cards');
    print(widget.data.document.email);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // Future loadList() async {
  //   Get.find<GetBusController>().getBusesList();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<GetBusController>(
          builder: (getBusController) {
            return getBusController.isLoaded
                ? Container(
                    // color: Colors.deepOrange,
                    height: 200,
                    child: PageView.builder(
                        controller: pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: getBusController.allBusesList.length,
                        itemBuilder: (context, position) {
                          return _buildPageItem(position,
                              getBusController.allBusesList[position]);
                        }))
                : Container(
                    height: 200,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
          }
        ),
        const SizedBox(
          height: 14,
        ),
        GetBuilder<GetBusController>(builder: (getBusController) {
          return DotsIndicator(
            dotsCount: getBusController.allBusesList.isEmpty
                ? 1
                : getBusController.allBusesList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                activeColor: Colors.blue),
          );
        }),
        const SizedBox(height: 30)
      ],
    );
  }

  Widget _buildPageItem(int index, getBusJsonModelPackage.Document busItem) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 1);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 1);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 1);
    } else {
      matrix = Matrix4.diagonal3Values(1, _scaleFactor, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    if (busItem.id == 'Error') {
      const snackBar = SnackBar(
        content: Text('Could not load data. Please try again later'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Transform(
          transform: matrix,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Colors.blue : Colors.cyan,
              ),
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.warning)]),
              )));
    } else if (busItem.id == 'Empty') {
      const snackBar = SnackBar(
        content: Text('No bus data found. Please add one or more buses'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Transform(
          transform: matrix,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Colors.blue : Colors.cyan,
              ),
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.bus_alert)]),
              )));
    } else {
      return Transform(
          transform: matrix,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Colors.blue : Colors.cyan,
              ),
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BigText(
                            text: 'Bus reg. no.:',
                            color: Colors.white,
                          ),
                          SmallText(
                            text: busItem.busRegNo!,
                            color: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BigText(
                            text: 'No. of seats:',
                            color: Colors.white,
                          ),
                          SmallText(
                            text: busItem.busNumberOfSeats!,
                            color: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BigText(
                            text: 'Driver contact:',
                            color: Colors.white,
                          ),
                          SmallText(
                            text: busItem.busDriverContact!,
                            color: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BigText(
                            text: 'Bus type:',
                            color: Colors.white,
                          ),
                          SmallText(
                            text: busItem.busType!,
                            color: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BigText(
                            text: 'Book seats:',
                            color: Colors.white,
                          ),
                          SmallText(
                            text: busItem.bookable!,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ]),
              )));
    }
  }
}
