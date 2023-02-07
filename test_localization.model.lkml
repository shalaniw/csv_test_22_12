connection: "bigquery_standard_sql"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

connection: "looker_external"
label: "whole_model_label"

include: "*.dashboard"
include: "view.view.lkml"

datagroup: localized_datagroup {
  label: "datagroup_label"
  description: "datagroup_description"
  max_cache_age: "24 hours"
}

explore: users {
  label: "user_explore_label"
  description: "user_explore_description"
}

view: users1 {
  sql_table_name: users;;

  dimension: hello_name {
    label: "hello"
    sql: ${TABLE}.name ;;
    description: "hello_description"
    view_label: "view_label_for_users"
  }

  dimension: liquid_name {
    label: "with_liquid"
    sql: ${TABLE}.name ;;
    description: "with_liquid"
    view_label: "with_liquid"
  }

  dimension: some_yesno_localized {
    label: "hello"
    type: yesno
    sql: ${TABLE}.name = "foo" ;;
  }

  dimension: some_yesno_label_only {
    label: "some yesno label"
    type: yesno
    sql: ${TABLE}.name = "foo" ;;
  }

  dimension_group: a_time_dim_group {
    label: "field_group_label_key"
    sql: ${TABLE}.created_at ;;
    type: time
    view_label: "view_label_for_users"
  }

  dimension_group: a_time_dim_group_with_group_label {
    label: "hello"
    group_label: "field_group_label_key"
    sql: ${TABLE}.created_at ;;
    type: time
    view_label: "view_label_for_users"
  }

  dimension_group: a_duration_dim_group {
    label: "field_group_label_key"
    type: duration
    sql_start: ${TABLE}.created_at ;;
    sql_end: NOW() ;;
    view_label: "view_label_for_users"
  }

  dimension: hello_view_name {
    label: "hello"
    view_label: "view_label_for_users_2"
    sql: ${TABLE}.name ;;
  }

  dimension: hello_view_name_hardcoded {
    label: "hello"
    view_label: "Hardcoded String Not Localized"
    sql: ${TABLE}.name ;;
  }

  dimension: name_with_default {
    label: "label_that_defaults"
    view_label: "hello_view_name_hardcoded"
    sql: ${TABLE}.name ;;
  }

  dimension: name_refs_unimplemented_key {
    label: "forgot_to_implement_in_french"
    view_label: "hello_view_name_hardcoded"
    sql: ${TABLE}.name ;;
  }

  dimension: hello_name_no_view_label {
    label: "hello"
    sql: ${TABLE}.name ;;
    description: "hello_description"
  }

  parameter: with_allowed_values {
    allowed_value: {
      label: "hello"
      value: "some_value"
    }
    allowed_value: {
      value: "some_other_value"
      label: "hello_description"
    }
  }

  dimension: use_parameter_with_allowed_values {
    label_from_parameter: users1.with_allowed_values
    sql: ${TABLE}.name ;;
  }

  dimension: with_field_group_label {
    sql: ${TABLE}.name ;;
    group_label: "field_group_label_key"
  }

  dimension: with_links {
    sql: ${TABLE}.name ;;
    link: {
      label: "hello"
      url: "https://www.example.com"
    }
  }

  dimension: specifying_variant_1 {
    sql: ${TABLE}.name ;;
    view_label: "view_label_for_users"
    group_label: "field_group_label_key"
    group_item_label: "hello"
    label: "hello_description"
  }

  dimension: specifying_variant_2 {
    sql: ${TABLE}.name ;;
    view_label: "view_label_for_users"
    group_label: "field_group_label_key"
    group_item_label: "user_explore_group_label"
    label: "view_label_for_users_2"
  }

  dimension: with_lookml_case_when {
    case: {
      when: {
        sql: ${TABLE}.name LIKE 'A%';;
        label: "{{_localization[\"hello\"]}}"
      }
      when: {
        sql: ${TABLE}.name LIKE 'x%';;
        label: "{{_localization[\"confirmed\"]}}"
      }
      when: {
        sql: ${TABLE}.name LIKE 'D%';;
        label: "{{_user_attributes[\"first_name\"]}}"
      }
      else: "{{_localization[\"goodbye\"]}}"
    }
    allow_fill: yes
  }

  dimension: label_case {
    case: {
      when: {
        label: "Less than {{ _user_attributes[\"first_name\"] }}"
        sql: ${TABLE}.name < '{{ _user_attributes['first_name'] }}' ;;
      }
      when: {
        label: "No dimension between {{ _user_attributes[\"first_name\"] }} and {{ _user_attributes[\"first_name\"] }}"
        sql: ${TABLE}.name >= '{{ _user_attributes['first_name'] }}' AND ${TABLE}.name < '{{ _user_attributes['first_name'] }}' ;;
      }
      when: {
        label: "Between AAA and mmm"
        sql: ${TABLE}.name >= '{{ _user_attributes['first_name'] }}' AND ${TABLE}.name < '{{ _user_attributes['last_name'] }}' ;;
      }
      else: "{{ _user_attributes[\"last_name\"] }} and Above"
    }
    allow_fill: yes
  }
}

explore: users_with_group_label {
  from: users
  group_label: "user_explore_group_label"
}

explore: users_data_actions {}
view: users_data_actions {
  extends: [users]

  dimension: with_actions {
    sql: ${TABLE}.name ;;
    action: {
      label: "hello"
      url: "https://www.example.com"

      form_param: {
        label: "hello"
        description: "hello_description"
        type: select
        name: "some_form_param"
        option: {
          label: "hello"
          name: "some_option"
        }
      }
    }
  }
}

explore: test_liquid_rendering {}
view: test_liquid_rendering {
  sql_table_name: users ;;

  dimension: test_good {
    sql: '{{ _localization['hello'] }}' ;;
  }

  dimension: test_bad_not_localized {
    sql: '{{ _localization['definitely_not_localized'] }}' ;;
  }

  dimension: test_bad_missing_from_french {
    sql: '{{ _localization['forgot_to_implement_in_french'] }}' ;;
  }
}

explore: users_with_join {
  from: users
  view_label: "view_label_for_users_2"
  join: users_joined {
    relationship: one_to_one
    from: users
    sql_on: ${users_joined.hello_name} = ${users_with_join.hello_name} ;;
    view_label: "a_view_label_in_a_join"
  }
}
