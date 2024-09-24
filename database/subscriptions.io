// Replication:
// - master-slave (async)
// - replication factor 3
//
// Sharding:
// - key based by user_id

// PostgreSQL

Table subscriptions {
  user_id string [pk, note: 'User ID']
  subscriptions string [note: 'List of users ids(subscriptions)']
  created_at timestamp [default: 'now()']
}