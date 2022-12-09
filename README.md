### 🦄 Bounce
> Don't live the same day twice.

<p align="center">
  <img width="600" src="https://user-images.githubusercontent.com/88988886/206556258-a280dea0-8b40-4220-af6c-0e6de66c23f6.png">
</p>

## Description

Bounce is an iOS app that randomizes your day based on your inputs. Users can get started by entering in a few things that they'd typically do in the mornings, afternoons, and evenings, as well as setting up their sleeping preferences. Bounce then takes a handful of these events to create a personalized, yet random, schedule for the day. 

## Why?

### It's fun.
Bounce is intended to be a fun app more than anything else. This idea struck me when COVID-19 first hit and I found myself repeating my days during quarantine. Things quickly became bland. I enjoy spontaneity and the element of surprise. I think it's very fun leaving the fate of your day in the hands of an algorithm.

### More growth!
Adding onto the fact that it's fun, I'm a believer in that we grow through experience. But I noticed that many people have a tendency to not take initiative in trying new things. Bounce is an attempt to encourage new experiences. The idea is that most people have the time to try the things that they want to try, but they just don't know how to make the time.

**Bounce sets up the experience for you. All you have to do is live it.**

<br>
<p align="center">
  <img width="800" src="https://user-images.githubusercontent.com/88988886/206617311-bfdf14e1-4037-4383-a9ce-ff70d5fd2729.png">
</p>
<br>

## Future Considerations

### Queue

These are the features that I'd like to add:

1. Allow pinned events
   - Pin specific events in the library page so that they show up on every schedule
   - ex) going to school on the weekdays
2. Add sorting options for the Library page
   - Include an add button for the library page so that users don't have to navigate all the way back to the Add page
   - Provide sorting options by event name, duration, and daytime
3. Improve scheduling algorithm
   - Currently, the scheduling algorithm slots in events consecutively either in the morning, afternoon, or evening phase
   - ex) if the only afternoon event in the library is "running", it will always show up at 12pm
   - Edit the algorithm so that even if "running" is the only afternoon event, it may still show up anytime between 12pm and 5pm (which is range for the afternoon phase)
4. Fix `placeLabel` bug
   - When a user first sets his/her preference, the location/weather label doesn't update correctly
   - Instead, it's still labelled as "Go get set up!" even though the user has already set up
   - Once the user force refreshes the app, the label behaves appropriately and updates the location and weather
