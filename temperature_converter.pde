//code for implementation of the temperature converter feature

float temperatureCelsius; //storing temperature in Celsius
int temperatureUnit; // 0: Celsius, 1: Fahrenheit, 2: Kelvin


float convertTemperature(float temperature, int unit) {
  switch (unit) {
    case 1: // Fahrenheit
      return temperature * 9 / 5 + 32;
    case 2: // Kelvin
      return temperature + 273.15;
    default: // Celsius (unit 0)
      return temperature;
  }
}
//convertTemperature() ends


String getTemperatureUnitSymbol() {
  switch (temperatureUnit) {
    case 1:
      return "°F";
    case 2:
      return "K";
    default:
      return "°C";
  }
}
//getTemperatureUnitSymbol() ends


void drawTemperatureConverterUI() {
  fill(0);
  textSize(14);
  text("Chosen Temperature Unit: " + getTemperatureUnitSymbol(), width / 2, height - 525);

  //button Height and Width defined here:
  float buttonWidth = 80;
  float buttonHeight = 40; 
  float padding = 20; //padding between buttons for cleaner look and to ensure touhpoints for each of Celsius, Kelvin and Fahrenheit don't coincide

  //total width of the button group
  float totalWidth = 3 * buttonWidth + 2 * padding;

  //centering the buttons along the X-axis
  float startX = 800 / 2 - totalWidth / 2; //float startX = width / 2 - totalWidth / 2;

  //Celsius button
  fill(temperatureUnit == 0 ? color(171, 219, 227) : 255); //pastel blue for selected buttons
  rect(startX, 220, 80, 40);
  fill(0);
  text("Celsius", startX + buttonWidth / 2, 800 - 560); 

  //Fahrenheit button
  fill(temperatureUnit == 1 ? color(171, 219, 227) : 255);
  rect(startX + buttonWidth + padding, height - 580, buttonWidth, buttonHeight); 
  fill(0);
  text("Fahrenheit", startX + buttonWidth + padding + buttonWidth / 2, height - 560);

  //Kelvin button
  fill(temperatureUnit == 2 ? color(171, 219, 227) : 255);
  rect(startX + 2 * (buttonWidth + padding), height - 580, buttonWidth, buttonHeight);
  fill(0);
  text("Kelvin", startX + 2 * (buttonWidth + padding) + buttonWidth / 2, height - 560);
}
//drawTemperatureConverterUI() ends


void mousePressed() {
  //checking here if the mouse is pressed inside the buttons for temperature units
  if (mouseY > height - 575 && mouseY < height - 545) {
    float buttonWidth = 80;
    float padding = 20;

    float startX = width / 2 - (3 * buttonWidth + 2 * padding) / 2;

    if (mouseX > startX && mouseX < startX + buttonWidth) {
      temperatureUnit = 0; // Celsius
    } else if (mouseX > startX + buttonWidth + padding && mouseX < startX + 2 * buttonWidth + padding) {
      temperatureUnit = 1; // Fahrenheit
    } else if (mouseX > startX + 2 * (buttonWidth + padding) && mouseX < startX + 3 * buttonWidth + 2 * padding) {
      temperatureUnit = 2; // Kelvin
    }
  }
}
//mousePressed() ends
