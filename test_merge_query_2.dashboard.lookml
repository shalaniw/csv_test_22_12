- dashboard: test_merge_query_2
  title: Test Merge Query 2
  extends: test_merge_queries
  layout: newspaper
  preferred_viewer: dashboards-next
  preferred_slug: 6aoUsFaJLzL1zwMNdEwAcy
  elements:
  - name: Test Merge Query 2
    title: Test Merge Query 2
    merged_queries:
    - model: test_project_w_connection
      explore: order_items
      type: table
      fields: [order_items.sku_num, order_items.item_amount_subjective, order_items.order_id]
      filters:
        order_items.order_id: "<20000"
      sorts: [order_items.sku_num]
      limit: 500
    - model: test_project_w_connection
      explore: users
      type: table
      fields: [users.just_time_as_strins, users.count, users.id]
      sorts: [users.count desc 0]
      limit: 500
      join_fields:
      - field_name: users.id
        source_field_name: order_items.order_id
    type: table
    row:
    col:
    width:
    height:
