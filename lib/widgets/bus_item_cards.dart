import 'dart:convert';
import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:wherebus/tools/get_bus_json_model.dart';
import 'package:wherebus/tools/get_user_json_model.dart';
import 'package:wherebus/widgets/big_text.dart';
import 'package:wherebus/widgets/small_text.dart';

import '../auth/secrets.dart';

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

  var url = Uri.parse(MONGODB_URL_BASE + 'action/find');

  Future<GetBusJsonModel> getBus(String ownerEmail) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(url);
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('api-key', MONGODB_API_KEY);
    request.add(utf8.encode(json.encode({
      'dataSource': 'Cluster0',
      'database': 'WhereBus',
      'collection': 'buses',
      'filter': {"owner": ownerEmail}
    })));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    // print(reply);
    // var jsonReply = json.decode(reply);
    httpClient.close();

    if (response.statusCode == 200) {
      return getBusJsonModelFromJson(reply);
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error ${response.statusCode}'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Could not find your buses'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Please try again later'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return getBusJsonModelFromJson(json.encode(<String, dynamic>{
        'documents': [{'_id': 'Error'}]
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: Colors.deepOrange,
          height: 200,
          child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        const SizedBox(
          height: 14,
        ),
        DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              activeColor: Colors.blue),
        ),
        const SizedBox(height: 30)
      ],
    );
  }

  Widget _buildPageItem(int index) {
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

    return Transform(
        transform: matrix,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: index.isEven ? Colors.blue : Colors.cyan,
            ),
            height: 100,
            margin: const EdgeInsets.only(left: 5, right: 5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        BigText(
                          text: 'Bus reg. no.:',
                          color: Colors.white,
                        ),
                        SmallText(
                          text: 'XXX-0000',
                          color: Colors.white,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        BigText(
                          text: 'No. of seats:',
                          color: Colors.white,
                        ),
                        SmallText(
                          text: '35',
                          color: Colors.white,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        BigText(
                          text: 'Driver contact:',
                          color: Colors.white,
                        ),
                        SmallText(
                          text: '000000000',
                          color: Colors.white,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        BigText(
                          text: 'Bus type:',
                          color: Colors.white,
                        ),
                        SmallText(
                          text: 'Expressway',
                          color: Colors.white,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        BigText(
                          text: 'Book seats:',
                          color: Colors.white,
                        ),
                        SmallText(
                          text: 'Available',
                          color: Colors.white,
                        )
                      ],
                    ),
                  ]),
            )));
  }
}
