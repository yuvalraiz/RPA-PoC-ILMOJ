namespace: YuvalRaiz.PoC.IL-MOJ.internals.tests
flow:
  name: test_UpdatePoCWebSite
  workflow:
    - UpdatePoCWebSite:
        do:
          YuvalRaiz.PoC.IL-MOJ.internals.actions.UpdatePoCWebSite:
            - company: mycompany
            - court_id: abcd
            - DD: '08'
            - MM: '12'
            - YYYY: '1999'
            - name1: ישראל
            - id1: '11111'
            - upload_password:
                value: "${get_sp('YuvalRaiz.PoC.IL-MOJ.poc_upload_url')}"
                sensitive: true
                prompt:
                  type: text
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: CUSTOM
          - FAILURE: on_failure
  results:
    - SUCCESS
    - CUSTOM
    - FAILURE
extensions:
  graph:
    steps:
      UpdatePoCWebSite:
        x: 163
        'y': 259
        navigate:
          27b6f9a4-f2ca-2d52-4c13-ca74b2b5365c:
            targetId: ac0eff09-4963-23ba-9070-05fc71147bcd
            port: SUCCESS
          6ebc0973-672d-8566-8d22-50969b4e94a0:
            targetId: 79cb3350-b0a5-26be-bd0b-ba0c9492079d
            port: WARNING
    results:
      SUCCESS:
        ac0eff09-4963-23ba-9070-05fc71147bcd:
          x: 560
          'y': 143
      CUSTOM:
        79cb3350-b0a5-26be-bd0b-ba0c9492079d:
          x: 476
          'y': 330
