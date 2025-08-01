Original App Design Project - 
===

# NexPlay

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

Users can discover and track video games across different platforms. Browse a list of games, view details like release dates and descriptions, and users can save their favorites to keep track of what they want to play.

### App Evaluation


- **Category:** Entertainment
- **Mobile:** Optimized for mobile to browse trending games in real time, view details, and save favorites. Pulls live data from a gaming API.
- **Story:** Helps gamers discover new titles and track favorites without needing multiple websites. Simple and fast game discovery.
- **Market:** Casual and dedicated gamers, plus streamers and reviewers. Monetization could come from affiliate links or feature upgrades.
- **Habit:** Users check regularly for new or popular games. Becomes part of their routine before buying or exploring games.
- **Scope:** 
    - V1: List of popular games, detail view, and favorites. 
    - V2: Add sorting options (e.g., by release date or rating).
    - V3: Filter by genre or platform. 
    - V4: Push notifications and trailer links. 


## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can view a list of popular video games.
* User can tap on a game to view detailed information (title, description, images, rating, release date, platform, genre).
* User can favorite a game to save it to their list.

**Optional Nice-to-have Stories**

* User can sort games by rating or release date.
* User can filter games by genre or platform.

### 2. Screen Archetypes

- [ ] Popular Games Screen
* User can view a list of popular video games.
* App pulls real-time data from a gaming API.
* User can tap a game to view more details.

- [ ] Game Detail Screen
* User can view detailed game info (images, rating, release date, platforms, genres)
* User can favorite or unfavorite a game.

- [ ] Favorites Screen
* User can view a list of their favorited games.
* User can tap a game to view more details.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Popular – shows a list of currently popular games.
* Favorites – shows the user’s saved/favorited games.
* Recent – recently viewed games.

**Flow Navigation** (Screen to Screen)

- [ ] Popular Games Screen
* → Game Detail Screen (when a game is tapped)
* → Favorites Screen (via bottom tab)

- [ ] Game Detail Screen
* → Back to previous screen (Popular, Favorites, or Recent)
* → Favorite or unfavorite the game

- [ ] Favorites Screen
* → Game Detail Screen (when a game is tapped)
* → Back to Popular or Recent (via bottom tab)

- [ ] Recent Screen
* → Game Detail Screen (when a game is tapped)
* → Back to Popular or Favorites (via bottom tab)

## Wireframes

[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_IMAGE_URL_HERE" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

[This section will be completed in Unit 9]

### Models

[Add table of models]

### Networking

- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
