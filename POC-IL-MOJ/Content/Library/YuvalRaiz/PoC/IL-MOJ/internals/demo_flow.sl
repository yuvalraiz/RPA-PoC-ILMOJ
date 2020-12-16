namespace: YuvalRaiz.PoC.IL-MOJ.internals
flow:
  name: demo_flow
  inputs:
    - titles
    - mail
  workflow:
    - send_mail:
        loop:
          for: "subject in titles.split(',')"
          do:
            io.cloudslang.base.mail.send_mail:
              - hostname: mail.mfdemos.com
              - port: '25'
              - from: yuval.raiz@mfdemos.com
              - to: '${mail}'
              - subject: '${subject}'
              - body: Just a body
              - enable_TLS: 'true'
          break:
            - FAILURE
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      send_mail:
        x: 242
        'y': 134
        navigate:
          c45b6ebc-ba40-082e-88f4-03ac56570da8:
            targetId: bf9cdda6-7a6a-0541-078b-ca7204bf95cb
            port: SUCCESS
    results:
      SUCCESS:
        bf9cdda6-7a6a-0541-078b-ca7204bf95cb:
          x: 479
          'y': 145
