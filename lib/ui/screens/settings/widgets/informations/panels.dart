import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:connecty/ui/widgets/custom_panels_list.dart';
import 'package:flutter/material.dart';

class Panel {
  Panel({
    @required this.expandedValue,
    @required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class PanelData {
  final String header;
  final String content;

  const PanelData(this.header, this.content);
}

class Panels extends StatefulWidget {
  final int numberOfPanels;
  final List<PanelData> items;

  const Panels({Key key, @required this.numberOfPanels, @required this.items})
      : super(key: key);

  @override
  _PanelsState createState() => _PanelsState();
}

class _PanelsState extends State<Panels> {
  List<Panel> _data = [];

  List<Panel> generatePanels(int numberOfPanels) {
    return List<Panel>.generate(numberOfPanels, (int index) {
      return Panel(
        headerValue: widget.items[index].header,
        expandedValue: widget.items[index].content,
      );
    });
  }

  @override
  void initState() {
    _data = generatePanels(widget.numberOfPanels);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomExpansionPanelList(
      animationDuration: const Duration(milliseconds: 700),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Panel panel) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: AutoSizeText(
                tr(panel.headerValue),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            );
          },
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(tr(panel.expandedValue)),
          ),
          isExpanded: panel.isExpanded,
        );
      }).toList(),
    );
  }
}
