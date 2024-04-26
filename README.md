# global-x-trending
This app features rotating/draggable globe using D3.js displaying recent tweets from all over the world.
Every hour the trending tweets displayed changes.
## Technologies used:
* Ruby on Rails (3.4.x)
* Express.js (latest version)
* D3.js (v.5)
* Topojson (v.2)
* Socket.io
* Redis
* Bootstrap
* Jquery (3.6.0)
* HTML/CSS

## Limitations:
Since this app leverages Twitter API /trends, there are requests and rate limits depending on the developer account type.
To simulate this project, this app only uses Free developer account which only has 1500 POST request limit per month.
Another issue is the recent API of Twitter (X API v2) doesn't allow Free accounts to access /trends endpoint.
For alternatives, I used RapidAPI - https://rapidapi.com/brkygt88/api/twitter-trends5 .
