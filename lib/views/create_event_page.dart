// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:eventhub/auth.dart';
import 'package:eventhub/colors/colors.dart';
import 'package:eventhub/containers/custom_headtext.dart';
import 'package:eventhub/containers/custom_input_form.dart';
import 'package:eventhub/database.dart';
import 'package:eventhub/saved_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  FilePickerResult? _filePickerResult;
  bool _isInPersonEvent = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _guestController = TextEditingController();
  final TextEditingController _sponsersController = TextEditingController();

  Storage storage = Storage(client);
  bool isUploading = false;
  String userId = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    userId = SaveData.getUserId();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

//Date time picker method
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDateTime != null) {
      final TimeOfDay? pickTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickTime.hour,
          pickTime.minute,
        );
        setState(() {
          _dateTimeController.text = selectedDateTime.toString();
        });
      }
    }
  }

  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      _filePickerResult = result;
    });
  }

  //upload event image to storage bucket
  Future uploadEventImage() async {
    setState(() {
      isUploading = true;
    });
    try {
      if (_filePickerResult != null) {
        PlatformFile file = _filePickerResult!.files.first;
        final fileBytes = await File(file.path!).readAsBytes();
        final inputFile =
            InputFile.fromBytes(bytes: fileBytes, filename: file.name);

        final response = await storage.createFile(
          bucketId: '651a89ae84605c06fb11',
          fileId: ID.unique(),
          file: inputFile,
        );
        print(response.$id);
        return response.$id;
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      isUploading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomHeadText(text: 'Create Event'),
                SizedBox(height: height * 0.01),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _openFilePicker();
                    });
                  },
                  child: Container(
                    height: height * 0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _filePickerResult != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: FileImage(
                                File(_filePickerResult!.files.first.path!),
                              ),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add_a_photo_rounded,
                                size: 45,
                                color: Colors.black,
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                'Add an image',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.black),
                              )
                            ],
                          ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                CustomInputForm(
                  controller: _nameController,
                  icon: Icons.event,
                  label: 'Event Name',
                  hint: 'Enter your event name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Event name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.15,
                  child: CustomInputForm(
                    maxLines: 4,
                    controller: _descController,
                    icon: Icons.description,
                    label: 'Description',
                    hint: 'Describe your event',
                  ),
                ),
                SizedBox(height: height * 0.02),
                CustomInputForm(
                  controller: _locationController,
                  icon: Icons.location_on,
                  label: 'Location',
                  hint: 'Enter the location of the event',
                ),
                SizedBox(height: height * 0.02),
                CustomInputForm(
                  controller: _dateTimeController,
                  icon: Icons.date_range,
                  label: 'Date',
                  hint: 'Pick Date Time',
                  readOnly: true,
                  onTap: () {
                    _selectDateTime(context);
                  },
                ),
                SizedBox(height: height * 0.02),
                CustomInputForm(
                  controller: _guestController,
                  icon: Icons.people,
                  label: 'Guests',
                  hint: 'Enter the number of guest',
                ),
                SizedBox(height: height * 0.02),
                CustomInputForm(
                  controller: _sponsersController,
                  icon: Icons.monetization_on,
                  label: 'Sponsers',
                  hint: 'Enter the sponsers of the event',
                ),
                SizedBox(height: height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _isInPersonEvent
                        ? Text(
                            'In Person Event',
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        : Text(
                            'Online Event',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                    FlutterSwitch(
                      height: 30,
                      width: 58,
                      value: _isInPersonEvent,
                      toggleColor: Colors.black,
                      activeColor: kPrimary,
                      inactiveColor: kPrimaryInactive,
                      onToggle: (value) {
                        setState(() {
                          _isInPersonEvent = !_isInPersonEvent;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                MaterialButton(
                  onPressed: () {
                    if (_nameController.text == '' ||
                        _descController.text == '' ||
                        _locationController.text == '' ||
                        _dateTimeController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Event Name, Description, Location, DateTime are required',
                          ),
                        ),
                      );
                    } else {
                      uploadEventImage()
                          .then((value) => createEvent(
                                _nameController.text,
                                _descController.text,
                                value, //value is of image (Image Id)
                                _locationController.text,
                                _dateTimeController.text,
                                userId,
                                _isInPersonEvent,
                                _guestController.text,
                                _sponsersController.text,
                              ))
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Event Created'),
                          ),
                        );
                        Navigator.pop(context);
                      });
                    }
                  },
                  color: kPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minWidth: width,
                  height: height * 0.06,
                  child: Text(
                    'Create New Event',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: kBlack),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
