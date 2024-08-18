//code for implementation of the weather icons

PImage sunnyIcon;
PImage cloudyIcon;
PImage rainyIcon;
PImage snowyIcon;
PImage windyIcon;


void drawWeatherIcon(float x, float y, String weatherCondition) {
  //Setting the size for all icons as 13o by 130 units
  float iconSize = 130;

  if (weatherCondition.equals("Sunny")) {
    image(sunnyIcon, x - iconSize / 2, y - iconSize + 25, iconSize, iconSize);
  } else if (weatherCondition.equals("Cloudy")) {
    image(cloudyIcon, x - iconSize / 2, y - iconSize + 25, iconSize, iconSize);
  } else if (weatherCondition.equals("Rainy")) {
    image(rainyIcon, x - iconSize / 2, y - iconSize + 25, iconSize, iconSize);
  } else if (weatherCondition.equals("Snowy")) {
    image(snowyIcon, x - iconSize / 2, y - iconSize + 25, iconSize, iconSize);
  } else if (weatherCondition.equals("Windy")) {
    image(windyIcon, x - iconSize / 2, y - iconSize + 25, iconSize, iconSize);
  }
}
//drawWeatherIcon() ends
