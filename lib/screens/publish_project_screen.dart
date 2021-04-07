import 'package:erasmus_projects/components/form_input.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PublishProjectScreen extends StatefulWidget {
  static const String id = "publish_project_screen";

  @override
  _PublishProjectScreenState createState() => _PublishProjectScreenState();
}

class _PublishProjectScreenState extends State<PublishProjectScreen> {
  String dropdownValue = 'Youth Exchanges';
  String dropdownValue2 =
      'This project is financed by the Erasmus+Youth Programme.';

  DateTime selectedDate;
  @override
  initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.vertical(
                  bottom: Radius.elliptical(350.0, 20.0),
                ),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bandeira.jpeg')),
              ),
            ),
            Positioned(
              //left: 10.0,
              top: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ListView(
              children: [
                Text(
                  "Publish Project",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FormInput(
                  title: "Project Title",
                  inputHint: 'Enter Project Title',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project Dates',
                      style: TextStyle(
                        color: kYellowGold,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100.0,
                          child: InputDatePickerFormField(
                            firstDate: DateTime(2019),
                            lastDate: DateTime(2021, 12, 12),
                            initialDate: selectedDate,
                            onDateSubmitted: (date) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Container(
                            height: 1.0,
                            width: 20.0,
                            color: kYellowGold,
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: InputDatePickerFormField(
                            firstDate: DateTime(2019),
                            lastDate: DateTime(2021, 12, 12),
                            initialDate: selectedDate,
                            onDateSubmitted: (date) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                          ),
                        ),
                        FaIcon(
                          FontAwesomeIcons.calendar,
                          color: kYellowGold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                FormInput(
                  title: "Venue",
                  inputHint: 'City Country',
                ),
                FormInput(
                  title: "Organization Name",
                  inputHint: 'Enter Organization Name',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eligible Countries',
                      style: TextStyle(
                        color: kYellowGold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(
                        10.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kYellowGold,
                        ),
                      ),
                      child: Wrap(
                        spacing: 2.0,
                        runSpacing: 5.0,
                        children: [
                          Text(
                            'Portugal X',
                            style: TextStyle(
                              color: Colors.blue[900],
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                          Text(
                            'England X',
                            style: TextStyle(
                              color: Colors.blue[900],
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                          Text(
                            'USA X',
                            style: TextStyle(
                              color: Colors.blue[900],
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                          Text(
                            'Ireland X',
                            style: TextStyle(
                              color: Colors.blue[900],
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                          Text(
                            'Turkey X',
                            style: TextStyle(
                              color: Colors.blue[900],
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                          Text(
                            'Peru X',
                            style: TextStyle(
                              color: Colors.blue[900],
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                          Text(
                            'Argentina X',
                            style: TextStyle(
                              color: Colors.blue[900],
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eligible Countries',
                      style: TextStyle(
                        color: kYellowGold,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100.0,
                          child: InputDatePickerFormField(
                            firstDate: DateTime(2019),
                            lastDate: DateTime(2021, 12, 12),
                            initialDate: selectedDate,
                            onDateSubmitted: (date) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                          ),
                        ),
                        FaIcon(
                          FontAwesomeIcons.calendar,
                          color: kYellowGold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type',
                      style: TextStyle(
                        color: kYellowGold,
                      ),
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      icon: FaIcon(
                        FontAwesomeIcons.angleDown,
                        color: Colors.blue[900],
                      ),
                      iconSize: 14,
                      elevation: 16,
                      style: TextStyle(color: Colors.blue[900]),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        'Youth Exchanges',
                        'Volunteering Activities (formerly EVS)',
                        'Training and Networking',
                        'Transnational Youth Initiatives',
                        'Strategic Partnerships',
                        'Capacity Building',
                        'Meetings between young people and decison-markers',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                        color: kYellowGold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 5,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue[900], width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kYellowGold, width: 1.0),
                          ),
                          hintText: 'Enter Description',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tags',
                      style: TextStyle(
                        color: kYellowGold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(
                        10.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kYellowGold,
                        ),
                      ),
                      child: Wrap(
                        spacing: 2.0,
                        runSpacing: 5.0,
                        children: [
                          Text(
                            'Self-care X',
                            style: TextStyle(
                              color: Colors.blue[900],
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                          Text(
                            'Ukraine X',
                            style: TextStyle(
                              color: Colors.blue[900],
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Infopack',
                      style: TextStyle(
                        color: kYellowGold,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Attach your Infopack    X',
                      style: TextStyle(
                        color: Colors.blue[900],
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cost',
                      style: TextStyle(
                        color: kYellowGold,
                      ),
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue2,
                      icon: FaIcon(
                        FontAwesomeIcons.angleDown,
                        color: Colors.blue[900],
                      ),
                      iconSize: 14,
                      elevation: 16,
                      style: TextStyle(color: Colors.blue[900]),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue2 = newValue;
                        });
                      },
                      items: <String>[
                        'This project is financed by the Erasmus+Youth Programme.',
                        'Costumized',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                FormInput(
                  title: "Contact",
                  inputHint: 'Insert e-mail',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apply Button',
                      style: TextStyle(
                        color: kYellowGold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'In this section, you can either link an email or a form to proceed to enrollment.',
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue[900],
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kYellowGold, width: 1.0),
                          ),
                          hintText: 'Insert form link or e-mail',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Publish",
                    style: TextStyle(
                      color: kYellowGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
