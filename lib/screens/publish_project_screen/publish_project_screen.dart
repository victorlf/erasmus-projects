import 'dart:io';

import 'package:erasmus_projects/components/form_input.dart';
import 'package:erasmus_projects/models/project_model.dart';
import 'package:erasmus_projects/screens/explore/explore_screen.dart';
import 'package:erasmus_projects/services/authentication.dart';
import 'package:erasmus_projects/utilities/constants.dart';
import 'package:erasmus_projects/utilities/forms_validation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:intl/intl.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'country_tags.dart';

class PublishProjectScreen extends StatefulWidget {
  static const String id = "publish_project_screen";

  @override
  _PublishProjectScreenState createState() => _PublishProjectScreenState();
}

class _PublishProjectScreenState extends State<PublishProjectScreen> {
  bool showSpinner = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  //final venueController = TextEditingController();
  final cityController = TextEditingController();
  final organizationNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final customiedCostController = TextEditingController();
  final contactController = TextEditingController();
  final applyButtonController = TextEditingController();
  final projectDateBeginController = TextEditingController();
  final projectDateEndController = TextEditingController();
  final deadlineController = TextEditingController();
  String dropdownCountry = 'Portugal';
  String dropdownType = 'Youth Exchanges';
  String dropdownCost =
      'This project is financed by the Erasmus+Youth Programme.';

  String _fileName = 'Click to Attach your Infopack';
  File _filePath;
  //bool _emptyFileError = false;

  List<TagItem> _selectedCountries = [];
  String _selectedCountriesValuesJson = 'Nothing to show';
  bool _emptyCountriesError = false;
  List<TagItem> _selectedTags = [];
  String _selectedTagsValuesJson = 'Nothing to show';
  bool _emptyTagsError = false;

  DateTime selectedDate;
  @override
  initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    titleController.dispose();
    //venueController.dispose();
    cityController.dispose();
    organizationNameController.dispose();
    descriptionController.dispose();
    customiedCostController.dispose();
    contactController.dispose();
    applyButtonController.dispose();
    projectDateBeginController.dispose();
    projectDateEndController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingOverlay(
      isLoading: showSpinner,
      child: Column(
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
              child: form(),
            ),
          ),
        ],
      ),
    ));
  }

  form() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              controller: titleController,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Title is Empty';
                }
              },
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
                    GestureDetector(
                      onTap: () =>
                          _selectDate(context, projectDateBeginController),
                      child: Container(
                        width: 100.0,
                        child: AbsorbPointer(
                          child: TextFormField(
                            //controller: ,
                            keyboardType: TextInputType.datetime,
                            controller: projectDateBeginController,
                            validator: (value) {
                              if (value.isEmpty) return "Date is Empty";
                              return null;
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: '00/oct/2020',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                            //validator: validator,
                          ),
                        ),
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
                    GestureDetector(
                      onTap: () =>
                          _selectDate(context, projectDateEndController),
                      child: Container(
                        width: 100.0,
                        child: AbsorbPointer(
                          child: TextFormField(
                            //controller: ,
                            keyboardType: TextInputType.datetime,
                            controller: projectDateEndController,
                            validator: (value) {
                              if (value.isEmpty) return "Date is Empty";
                              return null;
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: '00/oct/2020',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                            //validator: validator,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
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
                  'Venue',
                  style: TextStyle(
                    color: kYellowGold,
                  ),
                ),
                Container(
                  width: 300.0,
                  child: TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'City',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'City is Empty';
                      }
                    },
                  ),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownCountry,
                  icon: FaIcon(
                    FontAwesomeIcons.angleDown,
                    color: Colors.blue[900],
                  ),
                  iconSize: 14,
                  elevation: 16,
                  style: TextStyle(color: Colors.blue[900]),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownCountry = newValue;
                    });
                  },
                  items: <String>[
                    'Germany',
                    'China',
                    'Portugal',
                    'Italy',
                    'Poland',
                    'Ireland',
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
            // FormInput(
            //   title: "Venue",
            //   inputHint: 'City Country',
            //   //controller: venueController,
            //   validator: (String value) {
            //     if (value.isEmpty) {
            //       return 'Venue is Empty';
            //     }
            //   },
            // ),
            FormInput(
              title: "Organization Name",
              inputHint: 'Enter Organization Name',
              controller: organizationNameController,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Organization Name is Empty';
                }
              },
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
                FlutterTagging<TagItem>(
                    initialItems: _selectedCountries,
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey.withAlpha(30),
                        hintText: 'Search Countries',
                        labelText: 'Select Countries',
                      ),
                    ),
                    findSuggestions: CountryService.getCountries,
                    additionCallback: (value) {
                      return TagItem(
                        name: value,
                        position: 0,
                      );
                    },
                    // onAdded: (tagItem) {
                    //   // api calls here, triggered when add to tag button is pressed
                    //   return tagItem;
                    // },
                    configureSuggestion: (lang) {
                      return SuggestionConfiguration(
                        title: Text(lang.name),
                        subtitle: Text(lang.position.toString()),
                        // additionWidget: Chip(
                        //   avatar: Icon(
                        //     Icons.add_circle,
                        //     color: Colors.white,
                        //   ),
                        //   label: Text('Add New Tag'),
                        //   labelStyle: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 14.0,
                        //     fontWeight: FontWeight.w300,
                        //   ),
                        //   backgroundColor: Colors.green,
                        // ),
                      );
                    },
                    configureChip: (lang) {
                      return ChipConfiguration(
                        label: Text(lang.name),
                        backgroundColor: Colors.grey[300],
                        labelStyle: TextStyle(color: Colors.blue[900]),
                        deleteIconColor: Colors.white,
                      );
                    },
                    onChanged: () {
                      setState(() {
                        _selectedCountriesValuesJson = _selectedCountries
                            .map<String>((lang) => '\n${lang.toJson()}')
                            .toList()
                            .toString();
                        _selectedCountriesValuesJson =
                            _selectedCountriesValuesJson.replaceFirst(
                                '}]', '}\n]');
                      });
                      // List f = _selectedCountries
                      //     .map<String>((lang) => '${lang.name}')
                      //     .toList();
                      // print('List here');
                      // print(f);
                    }),
                SizedBox(
                  height: 10.0,
                ),
                _emptyCountriesError
                    ? Text(
                        'Select at least a Country',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Application deadline',
                  style: TextStyle(
                    color: kYellowGold,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _selectDate(context, deadlineController),
                      child: Container(
                        width: 100.0,
                        child: AbsorbPointer(
                          child: TextFormField(
                            //controller: ,
                            keyboardType: TextInputType.datetime,
                            controller: deadlineController,
                            validator: (value) {
                              if (value.isEmpty) return "Date is Empty";
                              return null;
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: '00/oct/2020',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                            //validator: validator,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
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
                  value: dropdownType,
                  icon: FaIcon(
                    FontAwesomeIcons.angleDown,
                    color: Colors.blue[900],
                  ),
                  iconSize: 14,
                  elevation: 16,
                  style: TextStyle(color: Colors.blue[900]),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownType = newValue;
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
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 5,
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
                        borderSide: BorderSide(
                          color: kYellowGold,
                          width: 1.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red[900],
                          width: 2.0,
                        ),
                      ),
                      hintText: 'Enter Description',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
                  controller: descriptionController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Descrption is Empty';
                    }
                  },
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
                FlutterTagging<TagItem>(
                    initialItems: _selectedTags,
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey.withAlpha(30),
                        hintText: 'Search Tags',
                        labelText: 'Select Tags',
                      ),
                    ),
                    findSuggestions: ProjectService.getProjects,
                    additionCallback: (value) {
                      return TagItem(
                        name: value,
                        position: 0,
                      );
                    },
                    onAdded: (tagItem) {
                      // api calls here, triggered when add to tag button is pressed
                      return tagItem;
                    },
                    configureSuggestion: (lang) {
                      return SuggestionConfiguration(
                        title: Text(lang.name),
                        subtitle: Text(lang.position.toString()),
                        additionWidget: Chip(
                          avatar: Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                          label: Text('Add New Tag'),
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                          ),
                          backgroundColor: Colors.blue[900],
                        ),
                      );
                    },
                    configureChip: (lang) {
                      return ChipConfiguration(
                        label: Text(lang.name),
                        backgroundColor: Colors.grey[300],
                        labelStyle: TextStyle(color: Colors.blue[900]),
                        deleteIconColor: Colors.white,
                      );
                    },
                    onChanged: () {
                      setState(() {
                        _selectedTagsValuesJson = _selectedTags
                            .map<String>((lang) => '\n${lang.toJson()}')
                            .toList()
                            .toString();
                        _selectedTagsValuesJson =
                            _selectedTagsValuesJson.replaceFirst('}]', '}\n]');
                      });
                    }),
                SizedBox(
                  height: 10.0,
                ),
                _emptyTagsError
                    ? Text(
                        'Select at least a Tag',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Infopack',
                  style: TextStyle(
                    color: kYellowGold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () async {
                    FilePickerResult result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf', 'doc', 'docx'],
                    );
                    if (result != null) {
                      File file = File(result.files.single.path);
                      PlatformFile platformFile = result.files.single;
                      print(file.path);
                      setState(() {
                        _fileName = platformFile.name;
                        _filePath = file;
                      });
                    } else {
                      // User canceled the picker
                    }
                  },
                  child: Text(
                    _fileName,
                    style: TextStyle(
                      color: Colors.blue[900],
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            // _emptyFileError
            //     ? Text(
            //         'Select a File',
            //         style: TextStyle(
            //           color: Colors.red,
            //           fontSize: 12.0,
            //         ),
            //       )
            //     : Container(),
            // SizedBox(
            //   height: 30.0,
            // ),
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
                  value: dropdownCost,
                  icon: FaIcon(
                    FontAwesomeIcons.angleDown,
                    color: Colors.blue[900],
                  ),
                  iconSize: 14,
                  elevation: 16,
                  style: TextStyle(color: Colors.blue[900]),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownCost = newValue;
                    });
                  },
                  items: <String>[
                    'This project is financed by the Erasmus+Youth Programme.',
                    'Customized',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                dropdownCost == 'Customized'
                    ? TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 5,
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
                              borderSide: BorderSide(
                                color: kYellowGold,
                                width: 1.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red[900],
                                width: 2.0,
                              ),
                            ),
                            hintText: 'Describe your financial cost',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            )),
                        controller: customiedCostController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Descrption is Empty';
                          }
                        },
                      )
                    : Container(),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
            FormInput(
              title: "Contact",
              inputHint: 'Insert e-mail',
              controller: contactController,
              keyboardType: TextInputType.emailAddress,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Contact is Empty';
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return 'Contact must be a email';
                }
              },
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
                TextFormField(
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  controller: applyButtonController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Apply Button is Empty';
                    }
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue[900],
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kYellowGold,
                          width: 1.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red[900],
                          width: 2.0,
                        ),
                      ),
                      hintText: 'Insert form link formated as http:// ...',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  bool formsTags;
                  setState(() {
                    formsTags = _validateTags();
                  });

                  if (validateAndSave(_formKey.currentState) && formsTags) {
                    User loggedInUser = await getCurrentUser();
                    ProjectModel projectModel = ProjectModel(
                      title: titleController.text,
                      beginDate:
                          DateTime.parse(projectDateBeginController.text),
                      endDate: DateTime.parse(projectDateEndController.text),
                      //venue: venueController.text,
                      city: cityController.text,
                      country: dropdownCountry,
                      organization: organizationNameController.text,
                      eligible: _selectedCountries
                          .map<String>((lang) => '${lang.name}')
                          .toList(),
                      deadline: DateTime.parse(deadlineController.text),
                      type: dropdownType,
                      description: descriptionController.text,
                      tags: _selectedTags
                          .map<String>((lang) => '${lang.name}')
                          .toList(),
                      infopack: _fileName,
                      infopackPath: _filePath,
                      cost: dropdownCost,
                      customizedCost: customiedCostController.text,
                      contact: contactController.text,
                      applyButton: applyButtonController.text,
                      uid: loggedInUser.uid,
                    );
                    bool isUploadOk = await projectModel.addSnapshot();
                    if (isUploadOk) {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Project Published'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                    'Project is up!',
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    ExploreScreen.id,
                                    ModalRoute.withName(ExploreScreen.id),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Publishing Error'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                    'Project was not publish!',
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    setState(() {
                      print('Form did pass');
                      showSpinner = false;
                    });
                  } else {
                    setState(() {
                      print('Form didn\'t pass');
                      showSpinner = false;
                    });
                  }
                },
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
            ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        // var date =
        //     "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        // controller.text = date;
        controller.text = picked.toString();
      });
  }

  bool _validateTags() {
    _emptyCountriesError = _selectedCountries.isEmpty;
    _emptyTagsError = _selectedTags.isEmpty;
    //_emptyFileError = (_fileName == 'Click to Attach your Infopack');

    //if (_emptyCountriesError || _emptyTagsError || _emptyFileError) {
    if (_emptyCountriesError || _emptyTagsError) {
      return false;
    }

    return true;
  }
}
