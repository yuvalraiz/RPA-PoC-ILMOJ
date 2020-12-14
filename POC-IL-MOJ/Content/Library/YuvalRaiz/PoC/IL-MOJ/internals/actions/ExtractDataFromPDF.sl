namespace: YuvalRaiz.PoC.IL-MOJ.internals.actions
operation:
  name: ExtractDataFromPDF
  inputs:
    - pdf_path
  sequential_action:
    gav: 'com.microfocus.seq:YuvalRaiz.PoC.IL-MOJ.internals.actions.ExtractDataFromPDF:1.0.0'
    skills:
      - Java
      - SAP NWBC Desktop
      - SAP
      - SAPUI5
      - SAPWDJ
      - SAPWebExt
      - Terminal Emulators
      - UI Automation
      - Web
      - WPF
    settings:
      sap:
        active: false
        auto_log_on: false
        close_on_exit: false
        ignore_existing_sessions: false
        remember_password: false
      windows:
        active: true
        apps:
          app_1:
            args: ''
            directory: ''
            include_child_processes: true
            launch_application: true
            path: "c:\\Program Files (x86)\\adobe\\Acrobat Reader DC\\reader\\acrord32.exe"
      terminal_settings:
        active: false
      web:
        active: false
        address: ''
        browser: IE64
        close_on_exit: false
    steps:
      - step:
          id: '1'
          object_path: 'Window("Adobe Acrobat Reader DC")'
          action: Activate
      - step:
          id: '2'
          action: Script
          object_path: "'define keys ID"
      - step:
          id: '3'
          action: Script
          object_path: Const VK_CONTROL = 29
      - step:
          id: '4'
          action: Script
          object_path: Const VK_A = 30
      - step:
          id: '5'
          action: Script
          object_path: Const VK_C = 46
      - step:
          id: '6'
          action: Script
          object_path: Const VK_O = 24
      - step:
          id: '7'
          action: Script
          object_path: 'Set myDeviceReplay = CreateObject("Mercury.DeviceReplay")'
      - step:
          id: '8'
          object_path: myDeviceReplay
          action: KeyDown
          args: VK_CONTROL
      - step:
          id: '9'
          object_path: myDeviceReplay
          action: PressKey
          args: VK_O
      - step:
          id: '10'
          object_path: 'Dialog("Open").WinEdit("File name:")'
          action: Set
          args: 'Parameter("pdf_path")'
          snapshot: ".\\Snapshots\\ssf2.png"
          highlight_id: '2688006'
      - step:
          id: '11'
          object_path: 'Dialog("Open").WinButton("Open")'
          action: Click
          snapshot: ".\\Snapshots\\ssf3.png"
          highlight_id: '5244006'
      - step:
          id: '12'
          action: Script
          object_path: "' in case of error message of extensions"
      - step:
          id: '13'
          action: Script
          object_path: 'If Dialog("Acrobat Reader").Exist(1) Then'
      - step:
          id: '14'
          object_path: 'Dialog("Acrobat Reader").WinButton("OK")'
          action: Click
      - step:
          id: '15'
          action: Script
          object_path: End If
      - step:
          id: '16'
          object_path: 'Window("Adobe Acrobat Reader DC").WinObject("AVPageView")'
          action: Click
      - step:
          id: '17'
          action: Script
          object_path: "' Clear the clipboard"
      - step:
          id: '18'
          action: Script
          object_path: 'Set cb = CreateObject("Mercury.Clipboard")'
      - step:
          id: '19'
          object_path: cb
          action: Clear()
      - step:
          id: '20'
          object_path: myDeviceReplay
          action: KeyDown
          args: VK_CONTROL
      - step:
          id: '21'
          object_path: myDeviceReplay
          action: PressKey
          args: VK_A
      - step:
          id: '22'
          object_path: myDeviceReplay
          action: PressKey
          args: VK_C
      - step:
          id: '23'
          object_path: myDeviceReplay
          action: KeyUp
          args: VK_CONTROL
      - step:
          id: '24'
          action: Wait
          args: '"2"'
          default_args: '"1"'
      - step:
          id: '25'
          action: Script
          object_path: "'Parameter(\"FirstPageContent\") = cb.GetText()"
      - step:
          id: '26'
          action: Script
          object_path: x= cb.GetText()
      - step:
          id: '27'
          action: Script
          object_path: Set objRE = New RegExp
      - step:
          id: '28'
          action: Script
          object_path: With objRE
      - step:
          id: '29'
          action: Script
          object_path: "'.Pattern    = \"([^:\\d]+, (?:ת.ז.|ת\"\"ז) \\d{8,9})\""
      - step:
          id: '30'
          action: Script
          object_path: "'.Pattern    = \"([א-ת ']+, (?:ת.ז.|ת\"\"ז) \\d{8,9})\""
      - step:
          id: '31'
          action: Script
          object_path: ".Pattern    = \"([א-ת][' א-ת]+, (?:ת.ז.|ת\"\"ז) \\d{8,9})\""
      - step:
          id: '32'
          action: Script
          object_path: .IgnoreCase = True
      - step:
          id: '33'
          action: Script
          object_path: .Global     = True
      - step:
          id: '34'
          action: Script
          object_path: End With
      - step:
          id: '35'
          action: Script
          object_path: Set objMatch = objRE.Execute( x )
      - step:
          id: '36'
          action: Script
          object_path: If objMatch.Count = 0  Then
      - step:
          id: '37'
          action: Script
          object_path: 'txt = "לא נמצאו פרטים"'
      - step:
          id: '38'
          action: Script
          object_path: Else
      - step:
          id: '39'
          action: Script
          object_path: 'op=""'
      - step:
          id: '40'
          action: Script
          object_path: 'txt=""'
      - step:
          id: '41'
          action: Script
          object_path: For Each match in objMatch
      - step:
          id: '42'
          action: Script
          object_path: txt= txt + op + match.value
      - step:
          id: '43'
          action: Script
          object_path: op=vbNewLine
      - step:
          id: '44'
          action: Script
          object_path: Next
      - step:
          id: '45'
          action: Script
          object_path: End If
      - step:
          id: '46'
          action: Script
          object_path: "'print txt"
      - step:
          id: '47'
          action: Script
          object_path: 'Parameter("PersonsList") = txt'
      - step:
          id: '48'
          object_path: 'Window("Adobe Acrobat Reader DC")'
          action: Close
  outputs:
    - PersonsList:
        robot: true
        value: '${PersonsList}'
    - return_result: '${return_result}'
    - error_message: '${error_message}'
  results:
    - SUCCESS
    - WARNING
    - FAILURE
object_repository:
  objects:
    - object:
        smart_identification: ''
        name: Adobe Acrobat Reader DC
        child_objects:
          - object:
              smart_identification: ''
              name: AVPageView
              child_objects: []
              properties:
                - property:
                    value:
                      value: '0'
                      regular_expression: false
                    name: window id
                    hidden: false
                    read_only: false
                    type: NUMBER
                - property:
                    value:
                      value: AVPageView
                      regular_expression: false
                    name: text
                    hidden: false
                    read_only: false
                    type: STRING
                - property:
                    value:
                      value: AVL_AVView
                      regular_expression: false
                    name: regexpwndclass
                    hidden: false
                    read_only: false
                    type: STRING
                - property:
                    value:
                      value: AVL_AVView
                      regular_expression: false
                    name: nativeclass
                    hidden: false
                    read_only: false
                    type: STRING
              comments: ''
              custom_replay:
                behavior:
                  value: AVL_AVView
                  name: simclass
                  type: STRING
              class: WinObject
              visual_relations: ''
              last_update_time: '07 December 2020 01:50:48'
              basic_identification:
                property_ref:
                  - window id
                  - text
                  - regexpwndclass
                  - nativeclass
                ordinal_identifier: ''
        properties:
          - property:
              value:
                value: Adobe Acrobat Reader DC
                regular_expression: false
              name: regexpwndtitle
              hidden: false
              read_only: false
              type: STRING
          - property:
              value:
                value: AcrobatSDIWindow
                regular_expression: false
              name: regexpwndclass
              hidden: false
              read_only: false
              type: STRING
          - property:
              value:
                value: '0'
                regular_expression: false
              name: is owned window
              hidden: false
              read_only: false
              type: BOOL
          - property:
              value:
                value: '0'
                regular_expression: false
              name: is child window
              hidden: false
              read_only: false
              type: BOOL
        comments: ''
        custom_replay:
          behavior:
            value: AcrobatSDIWindow
            name: simclass
            type: STRING
        class: Window
        visual_relations: ''
        last_update_time: '07 December 2020 01:50:48'
        basic_identification:
          property_ref:
            - regexpwndtitle
            - regexpwndclass
            - is owned window
            - is child window
          ordinal_identifier: ''
    - object:
        smart_identification: ''
        name: Open
        child_objects:
          - object:
              smart_identification: ''
              name: 'File name:'
              child_objects: []
              properties:
                - property:
                    value:
                      value: Edit
                      regular_expression: false
                    name: nativeclass
                    hidden: false
                    read_only: false
                    type: STRING
                - property:
                    value:
                      value: 'File &name:'
                      regular_expression: false
                    name: attached text
                    hidden: false
                    read_only: false
                    type: STRING
              comments: ''
              custom_replay:
                behavior:
                  value: Edit
                  name: simclass
                  type: STRING
              class: WinEdit
              visual_relations: ''
              last_update_time: '07 December 2020 01:50:48'
              basic_identification:
                property_ref:
                  - nativeclass
                  - attached text
                ordinal_identifier: ''
          - object:
              smart_identification: ''
              name: Open
              child_objects: []
              properties:
                - property:
                    value:
                      value: '&Open'
                      regular_expression: false
                    name: text
                    hidden: false
                    read_only: false
                    type: STRING
                - property:
                    value:
                      value: Button
                      regular_expression: false
                    name: nativeclass
                    hidden: false
                    read_only: false
                    type: STRING
              comments: ''
              custom_replay:
                behavior:
                  value: Button
                  name: simclass
                  type: STRING
              class: WinButton
              visual_relations: ''
              last_update_time: '07 December 2020 01:50:48'
              basic_identification:
                property_ref:
                  - text
                  - nativeclass
                ordinal_identifier: ''
        properties:
          - property:
              value:
                value: Open
                regular_expression: false
              name: text
              hidden: false
              read_only: false
              type: STRING
          - property:
              value:
                value: '#32770'
                regular_expression: false
              name: nativeclass
              hidden: false
              read_only: false
              type: STRING
          - property:
              value:
                value: '-1'
                regular_expression: false
              name: is owned window
              hidden: false
              read_only: false
              type: BOOL
          - property:
              value:
                value: '0'
                regular_expression: false
              name: is child window
              hidden: false
              read_only: false
              type: BOOL
        comments: ''
        custom_replay:
          behavior:
            value: '#32770'
            name: simclass
            type: STRING
        class: Dialog
        visual_relations: ''
        last_update_time: '07 December 2020 01:50:48'
        basic_identification:
          property_ref:
            - text
            - nativeclass
            - is owned window
            - is child window
          ordinal_identifier: ''
    - object:
        smart_identification: ''
        name: Acrobat Reader
        child_objects: []
        properties:
          - property:
              value:
                value: Acrobat Reader
                regular_expression: false
              name: text
              hidden: false
              read_only: false
              type: STRING
          - property:
              value:
                value: '#32770'
                regular_expression: false
              name: nativeclass
              hidden: false
              read_only: false
              type: STRING
          - property:
              value:
                value: '-1'
                regular_expression: false
              name: is owned window
              hidden: false
              read_only: false
              type: BOOL
          - property:
              value:
                value: '0'
                regular_expression: false
              name: is child window
              hidden: false
              read_only: false
              type: BOOL
        comments: ''
        custom_replay:
          behavior:
            value: '#32770'
            name: simclass
            type: STRING
        class: Dialog
        visual_relations: ''
        last_update_time: '07 December 2020 01:50:48'
        basic_identification:
          property_ref:
            - text
            - nativeclass
            - is owned window
            - is child window
          ordinal_identifier: ''
  check_points_and_outputs: []
  parameters: []
