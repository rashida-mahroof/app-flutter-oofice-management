import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';


class IncentiveDetailView extends StatefulWidget {
  final List<dynamic> Obj;
  final String Pname;
  final String UserName;

  const IncentiveDetailView({Key? key, required this.Obj, required this.Pname,required this.UserName})
      : super(key: key);

  @override
  State<IncentiveDetailView> createState() => _IncentiveDetailViewState();
}

class _IncentiveDetailViewState extends State<IncentiveDetailView> {

  static const int sortName = 0;

  bool isAscending = true;
  int sortType = sortName;
  double _totInc=0;
  String Uname='';
  void initState() {
    super.initState();
    Uname=widget.UserName;
    for(int i=0;i<widget.Obj.length;i++)
    {
      _totInc+=double.parse(widget.Obj[i]['Commision']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.2,
                0.8,
              ],
              colors: [
                Colors.orange,
                Colors.red,
              ],
            ),
          ),
        ),
        toolbarHeight: 70,
        title: Text("Invoice No: "+widget.Pname
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 5, right: 10, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.end,
                children: [
              Text(Uname,style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.deepOrangeAccent),)
            ],),
            Expanded(
              child: SingleChildScrollView(
                child: _getBodyWidget(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF7000BF),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Row(
                            children: [
                              Icon(
                                Icons.currency_rupee,
                                color: Colors.white,
                                size: 25,
                              ),
                              Text(
                                _totInc.toStringAsFixed(2),
                                style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Total  Incentive     ',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getBodyWidget() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 550,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: 2,
        // widget.Obj.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
        verticalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.yellow,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        horizontalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.green,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
      ),
      height: MediaQuery.of(context).size.height / 1.48,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget('Product Code', 100),
        onPressed: () {
          sortType = sortName;
          isAscending = !isAscending;
          // .sortName(isAscending);
          setState(() {});
        },
      ),
      _getTitleItemWidget('MRP', 100),
      _getTitleItemWidget('Discount given', 100),
   _getTitleItemWidget('Bill Amount', 150),
      _getTitleItemWidget('Inc. Percentage', 100),
      _getTitleItemWidget('Inc. Amount', 100),


    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF449A4D),
        ),
        child: Text(label,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.white)),
        width: width,
        height: 43,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      color: Colors.grey.shade200,
      child: Text(
        widget.Obj[index]['ProductCode'],
        // widget.Obj[index]['Date'],
        style: GoogleFonts.poppins(
            fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w600),
      ),
      width: 100,
      height: 40,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(widget.Obj[index]['MRP'].toString(),
              // widget.Obj[index]['Amount'],
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.black54,
              )),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(widget.Obj[index]['Discount'],
              // widget.Obj[index]['Discount'],
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.black54,
              )),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Row(
            children: <Widget>[

              Text(widget.Obj[index]['BillAmount'].toString(),
                  // widget.Obj[index]['ProductCode'],

                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.black54,
                  ))
            ],
          ),
          width: 150,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),



        Container(
          child: Text(widget.Obj[index]['IncenPerc'].toString()+"%",
              // widget.Obj[index]['Commision'],
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.black54,
              )),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(widget.Obj[index]['Commision'],
              // widget.Obj[index]['VoucherNo'],
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.black54,
              )),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
