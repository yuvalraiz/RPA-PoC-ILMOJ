namespace: YuvalRaiz.PoC.IL-MOJ
flow:
  name: Step1
  inputs:
    - input_excel: "${'''%s%s/%s''' % ( get_sp('YuvalRaiz.PoC.IL-MOJ.poc_folder_linux_mount'), get_sp('YuvalRaiz.PoC.IL-MOJ.poc_root_folder'),get_sp('YuvalRaiz.PoC.IL-MOJ.income_excel_name'))}"
    - sheet_name: "${get_sp('YuvalRaiz.PoC.IL-MOJ.income_excel_sheet')}"
  workflow:
    - get_cell:
        do:
          io.cloudslang.base.excel.get_cell:
            - excel_file_name: '${input_excel}'
            - worksheet_name: '${sheet_name}'
            - has_header: 'yes'
            - row_delimiter: '_|_'
            - column_delimiter: ;
        publish:
          - all_data: "${return_result.replace(chr(32),'')}"
          - output_0: '${ord(return_result[11])}'
        navigate:
          - SUCCESS: call_GetCourtFiles
          - FAILURE: on_failure
    - call_GetCourtFiles:
        loop:
          for: "action_data in all_data.split('_|_')"
          do:
            YuvalRaiz.PoC.IL-MOJ.internals.call_GetCourtFiles:
              - court_id: "${action_data.split(';')[0]}"
              - from_date: "${action_data.split(';')[1]}"
              - to_date: "${action_data.split(';')[2]}"
              - send_to: "${action_data.split(';')[3]}"
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
      get_cell:
        x: 145
        'y': 113
      call_GetCourtFiles:
        x: 284
        'y': 128
        navigate:
          2d05818d-80c1-a499-7c0d-85f9af50d860:
            targetId: f487dde3-7893-6f10-0e63-6fa3916ac9fe
            port: SUCCESS
    results:
      SUCCESS:
        f487dde3-7893-6f10-0e63-6fa3916ac9fe:
          x: 435
          'y': 106