//code for implementation of the graph along with a hover feature
//also implementation of the draw feature that draws most of the text details, the name of the app, and of course the graph feature

float[] temperatures = new float[5];
float[][] weatherData = new float[5][3]; // Array to store temperature, humidity, and weather condition for each day, 3 values and 5 days
boolean[] hoverDetails = new boolean[5]; // Array to store hover status for each data point

//This is where we've implemented the following 7 functions:
//draw() 
//drawBackground()
//generateRandomWeatherData()
//generateRandomForecastData()
//displayWeather()
//drawTemperatureGraph()
//getWeatherConditionName()

void draw() {
  background(255);
  drawBackground();
  
  fill(255, 235); //alpha value for backdrop set to 235
  stroke(255); //white outline to the white translucent square
  strokeWeight(1); //width of the stroke
  rectMode(CORNER);
  rect(50, 50, width - 100, height - 100);  //Drawing the white square here, x-y coordinates and size of the square
  
  displayWeather();
  drawTemperatureGraph(width / 2, height / 2 + 290); //Call the function to draw the graph
  drawTemperatureConverterUI();
  
  // Drawing "Chosen City" text
  fill(0);
  textSize(18);
  PFont font = createFont("Helvetica", 18); //Defining a new font Arial-BoldMT
  
  textAlign(CENTER, CENTER);
  text("Chosen City: " + currentCity, width / 2, 130);
  textFont(font);
}
//draw() ends


void drawBackground() {
  if (cityBackground != null) {
    image(cityBackground, 0, 0, width, height);
  }
}
//drawBackground() ends


void generateRandomWeatherData() {
  temperature = random(10, 30);
  humidity = (int) random(0, 100);
  temperatureCelsius = random(10, 30);

  float weatherValue = random(0, 1);
  if (weatherValue < 0.2) {
    weatherCondition = "Sunny";
  } else if (weatherValue < 0.3) {
    weatherCondition = "Cloudy";
  } else if (weatherValue < 0.6) {
    weatherCondition = "Rainy";
  } else if (weatherValue < 0.8) {
    weatherCondition = "Snowy";
  } else {
    weatherCondition = "Windy";
  }
}
//generateRandomWeatherData() ends


void generateRandomForecastData() {
  for (int i = 0; i < weatherData.length; i++) {
    weatherData[i][0] = random(0, 30); //Temperature
    weatherData[i][1] = (int) random(0, 100); //Humidity
    float weatherValue = random(0, 1);
    if (weatherValue < 0.2) {
      weatherData[i][2] = 0; //Sunny
    } else if (weatherValue < 0.3) {
      weatherData[i][2] = 1; //Cloudy
    } else if (weatherValue < 0.6) {
      weatherData[i][2] = 2; //Rainy
    } else if (weatherValue < 0.8) {
      weatherData[i][2] = 3; //Snowy
    } else {
      weatherData[i][2] = 4; //Windy
    }
  }
}
//generateRandomForecastData() ends


void displayWeather() {
  fill(0);
  textSize(24);
  text("Easy-Peasy Weather, GURRLLL!", width / 2, 80);

  textSize(18);
  
  // Converting temperature based on the user's selection
  float displayedTemperature = convertTemperature(temperatureCelsius, temperatureUnit);
  
  text("Temperature: " + nf(displayedTemperature, 0, 1) + getTemperatureUnitSymbol(), width / 2, height / 4);
  text("Humidity: " + humidity + "%", width / 2, height / 4 + 116);
  text("Weather Condition: " + weatherCondition, width / 2, height / 4 + 150);

  drawWeatherIcon(width / 2, height / 2 + 100, weatherCondition);
}
//displayWeather() ends


void drawTemperatureGraph(float x, float y) {
  float graphWidth = 400;
  float graphHeight = 100;

  //Drawing x-axis
  stroke(0); // Set color for the axis lines
  line(x - graphWidth / 2, y, x + graphWidth / 2, y);
  
  //Drawing y-axis
  line(x - graphWidth / 2, y - graphHeight, x - graphWidth / 2, y);

  //Drawing label for weather forecast
  textSize(16);
  fill(0); // Set color for the text
  textAlign(CENTER, CENTER);
  text("Weather Forecast for Next 5 Days", x, y - graphHeight - 20);

  //Drawing the colorful graph
  beginShape();
  for (int i = 0; i < weatherData.length; i++) {
    float xPos = map(i, 0, weatherData.length - 1, x - graphWidth / 2, x + graphWidth / 2);
    
    // Modify the yPos mapping to start from the bottom and increase upwards
    float yPos = map(weatherData[i][0], 0, 40, y, y - graphHeight);

    float gradientColor = map(weatherData[i][0], 0, 40, 200, 0);
    fill(gradientColor, 100, 200);
    
    vertex(xPos, yPos);
    ellipse(xPos, yPos, 10, 10);

    hoverDetails[i] = (dist(mouseX, mouseY, xPos, yPos) < 20 / 2);
  }
  endShape();
  
  //Drawing the dots on top of the graph that have an additional hover feature
  for (int i = 0; i < weatherData.length; i++) {
    float xPos = map(i, 0, weatherData.length - 1, x - graphWidth / 2, x + graphWidth / 2);
    float yPos = map(weatherData[i][0], 0, 40, y, y - graphHeight);
  
    fill(245, 17, 222); // Setting color for the dots
    //fill(0, 40, 200); 
    ellipse(xPos, yPos, 10, 10);
  }
  
  //Drawing labels here
  textSize(12);
  fill(0); // Setting color for the labels
  textAlign(CENTER, CENTER);
  
  //X-axis labels
  for (int i = 0; i < temperatures.length; i++) {
    float xPos = map(i, 0, temperatures.length - 1, x - graphWidth / 2, x + graphWidth / 2);
    text("Day " + (i + 1), xPos, y + 20);
  }

  //Y-axis labels
  for (int i = 40; i >= 0; i -= 10) {
    float yPos = map(i, 0, 40, y, y - graphHeight);
    text(nf(i, 0, 0) + "°C", x - graphWidth / 2 - 20, yPos);
  }

  //X-axis label
  text("Days", x, y + 40);
  //Y-axis label
  pushMatrix();
  translate(x - graphWidth / 2 - 60, y - graphHeight / 2);
  rotate(-HALF_PI);
  text("Temperature (°C)", 0, 0);
  popMatrix();
  
  //Drawing the hover details that appear on top of the graph
  for (int i = 0; i < hoverDetails.length; i++) {
    if (hoverDetails[i]) {
      // Displaying additional details for the selected day in a yellow-ish box
      fill(255, 243, 133, 239); // Defining the yellow backdrop here
      float xPos = map(i, 0, weatherData.length - 1, x - graphWidth / 2, x + graphWidth / 2);
      float yPos = map(weatherData[i][0], 0, 40, y, y - graphHeight);
      float rectWidth = 200;
      float rectHeight = 100;
  
      //using quad function to draw a rectangle, so it doesn't clash with the rectangles used as buttons in the temperature converter tab
      quad(xPos - rectWidth / 2, yPos - 30 - rectHeight / 2,  // Upper-left corner
           xPos + rectWidth / 2, yPos - 30 - rectHeight / 2,  // Upper-right corner
           xPos + rectWidth / 2, yPos - 30 + rectHeight / 2,  // Bottom-right corner
           xPos - rectWidth / 2, yPos - 30 + rectHeight / 2); // Bottom-left corner
  
      fill(0);
      textSize(14);
      text("Day " + (i + 1) + " Details", xPos, yPos - 50);
      text("Temperature: " + nf(weatherData[i][0], 0, 1) + "°C", xPos, yPos - 30);
      text("Humidity: " + nf(weatherData[i][1], 0, 0) + "%", xPos, yPos - 15);
      text("Weather: " + getWeatherConditionName(weatherData[i][2]), xPos, yPos);
    }
  }
}
//drawTemperatureGraph() ends


String getWeatherConditionName(float condition) {
  switch (int(condition)) {
    case 0:
      return "Sunny";
    case 1:
      return "Cloudy";
    case 2:
      return "Rainy";
    case 3:
      return "Snowy";
    case 4:
      return "Windy";
    default:
      return "Unknown";
  }
}
//getWeatherConditionName() ends
