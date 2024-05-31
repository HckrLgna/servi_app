import 'package:flutter/material.dart';
import 'package:service_app/models/models.dart';
import 'package:service_app/widgets/vehicle_image.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key, required this.vehicle});
  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                VehicleImage(url: vehicle.pathImage),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      vehicle.brand,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 4),
                        Text(
                          "${vehicle.model}\n${vehicle.licensePlate}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 16,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    // Define the action for delete button
                  },
                ),
              ],
            )));
  }
}
