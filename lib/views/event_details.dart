import 'package:appwrite/models.dart';
import 'package:eventhub/colors/colors.dart';
import 'package:eventhub/containers/format_datetime.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key, required this.data});
  final Document data;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: height * 0.30,
                    width: double.infinity,
                    child: Image.network(
                      'https://cloud.appwrite.io/v1/storage/buckets/651a89ae84605c06fb11/files/${widget.data.data['image']}/view?project=65192055e6e15fcbc9e5',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: height * 0.30,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [kTransparent, kTransparent, kBlack],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    bottom: height * 0.04,
                    left: height * 0.01,
                    top: height * 0.2,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 25,
                        ),
                        SizedBox(width: width * 0.01),
                        Text(
                          '${formatDate(widget.data.data['datetime'])}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: kWhite),
                        ),
                        SizedBox(width: width * 0.04),
                        const Icon(
                          Icons.access_time_outlined,
                          size: 30,
                        ),
                        SizedBox(width: width * 0.01),
                        Text(
                          '${formatTime(widget.data.data['datetime'])}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: kWhite),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: height * 0.01,
                    left: height * 0.007,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 25,
                        ),
                        SizedBox(width: width * 0.01),
                        Text(
                          '${widget.data.data['location']}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: kWhite, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.data.data['name'],
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Icon(Icons.share),
                        ],
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        widget.data.data['description'],
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: kWhite),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        'Participants',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${widget.data.data['participants'].length.toString()} people are attending',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: kWhite),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        'Guests',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${widget.data.data['guests'] == '' ? 'None' : widget.data.data['guests']}',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: kWhite),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        'Sponsers',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${widget.data.data['sponsers'] == '' ? 'None' : widget.data.data['sponsers']}',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: kWhite),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        'More Info',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Event is an ${widget.data.data['isInPerson'] == true ? 'InPerson' : 'Virtual'} event',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: kWhite),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        'Event Time',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Time: ${formatTime(widget.data.data['datetime'])}',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: kWhite),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${widget.data.data['location']}',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: kWhite),
                      ),
                      SizedBox(height: height * 0.02),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.map),
                        label: const Text('Open With Google Maps'),
                      ),
                      SizedBox(height: height * 0.02),
                      MaterialButton(
                        onPressed: () {},
                        color: kPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minWidth: width,
                        height: height * 0.06,
                        child: Text(
                          'RSVP Event',
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
            ],
          ),
        ),
      ),
    );
  }
}
