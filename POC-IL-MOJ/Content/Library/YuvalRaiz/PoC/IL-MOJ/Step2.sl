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
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_all_messgaeIDs:
        x: 64
        'y': 90
      handle_income_mail:
        x: 250
        'y': 103
        navigate:
          0c9f9776-70ee-4732-5de4-5a3da9b6e782:
            targetId: 27e16dda-2c54-81c4-747e-135b504beea8
            port: SUCCESS
    results:
      SUCCESS:
        27e16dda-2c54-81c4-747e-135b504beea8:
          x: 440
          'y': 112
