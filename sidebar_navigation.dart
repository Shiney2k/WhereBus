// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:wherebus/pages/passenger_home.dart';
// import 'package:wherebus/pages/sign_in.dart';
// import 'package:wherebus/tools/get_user_json_model.dart';

// enum NavigationEvents {
//   PassengerHomePageClickedEvent,
//   AccountClickedEvent,
//   TicketsClickedEvent,
// }

// abstract class NavigationStates {}

// class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
//   //NavigationBloc(super.initialState);
//   NavigationBloc(this.data, super.initialState);
//   final GetUserJsonModel data;

//   @override
//   passenger_home get initialState => passenger_home(wi);

//   @override
//   Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
//     switch (event) {
//       case NavigationEvents.PassengerHomePageClickedEvent:
//         yield passenger_home(data: GetUserJsonModel(document: document));
//         break;
//       case NavigationEvents.MyAccountClickedEvent:
//         yield MyAccountsPage();
//         break;
//       case NavigationEvents.MyOrdersClickedEvent:
//         yield MyOrdersPage();
//         break;
//     }
//   }
// }
