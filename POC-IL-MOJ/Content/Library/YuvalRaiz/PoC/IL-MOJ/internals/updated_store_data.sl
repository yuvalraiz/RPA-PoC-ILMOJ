namespace: YuvalRaiz.PoC.IL-MOJ.internals
flow:
  name: updated_store_data
  inputs:
    - line_id
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
            - command: "${'''update poc_ilmoj set uploaded = true where line_id = %s;''' % (line_id)}"
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
        x: 398
        'y': 275
        navigate:
          6726366d-529f-1198-d879-027c28a941d9:
            targetId: 26983077-3c51-16eb-af5c-76beadf0829a
            port: SUCCESS
    results:
      SUCCESS:
        26983077-3c51-16eb-af5c-76beadf0829a:
          x: 551
          'y': 251
