namespace: YuvalRaiz.PoC.IL-MOJ
flow:
  name: Step2
  workflow:
    - get_all_messgaeIDs:
        do:
          YuvalRaiz.yrUtil.imap.get_all_messgaeIDs:
            - mail_server: "${get_sp('YuvalRaiz.PoC.IL-MOJ.poc_mailserver')}"
            - username: "${get_sp('YuvalRaiz.PoC.IL-MOJ.poc_mailbox')}"
            - password:
                value: "${get_sp('YuvalRaiz.PoC.IL-MOJ.poc_mailbox_password')}"
                sensitive: true
            - folder: Inbox
            - sender: "${get_sp('YuvalRaiz.PoC.IL-MOJ.emails_from')}"
        publish:
          - mailbox_folder: '${folder}'
          - msg_ids
          - mail_password:
              value: '${password}'
              sensitive: true
        navigate:
          - SUCCESS: handle_income_mail
          - FAILURE: on_failure
    - handle_income_mail:
        loop:
          for: "message_number in msg_ids.split(',')"
          do:
            YuvalRaiz.PoC.IL-MOJ.internals.handle_income_mail:
              - mail_server: "${get_sp('YuvalRaiz.PoC.IL-MOJ.poc_mailserver')}"
              - mailbox: "${get_sp('YuvalRaiz.PoC.IL-MOJ.poc_mailbox')}"
              - password:
                  value: '${mail_password}'
                  sensitive: true
              - mail_folder: '${mailbox_folder}'
              - message_number: '${message_number}'
          break:
            - FAILURE
        navigate:
          - FAILURE: on_failure
          - SUCCESS: move_email_between_folders
    - move_email_between_folders:
        do:
          YuvalRaiz.yrUtil.imap.move_email_between_folders:
            - mail_server: "${get_sp('YuvalRaiz.PoC.IL-MOJ.poc_mailserver')}"
            - username: "${get_sp('YuvalRaiz.PoC.IL-MOJ.poc_mailbox')}"
            - password:
                value: "${get_sp('YuvalRaiz.PoC.IL-MOJ.poc_mailbox_password')}"
                sensitive: true
            - from_folder: '${mailbox_folder}'
            - to_folder: Done
            - msg_id: '${msg_ids}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_all_messgaeIDs:
        x: 63
        'y': 90
      handle_income_mail:
        x: 222
        'y': 92
      move_email_between_folders:
        x: 378
        'y': 97
        navigate:
          589eade1-f64e-23c6-0a80-e3a59c806ce8:
            targetId: 27e16dda-2c54-81c4-747e-135b504beea8
            port: SUCCESS
    results:
      SUCCESS:
        27e16dda-2c54-81c4-747e-135b504beea8:
          x: 559
          'y': 94
