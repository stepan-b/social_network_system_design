# System design of an adventure social network - [System Design course](https://github.com/Balun-courses/system_design)
The homework for the course of [System Design](https://github.com/Balun-courses/system_design) describing a social network of adventures architecture 
## Functional requirements:
- Gets post data(text, an image, a geolocation) from a user
- Saves the posts
- Gets the feed from the 'newest' posts to the 'oldest' ones
- Searches popular places, show posts with these places
- Subscribes/unsubscribes to other users
- Rates posts of other people
- Comments posts of other people

## Non-functional requirements:
- DAU 20 000 000(taking into account growth over 2 years), linear growth
- Always stores the data
- Max 1 000 000 subscriptions
- 1 request returns 10 posts
- Timing
  - Add a post - 2 sec
  - Search posts by geo - 2-3 sec
  - Load the feed - 2-3 sec
- Behavior
  - A post - 1 image, text(150 symbols), geolocation
  - 1 post every three days
  - Peak load during the holiday and vacation season - 1 post per day
  - Feed view - twice a day
  - In average, one user views 20 posts at once
  - One comment per day(100 symbols)
  - Peak load - 3 comments per day
  - 5 ratings per day
  - Peak load - 10 ratings per day
- Geo distribution is not needed
- Availability 99.95%

## Basic calculations
<ins>Posts</ins>:

    RPS(write): 20 000 000 / 3 / 86400 = 77
    RPS(peak load - write): 20 000 000 / 86400 = 231
    RPS(read): 20 000 000 * 2 *20 posts/ 86400 = 9260

<ins>Comments</ins>:

    RPS(write): 20 000 000 / 86400 = 231
    RPS(peak load - write): 20 000 000 * 3 / 86400 = 694

<ins>Ratings</ins>
    
    RPS(write): 20 000 000 * 5 / 86400 = 1160
    RPS(peak load - write): 20 000 000 * 10 / 86400 = 2315

**post(~500Kb)**:

    id
    user_id
    image - 500Kb
    title
    text - 300byte
    geolocation
    created_at

**comment(200byte)**

**rating(50byte)**

## Traffic
Post_write: 

    77 * 500Kb(post 500Kb + comment 200byte + rating 50byte = ~500Kb) = 38 Mb/s

Peak Load - Post_write: 

    231 * 500Kb = 115 Mb/s

Post_read: 

    9260 * 500Kb = 4.5 Gb/s

Comment_write: 

    231 * 200byte = 46 Kb/s

Peak Load - Comment_write: 

    694 * 200byte = 140 Kb/s

Rating_write: 
    
    1160 * 50byte = 58 Kb/s

Peak Load - Rating_write: 

    2315 * 50byte = 116 Kb/s

**Read oriented system**

Required memory:

    Posts

    Replication factor = 3
    Service operation time = 1 year
    Сapacity = 75 MB/s(average traffic, considering peaks) * 86 400 * 365 = 2PB
    Disks_for_capacity = 2 / 0.1 = 20
    Disks_for_throughput = 75MB/s / 500MB/s = 0.15
    Disks_for_iops = 9500 / 1000 = 9.5
    Disks = max(ceil(20), ceil(0.15), ceil(9.5)) = 20

    20 SSD (SATA)

    Comments

    Replication factor = 3
    Service operation time = 1 year
    Сapacity = 95 KB/s(average traffic, considering peaks) * 86 400 * 365 = 3TB
    Disks_for_capacity = 3 / 32 = 0.09
    Disks_for_throughput = 0.09MB/s / 100MB/s = 0.0009 
    Disks_for_iops = 700 / 100 = 7
    Disks = max(ceil(0.09), ceil(0.0009), ceil(7)) = 7

    7 HDD
