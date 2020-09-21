class Components {
  final int id;
  final String name;
  final double price;
  final bool inStock;
  final String category;

  Components(this.id, this.name, this.price, this.inStock, this.category);

  static final components = [
    new Components(1000, "Arduino", 540, true, "Board"),
    new Components(1001, "Raspberry PI", 1500, true, "Board"),
    new Components(1002, "PyBoard V1.0", 1350, false, "Board"),
    new Components(1003, "STM32F4", 1570, false, "Board"),
    new Components(1004, "Smoke Sensor MQ7", 499, true, "Sensors"),
    new Components(1005, "Light Sensor LSP7871", 399, true, "Sensors"),
    new Components(1006, "Sound Sensor ME2290", 199, true, "Sensors"),
    new Components(1007, "Pressure Sensor BMP1250", 249, true, "Sensors"),
    new Components(1008, "ESP32", 749, true, "Board"),
    new Components(1009, "Multimeter S710", 749, true, "Tools"),
    new Components(1010, "Digital Oscilloscope", 29999, true, "Tools"),
    new Components(1011, "Logic Analyzer", 899, false, "Tools"),
    new Components(1012, "Wire Stripper (Yellow)", 49, false, "Tools"),
    new Components(1013, "King Super Glue CA (50g / 1.7oz) Medium", 39, false, "Tools"),
    new Components(1014, "Turnigy Graphene Panther 1300mAh 4S 75C Battery Pack", 1399,
        true, "Battery"),
    new Components(
        1015, "xTesla® Fire Retardant LiPoly Battery Bag", 1499, true, "Battery"),
    new Components(1016, "ZIPPY® Compact 2200mAh 3S 25C Lipo Pack", 1779, true, "Battery")
  ];
}
