namespace: YuvalRaiz.PoC.IL-MOJ.internals
flow:
  name: store_income_data
  inputs:
    - email_rcpt_date
    - email_from
    - email_subject
    - court_id
    - all_persons
    - pdf_path
  workflow:
    - sql_command:
        do:
          io.cloudslang.base.database.sql_command:
            - db_server_name: "${get_sp('YuvalRaiz.PoC.IL-MOJ.db_servername')}"
            - db_type: PostgreSQL
            - username: "${get_sp('YuvalRaiz.PoC.IL-MOJ.db_username')}"
            - password:
                value: "${get_sp('YuvalRaiz.PoC.IL-MOJ.db_password')}"
                sensitive: true
            - database_name: "${get_sp('YuvalRaiz.PoC.IL-MOJ.db_database_name')}"
            - command: |-
                ${'''insert into poc_ilmoj (email_timestamp, email_from, email_subject, court_id, all_ids, file_path)
                values ('%s','%s','%s','%s','%s','%s')''' % (email_rcpt_date, email_from, email_subject.replace("'","''"), court_id, all_persons.replace("'","''"), pdf_path )}
            - trust_all_roots: 'true'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      sql_command:
        x: 117
        'y': 124
        navigate:
          c6204b15-a4a3-585b-e332-2692c3ca3c5e:
            targetId: 82fec0a1-feb7-1bb1-e3d9-f025c8f824a8
            port: SUCCESS
    results:
      SUCCESS:
        82fec0a1-feb7-1bb1-e3d9-f025c8f824a8:
          x: 354
          'y': 106
