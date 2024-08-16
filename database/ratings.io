// Replication:
// - master-slave (async)
// - replication factor 3
//
// Sharding:
// - key based by user_id

// PostgreSQL

Table ratings {
  post_id string
  user_id string
  rating string
  created_at timestamp [default: 'now()']
}