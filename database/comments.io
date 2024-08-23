// Replication:
// - master-slave (async)
// - replication factor 3
//
// Sharding:
// - key based by post_id

// PostgreSQL

Table comments {
  id int
  post_id string
  user_id string
  text string
  created_at timestamp [default: 'now()']
}