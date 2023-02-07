view: order_items {
  sql_table_name: `looker_test.order_items`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: sku_num {
    type: number
    sql: ${TABLE}.sku_num ;;
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id]
  }

  parameter: item_amount{
    label: "item_amount.label"
    description: "item_amount.description"
    type: string
    allowed_value: {
      label: "item_amount.not_that_many"
      value: "Not That Many"
    }
    allowed_value: {
      label: "item_amount.some"
      value: "Some"
    }
    allowed_value: {
      label: "item_amount.a_lot"
      value: "A Lot"
    }
  }

  dimension: item_amount_subjective {
    description: "item_amount_subjective.description"
    label_from_parameter: item_amount
    type: string
    sql:
    CASE
    WHEN {% parameter item_amount %} = 'Not That Many' THEN ${amount} < 1000
    WHEN {% parameter item_amount %} = 'Some' THEN ${amount} < 5000
    ELSE ${amount} < 7000
    END;;
  }
}
