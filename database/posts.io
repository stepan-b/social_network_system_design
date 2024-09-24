// Replication:
// - master-slave (async)
// - replication factor 3
//
// Sharding:
// - key based by user_id

// PostgreSQL

Table posts {
  id int [pk, note: 'Post ID']
  user_id string [note: 'User ID, a post creator']
  image_url string [note: 'Image URL']
  description string [note: 'Post description']
  rating string [note: 'Calculated post rating']
  geolocation string [note: 'Geolocation pinned in the post']
  created_at timestamp [default: 'now()']
}

// Blob storage

To save images of posts and then provide a link for the media files