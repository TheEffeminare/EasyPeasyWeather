//exploring the implementation of a weather visualization app called "Easy-Peasy Weather"
//The app shows weather details for the current day (temperature, humidity and weather condition), including weather forecasts for the next 5 days.
//The user gets to choose from 6 cities currently to showcase weather details for the city
//For UI implementation we have explored the module ControlP5. To successfully run this app, please ensure ControlP5 is installed in your sketch library (Sketch > Import Library > ControlP5).

import processing.data.*;
import controlP5.*;
float temperature;
int humidity; //integer because unlike temperature we're dealing with integer percent values here.
String weatherCondition;
PImage weatherIcon;
PImage cityBackground;
String[] cities = { "Cork","Beijing", "Perth", "Svalbard", "Dubai", "Khartoum"}; // defining the 6 cities to pick from the drop-down here
String currentCity;


ControlP5 cp5;

// mapping city names with their repsective bacground image files 
HashMap<String, String> cityBackgroundMap;


void setup() {
  size(800, 800); //defining window size
  surface.setTitle("Easy-Peasy Weather App"); //defining window title here
  textAlign(CENTER, CENTER);
  
  //all pngs saved inside data folder. Weather PNGs downloaded via Flaticon.com.
  sunnyIcon = loadImage("sunny.png");
  cloudyIcon = loadImage("cloudy.png");
  rainyIcon = loadImage("rainy.png");
  snowyIcon = loadImage("snowy.png");
  windyIcon = loadImage("windy.png");

  generateRandomWeatherData();
  generateRandomForecastData(); 
  temperatureUnit = 0;
  
  cp5 = new ControlP5(this); //new cp5 variable created to use the Control P5 library for a dropdown list implemented
  
  DropdownList cityDropdown = cp5.addDropdownList("cityDropdown")
                                 .setPosition(50, 50)
                                 .setSize(150, 200)
                                 .setBarHeight(30)
                                 .setItemHeight(30);

  cityDropdown.getCaptionLabel().getStyle().marginTop = 3; 
  
  for (int i = 0; i < cities.length; i++) {
    cityDropdown.addItem(cities[i], i+1);  //populating dropdown named cityDropdown with items from the cities 'array'
  }
  
  CityDropdownListener listener = new CityDropdownListener(); //class CityDropdownListener defined below
  cityDropdown.addListener(listener); //by adding a listener to the dropdown component, we can respond to user actions, such as selecting an item from the dropdown. 
  
  initializeCityBackgroundMap();
  selectCity(cityDropdown);
}
//setup ends

void initializeCityBackgroundMap() {
  cityBackgroundMap = new HashMap<String, String>(); //populated values are being called later in loadBackgroundImageForCity() function written below
  cityBackgroundMap.put("Cork", "cork.jpg");
  cityBackgroundMap.put("Beijing", "beijing.jpg");
  cityBackgroundMap.put("Perth", "perth.png");
  cityBackgroundMap.put("Svalbard", "svalbard.png");
  cityBackgroundMap.put("Dubai", "dubai.png");
  cityBackgroundMap.put("Khartoum", "khartoum.png");
}
//initializeCityBackgroundMap ends

//defining the class 'CityDropdownListener'
class CityDropdownListener implements ControlListener {
  @Override //The override annotation indicates here that the controlEvent method is intended to override the method declared in the ControlListener interface.
  //also added for sanity-check, helps the compiler catch errors at compile time
  public void controlEvent(ControlEvent event) {
    if (event.isFrom("cityDropdown")) {
      selectCity(cp5.get(DropdownList.class, "cityDropdown")); //When event originates from "cityDropdown," this invokes the selectCity function and provides the DropdownList control with the name "cityDropdown" as an argument.
    }
  }
}
//CityDropdownListener ends


//the selectCity method is designed to handle the selection of a city from a DropdownList. 
//It updates the currentCity variable, loads weather data for the selected city, loads a background image for the selected city, 
//and handles the case where the selected index is out of bounds.
void selectCity(DropdownList d) {
  int index = (int) d.getValue();
  if (index >= 0 && index < cities.length) {  
    currentCity = d.getItem(index).get("name").toString();
    loadWeatherDataForCity(currentCity);
    loadBackgroundImageForCity(currentCity);
  } else {
    // Handling the case when the index is out of bounds, defined to check since we were earlier getting an error here 
    println("Invalid index: " + index);
  }
}
//selectCity ends

//function to load city specific weather data, and eventually forecast for 5 days.
void loadWeatherDataForCity(String city) {
  generateRandomWeatherData(); //function details mentioned under graph implementation tab
  generateRandomForecastData(); //function details mentioned under graph implementation tab
  
}

void loadBackgroundImageForCity(String city) {
  // loading the background image based on the selected city
  String backgroundImageFile = cityBackgroundMap.get(city); //referring to values populated above in initializeCityBackgroundMap() function
  if (backgroundImageFile != null) {
    cityBackground = loadImage(backgroundImageFile);
  }
}
//loadBackgroundImageForCity ends
