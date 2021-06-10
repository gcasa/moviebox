# Assignment Summary

What follows is a discussion of portions of the application and how they were written.   

## Discussion of implementation of RatingView
For the RatingView I wrote some code to do a pie chart.  I then made sure it was generating the chart accurately.   Once it was I updated the code to draw a filled circle using the background color inside and then rendered the percentage text in the center.

- Ways this could be improved:  
I could change the code to use a single line arc of a given thickness. 
The Text could be centered slightly better.

## Image Caching
Image caching done in the app is simple.  I am simply caching the image based on the URL used to retrieve it.  Once it is cached the app should not have to retrieve it from the API again until the app is restarted.  The images are returned asynchronously.

## General approach
The MovieService is the main place where all of the data gets retrieved.  When the ViewController gets invoked the first cell that is built for the tableView is the horizontally scrolling UICollectionView.   When clicked these cells will take you to the detail view.   Also on the popular movie list, when you click on the cells it will take you also to the detail list.   The details of the movies are returned as arrays of dictionaries.  To keep things simple I am simply using the dictionaries as they are returned.   This leaves the code sensitive to the format in which these are returned (i.e. the keys).   A slightly better approach might be to put this data into a model so that it is abstracted from the dictionary being returned by the API.  For the interests of time this was not done.

## Pagination
The pagination code simply looks to see when the user has reached the end of the existing page of movies and adds the new one.  A smarter way of doing this would be to pre-load the first two pages and then keep ahead of the user by one or two pages as the user scrolls across page boundaries.  For the interest of time I didn't do the more advanced approach.

## Third Party Libraries
* None