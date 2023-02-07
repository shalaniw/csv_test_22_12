view: orders {
  sql_table_name: `thelook.orders`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: arr {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]datatype:  date
    sql:  ${TABLE}.created_at ;;
    html: {{rendered_value | date: "%d/%m/%Y"}} ;;
  }

  dimension_group: created_test {
    type: time
    timeframes: [
      date,
      week,
      month
    ]
    sql: ${TABLE}.created_at ;;
    html: {{ rendered_value | date: "%d/%m/%Y" }} ;;
  }

  dimension_group: since_event {
    description: "new group"
    type: duration
    intervals:  [hour, day]
    sql_start:  ${created_date};;
    sql_end:  CURRENT_TIMESTAMP();;
  }

  dimension: order_amount {
    type: number
    sql: ${TABLE}.order_amount ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.name,
      users.id,
      hundred_million_orders.count,
      billion_orders.count,
      billion_orders_wide.count,
      hundred_million_orders_wide.count,
      order_items.count
    ]
  }
}
