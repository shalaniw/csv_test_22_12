- dashboard: test_merge_queries
  title: Test Merge Queries
  layout: newspaper
  preferred_viewer: dashboards-next
  preferred_slug: ssyXvX4fAAE9nC5bEfwgJM
  elements:
  - name: Test Merge Queries
    title: Test Merge Queries
    merged_queries:
    - model: test_project_w_connection
      explore: orders
      type: table
      fields: [orders.status, orders.user_id, orders.order_amount]
      filters:
        orders.order_amount: "<3"
      sorts: [orders.order_amount desc]
      limit: 500
    - model: snowflake_connection
      explore: users
      type: table
      fields: [users.id, users.age2, users.date_no_time]
      filters:
        users.age2: "<50"
      limit: 500
      join_fields:
      - field_name: users.id
        source_field_name: orders.user_id
    type: looker_grid
    series_types: {}
    row:
    col:
    width:
    height:
