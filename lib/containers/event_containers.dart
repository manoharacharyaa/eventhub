import 'package:appwrite/models.dart';
import 'package:eventhub/colors/colors.dart';
import 'package:eventhub/containers/format_datetime.dart';
import 'package:eventhub/views/event_details.dart';

import 'package:flutter/material.dart';

class EventContainer extends StatelessWidget {
  final Document data;
  const EventContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventDetails(data: data),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              height: height * 0.25,
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2D3E),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 218, 255, 123),
                    blurRadius: 0,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.35),
                    BlendMode.darken,
                  ),
                  child: Image.network(
                    'https://cloud.appwrite.io/v1/storage/buckets/651a89ae84605c06fb11/files/${data.data['image']}/view?project=65192055e6e15fcbc9e5',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              left: 16,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  data.data["name"],
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: kWhite),
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              left: 16,
              child: Row(
                children: [
                  const Icon(Icons.calendar_month_outlined, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    formatDate(data.data["datetime"]),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: kWhite),
                  ),
                  const SizedBox(width: 14),
                  const Icon(Icons.access_time_rounded, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    formatTime(data.data["datetime"]),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: kWhite),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 16,
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    data.data["location"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
