# FlightsLocator


### Project Diagram

![screen shot 2019-01-15 at 12 27 24 pm](https://user-images.githubusercontent.com/6865674/51293692-d50a0980-19c4-11e9-8aa5-78622deac0c4.png)

### USER STORY:
 
As a Customer Service Agent, I need an easily-accessible list of flights arriving soon at the airport I work at, so that I know when to meet incoming flights.
 
### Acceptance criteria:
 
* The Agent can enter the three letter airport code they want arrival information for.
* The app should remember the airport that was previously selected.
* The list should display the flight number, three-letter origin airport code, and arrival time of the flight, in local time for the user.
* The list should show the flights arriving for the next hour, ordered by arrival time, with soonest at the top. 
* If the user force-quits and returns to the app, the list should still be visible.
* The app should not display data that is more than 10 minutes old.


### Flight Structure

```
{
		"FltId": "1259",
		"Carrier": "AS",
		"Orig": "SFO",
		"Dest": "SEA",
		"CutOffTime": "40",
		"FltDirection": 0,
		"SchedDepTime": "2019-01-15T08:15:00",
		"EstDepTime": "2019-01-15T08:15:00",
		"SchedArrTime": "2019-01-15T09:25:00",
		"EstArrTime": "2019-01-15T10:25:00",
		"ActualTime": "",
		"OrigZuluOffset": "-8",
		"DestZuluOffset": "-8",
		"DestGate": "D4",
		"OrigGate": "",
		"CodeShares": [{
			"FltId": "",
			"Carrier": ""
		}],
		"TailId": "282",
		"FleetType": "A3SE",
		"Status": "ON TIME"
	}
```

### Screenshots

| Initial State | Enter Search |
| --- | --- | 
| ![initial](https://user-images.githubusercontent.com/6865674/51293642-ac820f80-19c4-11e9-99da-d2ae0b23e06f.png) | ![enter-search](https://user-images.githubusercontent.com/6865674/51293648-b277f080-19c4-11e9-8757-d37cb396fb3c.png) |


| Search Results | Error Screen |
| --- | --- | 
| ![search-results](https://user-images.githubusercontent.com/6865674/51293653-b86dd180-19c4-11e9-8e4c-f4caf745530d.png) | ![error-screen](https://user-images.githubusercontent.com/6865674/51293661-bc015880-19c4-11e9-8453-66f806b0d53f.png) |








