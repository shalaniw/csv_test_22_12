view: users {
  sql_table_name: `looker_test.users`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: just_time {
    type: string
    sql: ${TABLE}.created_at_time ;;
  }

  dimension: date_as_string {
    sql: ${TABLE}.created_at ;;
  }

  dimension: date_as_date {
    type:  date
    sql: ${TABLE}.created_at ;;
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

dimension: date_of_birth_dash {
  sql: ${created_date} ;;
  html: {{rendered_value | date: "%m/%d/%Y"}} ;;
}

  dimension: date_no_time {
    type: string
    sql: EXTRACT(DATE FROM ${TABLE}.created_at) ;;
  }

  dimension: time_as_strins {
    type: string
    sql: ${TABLE}.created_at ;;
  }

  dimension: just_time_as_strins {
    type: string
    sql: EXTRACT(TIME FROM ${TABLE}.created_at) ;;
  }

  dimension: time_as_date {
    type: date_time
    sql: ${TABLE}.created_at ;;
  }

  dimension: epoch_at {
    type: number
    sql: ${TABLE}.epoch_at ;;
  }

  dimension: start_time {
    group_label: "Start"
    label: "Start Time"
    type: date_time
    convert_tz: no
    sql: ${TABLE}.created_at ;;
    html:{{ value | date: "%h %e, %Y %I:%M %P" }};;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: yyyymmdd_at {
    type: number
    sql: ${TABLE}.yyyymmdd_at ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: ppi {
    fields: [
      name,
      age
    ]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      orders_base_copy.count,
      orders.count,
      orders_date_string.count,
      orders_date_string_test2.count,
      vijaya_order_test.count
    ]
  }
}
