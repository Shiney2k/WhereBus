import 'package:flutter/material.dart';

class RefreshListWidget extends StatefulWidget {
  const RefreshListWidget({Key? key, required this.onRefresh, required this.child}) : super(key: key);

  final Widget child;
  final Future Function() onRefresh;

  @override
  State<RefreshListWidget> createState() => _RefreshListWidgetState();
}

class _RefreshListWidgetState extends State<RefreshListWidget> {
  @override
  Widget build(BuildContext context) {
    return buildAndroidRefresh();
  }
  
  Widget buildAndroidRefresh() {
    return RefreshIndicator(onRefresh: widget.onRefresh,
      child: widget.child);
  }
}