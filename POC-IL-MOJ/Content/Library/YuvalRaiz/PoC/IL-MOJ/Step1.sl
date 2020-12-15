########################################################################################################################
#!!
#! @description: Read the excel and based on it go the the website and send the relevant document to the poc mailbox
#!!#
########################################################################################################################
namespace: YuvalRaiz.PoC.IL-MOJ
flow:
  name: Step1
  inputs:
    - input_excel:
        required: false
    - _input_excel:
        default: "${get('input_excel','''%s%s/%s''' % ( get_sp('YuvalRaiz.PoC.IL-MOJ.poc_folder_linux_mount'), get_sp('YuvalRaiz.PoC.IL-MOJ.poc_root_folder'),get_sp('YuvalRaiz.PoC.IL-MOJ.income_excel_name')))}"
        private: true
    - sheet_name:
        required: false
    - _sheet_name:
        default: "${get('sheet_name',get_sp('YuvalRaiz.PoC.IL-MOJ.income_excel_sheet'))}"
        private: true
  workflow:
    - get_cell:
        do:
          io.cloudslang.base.excel.get_cell:
            - excel_file_name: '${_input_excel}'
            - worksheet_name: '${_sheet_name}'
            - has_header: 'yes'
            - row_delimiter: '_|_'
            - column_delimiter: ;
        publish:
          - all_data: "${return_result.replace(chr(160),'')}"
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
              - send_to: "${get_sp('YuvalRaiz.PoC.IL-MOJ.poc_mailbox')}"
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
        x: 148
        'y': 111
      call_GetCourtFiles:
        x: 301
        'y': 115
        navigate:
          2d05818d-80c1-a499-7c0d-85f9af50d860:
            targetId: f487dde3-7893-6f10-0e63-6fa3916ac9fe
            port: SUCCESS
    results:
      SUCCESS:
        f487dde3-7893-6f10-0e63-6fa3916ac9fe:
          x: 435
          'y': 106
