# Assignment Summary

What follows is a discussion of portions of the application and how they were written.   

## Discussion of implementation of RatingView
For the RatingView I wrote some code to do a pie chart.  I then made sure it was generating the chart accurately.   Once it was I updated the code to draw a filled circle using the background color inside and then rendered the percentage text in the center.

- Ways this could be improved:  
I could change the code to use a single line arc of a given thickness. 
The Text could be centered slightly better.

## Image Caching
Image caching done in the app is simple.  I am simply caching the image based on the URL used to retrieve it.  Once it is cached the app should not have to retrieve it from the API again until the app is restarted.