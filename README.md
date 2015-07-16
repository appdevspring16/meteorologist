# Meteorologist

## Setup

 - **Fork** this repo to your own GitHub.com account.
 - Clone **your fork** to your own computer.
 - `cd` to the folder that you just downloaded.
 - `bundle install`
 - Open up the entire folder in Sublime.
 - `rails s`
 - Go to [http://localhost:3000](http://localhost:3000) in Chrome.
 
## Introduction

In this project, you will practice working with Arrays and Hashes by pulling data from external services like Google Maps. You will build an application that, given a street address, tells the user the weather forecast.

In order to achieve this, our first task will be to exchange a **street address** for a **latitude/longitude pair** using Google's Geocoding API.

We will send a location in a remarkably flexible, "English-y" format, the kind of thing we are allowed to type into a Google Maps search (e.g., "the corner of Foster and Sheridan"), and the Geocoding API will respond with an exact latitude and longitude (along with other things) in JSON format.

### Getting Started

Any time you are trying to develop a proof of concept of an app that needs external API data, the first step is researching the API and finding out if the information you need is available.

For us, that translates to: is there a URL that I can paste into my browser's address bar that will give back JSON (JavaScript Object Notation) that has the data I need? If so, we're good; Ruby and Rails makes the rest easy.

First, let's install a Chrome Extension called JSONView that makes working with JSON easier:

https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en

This will indent the JSON nicely and allow you to fold and unfold nested elements.

### Find an example

Now, we have to research the API and find the correct URL to paste into our address bar to get back the JSON that we want. Usually, we have to start at the API Documentation. For the Geocoding API, the full docs are here:

https://developers.google.com/maps/documentation/geocoding/

but, as usual with technical documentation, it's best once you skim the intro to head straight for the examples:

https://developers.google.com/maps/documentation/geocoding/#GeocodingResponses

The first example they give is

    http://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA

(I have removed the part about the API key from the end of the URL; we don't need one, for now.) Paste that URL into a Chrome tab; you should see something like this:

<img src='http://ask.initialversion.com/uploads/default/70/a1f0652613458d37.png' width="690" height="412"> 

I folded away the `address_components` section to make the value of the `geometry` key stand out, since that is where our target lives: the `lat` and `lng` keys within the `location` hash. Notice that JSON uses curly braces for Hashes and square brackets for Arrays just like Ruby does.

Also notice that when I hover my mouse over the `lat` value, the JSONView extension puts a hint about the path to get down to it starting all the way from the top in the status bar at the bottom-left of the browser window. That path is in JavaScript notation, but it's analagous to the Ruby we're going to eventually need.

Alright, now that we have the data we need showing up in the browser window, what's next? First of all, we should be sure that we can customize this example request to get data that we care about. So how would we get the coordinates of "the corner of Foster and Sheridan"? Give it a try.

It turns out we need to replace the part of the URL between the `?address=` and the `&` with the address we want Geocoded, but with one catch: spaces are not legal in URLs, so we have to **encode** them. One way to encode them can be seen in Google's example, with `+`s, so the following works:

<img src='http://ask.initialversion.com/uploads/default/71/38b10fea87e76ce9.png' width="690" height="412"> 

### Ruby

Great! Now we know the exact data we want is available through the API. Now, how do we get it into our application? Fortunately, Ruby comes with some powerful built-in functionality that will help us with this. First, we need Ruby to read the URL that has the JSON we want, just like Chrome did. Chrome has an address bar we can paste the URL in to; how can we tell Ruby to go open a page on the Internet?

Fire up a Rails Console session:

 - `cd` in to the root folder of this application.
 - `rails console` (or `rails c` for short)


Enter the following command: `require 'open-uri'`. This command loads a method called `open` from the Ruby Standard Library (which is part of Ruby but isn't loaded up by default because not every single Ruby script needs to open Internet pages). The `open` method takes one argument: a String containing a URL.

Create a variable called `url` and store within it a String containing the URL we discovered that has the data we want. Copy the URL directly from the address bar of your Chrome tab. Then, pass that variable as an argument to the `open` method:

    open(url)

<img src='http://ask.initialversion.com/uploads/default/72/8dbad5066edefcda.png' width="690" height="411">

What just happened? We `open`ed the page at `url`, and the return value was the HTTP response. The HTTP response is actually a complicated object, with headers and status codes and other things we haven't talked about yet. All we really want is the body of the response, the stuff that shows up in the browser window, so let's use the `.read` method to pull that out; and also, let's store the result in a variable called `raw_data`:

    raw_data = open(url).read

<img src='http://ask.initialversion.com/uploads/default/73/e2072db64c77b1f6.png' width="690" height="411"> 

Alright! We just used Ruby to open up a connection over the Internet to Google's servers, placed a request for them to translate our address into a latitude and longitude, and received a response! That's a big deal, folks. However, the response is hideous. How in the world are we going to pull out the latitude and longitude values from that thing?

Let's start to explore it:

<img src='http://ask.initialversion.com/uploads/default/74/10707f2a4ead6210.png' width="690" height="411">

That's a little nicer to look at. But still, it's going to be quite hard to get to the latitude and longitude. We could explore the [String][1] class documentation and find some methods that might help us scan through `raw_data` for `"lat"`, perhaps. But then what? We could probably figure it out, but there's a much better way.

Let's borrow some more code. First run the command

    require 'json'

and then

    parsed_data = JSON.parse(raw_data)

Now, explore the resulting object:

<img src='http://ask.initialversion.com/uploads/default/75/6367886cafcece2b.png' width="690" height="415">

Look! Hash rockets! We've converted a cumbersome JSON string into a beautiful, friendly Ruby Hash. Now, if I want to get down to the latitude and longitude, how would I do it? Well, remember, we already got a hint back when we first looked at the data in Chrome:

<img src='http://ask.initialversion.com/uploads/default/71/38b10fea87e76ce9.png' width="690" height="412">

`parsed_data` is a Hash (don't believe me? do `parsed_data.class` and `parsed_data.keys`). The data we want looks like it is inside the key "results". So lets step in one level deep:

<img src='http://ask.initialversion.com/uploads/default/76/cf85a534e4842664.png' width="690" height="415">

It doesn't look very much better, but we're closer to our goal. What class of object is in `results`? It's no longer a Hash; we can tell both in IRB and from looking at JSONView that it is an Array. Let's go one level deeper by getting the first element:

<img src='http://ask.initialversion.com/uploads/default/77/7a9c1a6fd8971b86.png' width="690" height="415">

Alright, so we now have a Hash in `first` that has a key called `"geometry"`, which, as we learned from our initial research above, is what contains our target. Let's keep going:

<img src='http://ask.initialversion.com/uploads/default/78/17fee7660bf4ee36.png' width="690" height="415">

Woo! We made it all the way down to what we want. Phew! Now, I did it in a bunch of tiny steps, which might have made it seem complicated, but we could also have just done it in one step:

<img src='http://ask.initialversion.com/uploads/default/79/bded96200cc14aa2.png' width="690" height="152">

I prefer working in small steps and peeling one layer off at a time while I am exploring. But, the entire program boils down to just three lines!

    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

## Part 1: Street &rarr; Coords

Now that we've seen how to retrieve information from a URL using Ruby, let's plug it in to a real application.

I have started you off with three forms:

 - [Street &rarr; Coords](http://localhost:3000/street_to_coords/new)
 - [Coords &rarr; Weather](http://localhost:3000/coords_to_weather/new)
 - [Street &rarr; Weather](http://localhost:3000/street_to_weather/new)
 
And three actions which process these form inputs and render results:

 - `app/controllers/geocoding_controller.rb`
 - `app/controllers/forecast_controller.rb`
 - `app/controllers/meteorologist_controller.rb`
 
We'll be working on [Street &rarr; Coords](http://localhost:3000/street_to_coords/new) first.


Open the file `app/controllers/geocoding_controller.rb`. Your job is to write some code in the `street_to_coords` method, where indicated, and put the correct value in the `@latitude` and `@longitude` variables.

If I type in `5807 S Woodlawn Ave` at the [Street &rarr; Coords form](http://localhost:3000/street_to_coords/new), I should see something like

<blockquote>
<dl>
  <dt>Street Address</dt>
  <dd>5807 S Woodlawn Ave</dd>
  
  <dt>Latitude</dt>
  <dd>41.7896234</dd>
  
  <dt>Longitude</dt>
  <dd>-87.5964137</dd>
</dl>
</blockquote>


## Part 2: Coords &rarr; Weather

Next, in `app/controllers/forecast_controller.rb`, you will do something similar; but instead of using Google's Geocoding API, you will use The Forecast API. We will exchange a latitude/longitude pair for weather information. Forecast is an amazing API that gives you minute-by-minute meteorological information.

They released an iOS app, Dark Sky, to demonstrate the power of their API, and it instantly became a smash hit. The API is not entirely free, but we get 1,000 calls per day to play around with.

Step 1 when working with any API is research. What is the URL of the page that has the data we want, preferably in JSON format?

Let's head over to [Forecast's API documentation][2]. First, we must register as developers:

<img src='http://ask.initialversion.com/uploads/default/80/ae376d887782c8bb.png' width="690" height="412"> 

You need not provide a real email address, if you don't want to. Once you register, you will be given an example link with your own personal API key inserted in a variable path segment:

<img src='http://ask.initialversion.com/uploads/default/81/80aa59c81d8cc53d.png' width="690" height="412"> 

#### Find an example

Click the example link and check out the data they provide. Scroll up and down and get a feel for it:

<img src='http://ask.initialversion.com/uploads/default/82/6a23cb4cd7f20112.png' width="690" height="412">

It's pretty amazingly detailed data; it tells us current conditions, along with minute-by-minute conditions for the next hour, hour-by-hour conditions for the next day or so, etc.

But first, can we customize the example to get data relevant to us? Plug in some coordinates that you fetched in `street_to_coords` and try it out.

Your job is to write some code in the `coords_to_weather` method, where indicated, and put the correct value in the instance variables at the end.

If I type in `41.78` and `-87.59` at the [Coords &rarr; Weather form](http://localhost:3000/coords_to_weather/new) , I should see something like

<blockquote>
<dl>
  <dt>Latitude</dt>
  <dd>41.78</dd>

  <dt>Longitude</dt>
  <dd>-87.59</dd>

  <dt>Current Temperature</dt>
  <dd>73.35</dd>

  <dt>Current Summary</dt>
  <dd>Clear</dd>

  <dt>Outlook for next sixty minutes</dt>
  <dd>Clear for the hour.</dd>

  <dt>Outlook for next several hours</dt>
  <dd>Partly cloudy tomorrow morning.</dd>

  <dt>Outlook for next several days</dt>
  <dd>No precipitation throughout the week, with temperatures falling to 62°F on Tuesday.</dd>
</dl>
</blockquote>

    
## Part 3: Address to Weather

Finally, pull it all together in `app/controllers/meteorologist_controller.rb`. Use both the Google Geocoding API and the Forecast API so that if I type in `5807 S Woodlawn Ave` at the [Street &rarr; Weather form](http://localhost:3000/street_to_weather/new), I should see something like

<blockquote>
<p>Here's the outlook for 5807 S Woodlawn Ave:</p>

<dl>
  <dt>Current Temperature</dt>
  <dd>73.35</dd>

  <dt>Current Summary</dt>
  <dd>Clear</dd>

  <dt>Outlook for next sixty minutes</dt>
  <dd>Clear for the hour.</dd>

  <dt>Outlook for next several hours</dt>
  <dd>Partly cloudy tomorrow morning.</dd>

  <dt>Outlook for next several days</dt>
  <dd>No precipitation throughout the week, with temperatures falling to 62°F on Tuesday.</dd>
</dl>
</blockquote>

## Submission

Remember to commit and sync your work to **your fork** of the repository on GitHub.com often, so that it will be easy for me to see what's up if you need help. **And ask lots of questions!** Really. Ask early and often.

Good luck!

## Optional Extra Exercises, for fun

### Programmable Web (Easier)

Browse [Programmable Web's API Directory](http://www.programmableweb.com/category/all/apis?order=field_popularity) and get inspired!

### Bootstrap (Easier)

`<link>` to Bootstrap or a Bootswatch in the `<head>` of your pages (located in `app/views/layouts/application.html.erb`), and make things look prettier.

You can take [Omnicalc](http://omnicalc-target.herokuapp.com/) as inspiration, or create something entirely new.

### Future Forecast (Harder)

The Forecast API can take a third parameter in the URL, time:

https://developer.forecast.io/docs/v2#time_call

Add a feature that shows summaries for the next 14 days.

### Google Map (Harder)

Embed a Google map in the view, centered on the provided address. Refer to the docs:

https://developers.google.com/maps/documentation/javascript/examples/map-simple

The key concept is, just like with Bootstrap, to first paste in the example markup and see if it works.

Then, replace whichever part of the static markup you want to with embedded Ruby tags that contain your dynamic values.


  [1]: http://www.ruby-doc.org/core-2.2.1/String.html
  [2]: https://developer.forecast.io/
