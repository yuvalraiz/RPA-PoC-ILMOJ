namespace: YuvalRaiz.PoC.IL-MOJ.internals
flow:
  name: handle_income_mail
  inputs:
    - mail_server
    - mailbox
    - password:
        sensitive: true
    - mail_folder
    - message_number
  workflow:
    - get_mail_message:
        do:
          io.cloudslang.base.mail.get_mail_message:
            - host: '${mail_server}'
            - username: '${mailbox}'
            - password:
                value: '${password}'
                sensitive: true
            - folder: '${mail_folder}'
            - message_number: '${message_number}'
            - enable_TLS: 'true'
            - trust_all_roots: 'true'
        publish:
          - attached_file_names
          - save_folder_name: "${''.join(c for c in subject if c.isalnum() or c == ' '   )}"
          - court_id: "${subject.split(',')[0].split(' ')[-1]}"
          - email_dest_folder: "${'''%s/%s/%s''' % ( get_sp('YuvalRaiz.PoC.IL-MOJ.poc_root_folder')  , get_sp('YuvalRaiz.PoC.IL-MOJ.poc_income_folder'), save_folder_name)}"
          - email_rcpt_time: "${return_result.split('Received:')[1].split(';')[1][1:-1]}"
          - sender: "${return_result.split('From: ')[1].split('\\n')[0][1:-1]}"
          - subject
        navigate:
          - SUCCESS: create_folder
          - FAILURE: on_failure
    - get_mail_attachment:
        do:
          io.cloudslang.base.mail.get_mail_attachment:
            - host: '${mail_server}'
            - protocol: imap4
            - username: '${mailbox}'
            - password:
                value: '${password}'
                sensitive: true
            - folder: '${mail_folder}'
            - message_number: '${message_number}'
            - destination: '${linux_folder_name}'
            - attachment_name: '${attached_file_names}'
            - overwrite: 'true'
            - trust_all_roots: 'true'
            - enable_TLS: 'true'
        navigate:
          - SUCCESS: ExtractDataFromPDF
          - FAILURE: on_failure
    - create_folder:
        do:
          io.cloudslang.base.filesystem.create_folder:
            - folder_name: "${'''%s%s''' % (get_sp('YuvalRaiz.PoC.IL-MOJ.poc_folder_linux_mount'),email_dest_folder)}"
            - windows_folder_name: "${'''%s%s''' % (get_sp('YuvalRaiz.PoC.IL-MOJ.poc_folder_windows_mount'),email_dest_folder.replace('/','\\\\'))}"
        publish:
          - linux_folder_name: '${folder_name}'
          - windows_folder_name
        navigate:
          - SUCCESS: get_mail_attachment
          - FAILURE: get_mail_attachment
    - ExtractDataFromPDF:
        do:
          YuvalRaiz.PoC.IL-MOJ.internals.actions.ExtractDataFromPDF:
            - pdf_path: "${'''%s\\\\%s''' % (windows_folder_name, attached_file_names)}"
        publish:
          - PersonsList
          - windows_pdf_path: '${pdf_path}'
        navigate:
          - SUCCESS: store_income_data
          - WARNING: store_income_data
          - FAILURE: on_failure
    - store_income_data:
        do:
          YuvalRaiz.PoC.IL-MOJ.internals.store_income_data:
            - email_rcpt_date: '${email_rcpt_time}'
            - email_from: '${sender}'
            - email_subject: '${subject}'
            - court_id: '${court_id}'
            - all_persons: '${PersonsList}'
            - pdf_path: '${windows_pdf_path}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_mail_message:
        x: 30
        'y': 83
      get_mail_attachment:
        x: 360
        'y': 90
      create_folder:
        x: 181
        'y': 90
      ExtractDataFromPDF:
        x: 518
        'y': 92
      store_income_data:
        x: 654
        'y': 253
        navigate:
          55bd954b-1078-9271-b898-3d11d3a2a859:
            targetId: 7771f313-047f-79f6-a09f-8a2fab15821d
            port: SUCCESS
    results:
      SUCCESS:
        7771f313-047f-79f6-a09f-8a2fab15821d:
          x: 771
          'y': 73
