view: csv_repro {

  derived_table: {
    sql:
      SELECT id AS order_id, status AS order_status
      FROM looker_test.orders

      UNION ALL

      SELECT id + 4500 AS order_id, status AS order_status
      FROM looker_test.orders
      ;;
  }

  dimension: order_id {
    type:  number
    sql: ${TABLE}.order_id ;;
  }

  dimension: order_status {
    type: string
    sql: ${TABLE}.order_status ;;
  }

  measure: count {
    type: count
    drill_fields: [order_id]
  }
}
