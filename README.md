**TTC Stops and Routes**

An app that shows all bus stops and routes for TTC Finch Station.

This app does not use storyboards except in the launch screen.   

---

## Features

### Loading Indicator  
- Displays a loading indicator when fetching from the API  
![](/Previews/first-fetch.png)  

### Main Page  
- The main page shows all the available stops for Finch station.  
- By default, stops with no routes are hidden.  
- A speedometer icon is displayed beside the departure time when the actual time (UTC-4 was used to follow the departure time) is 10 minutes or less before the time departure.  
- Date of the trip schedule is also displayed below the title bar.  
![](/Previews/stops-routes.png)  

### Pull to refresh  
- Table can be pulled down to fetch the latest trip schedule.  
![](/Previews/pull-reload.png)  

### Detail View  
- When selecting a route; a detail view will show all available stops, route group ID, and the agency.  
- Shows the origin and destination of the trip.  
- The text color of the stop times may differ depending on the condition (Gray: already lapsed, Red: 10 minutes or less before departure, Black: 11 minutes or more before departure).  
- UTC-4 was used to calculate the time difference.  
![](/Previews/detail-view.png)  

### Settings
- In the Settings page, the user has the option to toggle and show all stops and or display a 24-hour time format instead of the AM-PM format.  
- The Settings page can be accessed by tapping the gear icon on the upper-left corner of the main page.  
- All of the setitngs configuration are off by default.  
- Configurations are changeable and will persist the set value.  
![](/Previews/settings.png)  

---

## Demo

![](/Previews/preview.gif)