import 'package:flutter/material.dart';
import 'package:recorder/Style.dart';

class ItemMainPanel {
  final Widget icon;
  final Widget iconInactive;
  final Text text;
  final Function onTap;
  final Color colorActive;
  final Color colorInactive;

  ItemMainPanel(
      {this.colorActive = cBlue,
      this.colorInactive = cBlack,
      @required this.icon,
      this.iconInactive,
      @required this.text,
      this.onTap})
      : assert(icon != null),
        assert(text != null);
}

class MainPanel extends StatefulWidget {
  final Color backgroundColor;
  final int currentIndex;
  final double height;
  final List<ItemMainPanel> items;
  Function(int index) onChacge;

  MainPanel({
    Key key,
    this.backgroundColor = cBackground,
    this.currentIndex = 0,
    this.height,
    @required this.items,
    this.onChacge
  }):assert(items.isNotEmpty), super(key: key);

  @override
  _MainPanelState createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: widget.height??100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top:Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,4),
              blurRadius: 50,
              spreadRadius: 10,
              color: Color.fromRGBO(0,0,0,0.15),
            )
          ],
          color: widget.backgroundColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:List.generate(widget.items.length, (index){
            Text text = widget.items[index].text;
             text.style.copyWith(fontSize: 16);

            return GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              onTap: (){
                widget.items[index].onTap != null?widget.items[index].onTap():null;
                widget.onChacge != null?widget.onChacge(index):null;
              },
              child: Container(

                child: Container(
                  width: MediaQuery.of(context).size.width/widget.items.length,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      index == widget.currentIndex?widget.items[index].icon:widget.items[index].iconInactive??widget.items[index].icon,
                      SizedBox(height: 12,),
                      Text(text.data, style: text.style.copyWith(color: index == widget.currentIndex?widget.items[index].colorActive:widget.items[index].colorInactive),)
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
