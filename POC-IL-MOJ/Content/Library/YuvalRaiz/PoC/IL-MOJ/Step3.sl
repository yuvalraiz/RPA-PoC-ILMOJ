namespace: YuvalRaiz.PoC.IL-MOJ
flow:
  name: Step3
  workflow:
    - sql_query_all_rows:
        do:
          io.cloudslang.base.database.sql_query_all_rows:
            - db_server_name: "${get_sp('YuvalRaiz.PoC.IL-MOJ.db_servername')}"
            - db_type: PostgreSQL
            - username: "${get_sp('YuvalRaiz.PoC.IL-MOJ.db_username')}"
            - password:
                value: "${get_sp('YuvalRaiz.PoC.IL-MOJ.db_password', None)}"
                sensitive: true
                prompt:
                  type: text
            - database_name: "${get_sp('YuvalRaiz.PoC.IL-MOJ.db_database_name')}"
            - command: 'select line_id,court_id,email_timestamp::date,email_from,all_ids,file_path from poc_ilmoj where not uploaded ;'
            - trust_all_roots: 'true'
            - col_delimiter: _;_
            - row_delimiter: '_|_'
        publish:
          - all_lines: '${return_result}'
        navigate:
          - SUCCESS: handle_upload_to_website
          - FAILURE: on_failure
    - handle_upload_to_website:
        loop:
          for: "line_data in all_lines.split('_|_')"
          do:
            YuvalRaiz.PoC.IL-MOJ.internals.handle_upload_to_website:
              - line_id: "${line_data.split('_;_')[0]}"
              - court_id: "${line_data.split('_;_')[1]}"
              - email_date: "${line_data.split('_;_')[2]}"
              - sender: "${line_data.split('_;_')[3]}"
              - all_names: "${line_data.split('_;_')[4]}"
              - pdf_path: "${line_data.split('_;_')[5]}"
          break:
            - FAILURE
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      sql_query_all_rows:
        x: 60
        'y': 104
      handle_upload_to_website:
        x: 258
        'y': 104
        navigate:
          9d9df04e-e858-e16c-ad5d-db8a185c000e:
            targetId: 0ef05091-fa9b-50d9-0b26-01224ce2e2d8
            port: SUCCESS
    results:
      SUCCESS:
        0ef05091-fa9b-50d9-0b26-01224ce2e2d8:
          x: 509
          'y': 98
