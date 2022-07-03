import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:lightpay_app/data/transactions.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({Key? key}) : super(key: key);

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  late int currentPage = 0;
  int _expandWidget = 0;
  List<Map<String, dynamic>> _allTrans =
      transactions['transactions-receive'] + transactions['transactions-send'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: Column(
            children: [
              Flexible(flex: 2, fit: FlexFit.tight, child: _avatorRow()),
              Flexible(flex: 1, fit: FlexFit.loose, child: _balanceRow()),
              // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {}),
              Flexible(
                  flex: 2, fit: FlexFit.tight, child: _transactionActionsRow()),
              Flexible(flex: 4, fit: FlexFit.tight, child: _transactionPage()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _allTrans.sort((a, b) => b['date'].compareTo(a['date']));
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
  }

  Widget _avatorRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: const ImageIcon(AssetImage('assets/icon/menu_icon.png'),
                  color: Colors.blue)),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
              bottomRight: Radius.circular(13.0),
              bottomLeft: Radius.circular(13.0),
            ),
            child: Image.network(
              'https://avatars.githubusercontent.com/u/27887884?v=4',
              width: 50.0,
              height: 50.0,
            ),
          ),
          Transform.rotate(
              angle: 90 * math.pi / 180,
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_vert))),
        ],
      ),
    );
  }

  Widget _balanceRow() {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Text('Available Balance',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.blue[300])),
        ),
        Flexible(
            fit: FlexFit.tight,
            flex: 4,
            child: RichText(
                textAlign: TextAlign.start,
                overflow: TextOverflow.fade,
                text: TextSpan(children: [
                  TextSpan(
                      text: 'TZS',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.blue)),
                  TextSpan(
                      text: '17,846,900',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ]))),
      ],
    );
  }

  Widget _transactionActionsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              width: currentPage == 0
                  ? MediaQuery.of(context).size.width * 0.37
                  : MediaQuery.of(context).size.width * 0.13,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                color: currentPage == 0
                    ? const Color.fromARGB(255, 163, 226, 235)
                    : Colors.white, // rgb(157, 214, 223)
                border: currentPage != 0
                    ? Border.all(
                        color: const Color.fromARGB(255, 163, 226, 235),
                        width: 5.0,
                        style: BorderStyle.solid)
                    : null,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),
              ),
              child: _expandWidget == 0
                  ? Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                          margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(11, 0, 0, 0),
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  0.0,
                                  3.0,
                                ),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () => null,
                            icon: const Icon(
                              Icons.arrow_upward_rounded,
                              color: Color.fromARGB(255, 163, 226, 235),
                            ),
                          ),
                        ),
                        Text('Send',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))
                      ],
                    )
                  : IconButton(
                      onPressed: () {
                        _pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInOut);
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          setState(() {
                            _expandWidget = currentPage;
                          });
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_upward_rounded,
                        color: Color.fromARGB(255, 163, 226, 235),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              width: currentPage == 1
                  ? MediaQuery.of(context).size.width * 0.37
                  : MediaQuery.of(context).size.width * 0.13,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                color: currentPage == 1
                    ? const Color.fromARGB(255, 178, 232, 179)
                    : Colors.white, // rgb(157, 214, 223)
                border: currentPage != 1
                    ? Border.all(
                        color: const Color.fromARGB(255, 178, 232, 179),
                        width: 5.0,
                        style: BorderStyle.solid)
                    : null,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),
              ),
              child: _expandWidget == 1
                  ? Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                          margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(11, 0, 0, 0),
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  0.0,
                                  3.0,
                                ),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () => null,
                            icon: const Icon(
                              Icons.arrow_downward_rounded,
                              color: Color.fromARGB(255, 178, 232, 179),
                            ),
                          ),
                        ),
                        Text('Receive',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))
                      ],
                    )
                  : IconButton(
                      onPressed: () {
                        _pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInOut);
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          setState(() {
                            _expandWidget = currentPage;
                          });
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_downward_rounded,
                        color: Color.fromARGB(255, 178, 232, 179),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              width: currentPage == 2
                  ? MediaQuery.of(context).size.width * 0.37
                  : MediaQuery.of(context).size.width * 0.13,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                color: currentPage == 2
                    ? const Color.fromARGB(255, 244, 220, 148)
                    : Colors.white, // rgb(157, 214, 223)
                border: currentPage != 2
                    ? Border.all(
                        color: const Color.fromARGB(255, 244, 220, 148),
                        width: 5.0,
                        style: BorderStyle.solid)
                    : null,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),
              ),
              child: _expandWidget == 2
                  ? Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                          margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(11, 0, 0, 0),
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  0.0,
                                  3.0,
                                ),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () => null,
                            icon: const Icon(
                              Icons.line_style_sharp,
                              color: Color.fromARGB(255, 244, 220, 148),
                            ),
                          ),
                        ),
                        Text(
                          'All Trans',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  : IconButton(
                      onPressed: () {
                        _pageController.animateToPage(2,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInOut);
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          setState(() {
                            _expandWidget = currentPage;
                          });
                        });
                      },
                      icon: const Icon(
                        Icons.line_style_sharp,
                        color: Color.fromARGB(255, 244, 220, 148),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionPage() {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      // onPageChanged: (indexPage) {
      //   setState(() {
      //     currentPage = indexPage;
      //   });
      // },
      children: [
        PageStorage(bucket: _pageStorageBucket, child: _lastSend()),
        PageStorage(bucket: _pageStorageBucket, child: _lastReceive()),
        PageStorage(bucket: _pageStorageBucket, child: _allTransactions())
      ],
    );
  }

  Widget _lastSend() => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Text(
                  'Last Send',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: transactions['transactions-send'].length,
                    itemBuilder: (context, index) {
                      return _sendTile(
                          transactions['transactions-send'][index]['title'],
                          transactions['transactions-send'][index]['date'],
                          transactions['transactions-send'][index]['amount']);
                    }),
              )
            ],
          ),
        ),
      );

  Widget _lastReceive() => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Text(
                  'Last Receive',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: transactions['transactions-receive'].length,
                    itemBuilder: (context, index) {
                      return _receiveTile(
                          transactions['transactions-receive'][index]['title'],
                          transactions['transactions-receive'][index]['date'],
                          transactions['transactions-receive'][index]['amount']);
                    }),
              )
            ],
          ),
        ),
      );

  Widget _allTransactions() => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Text(
                  'All Transactions',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _allTrans.length,
                    itemBuilder: (context, index) {
                      return _allTrans[index]['type'] == 'receive'
                          ? _receiveTile(
                              _allTrans[index]['title'],
                              _allTrans[index]['date'],
                              _allTrans[index]['amount'])
                          : _sendTile(
                              _allTrans[index]['title'],
                              _allTrans[index]['date'],
                              _allTrans[index]['amount']);
                    }),
              )
            ],
          ),
        ),
      );

  Widget _receiveTile(String title, String date, String amount) {
    return ListTile(
      leading: Transform.rotate(
        angle: -45,
        child: const Icon(
          Icons.arrow_downward_rounded,
          color: Colors.green,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      subtitle: Text(
        date,
        style: Theme.of(context)
            .textTheme
            .overline!
            .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      trailing: RichText(
          textAlign: TextAlign.start,
          overflow: TextOverflow.fade,
          text: TextSpan(children: [
            TextSpan(
                text: '+TZS',
                style: Theme.of(context)
                    .textTheme
                    .overline!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.blue)),
            TextSpan(
                text: amount,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.green[300])),
          ])),
    );
  }

  Widget _sendTile(String title, String date, String amount) {
    return ListTile(
      leading: Transform.rotate(
        angle: 315,
        child: const Icon(
          Icons.arrow_upward_rounded,
          color: Colors.red,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      subtitle: Text(
        date,
        style: Theme.of(context)
            .textTheme
            .overline!
            .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      trailing: RichText(
          textAlign: TextAlign.start,
          overflow: TextOverflow.fade,
          text: TextSpan(children: [
            TextSpan(
                text: '-TZS',
                style: Theme.of(context)
                    .textTheme
                    .overline!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.red)),
            TextSpan(
                text: amount,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.orange)),
          ])),
    );
  }
}
