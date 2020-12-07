namespace: YuvalRaiz.PoC.IL-MOJ.internals.tests
flow:
  name: test_GetCourtFiles
  workflow:
    - GetCourtFiles:
        do:
          YuvalRaiz.PoC.IL-MOJ.internals.actions.GetCourtFiles: []
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: CUSTOM
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
    - CUSTOM
extensions:
  graph:
    steps:
      GetCourtFiles:
        x: 143
        'y': 215
        navigate:
          491d9cb5-aeb8-ec72-8ada-505b5c69a8a7:
            targetId: 36bfc708-ab3a-365f-58b3-43f1fab2a8a1
            port: WARNING
          ec6a428c-cb46-d20c-5d0c-91b9ff48c776:
            targetId: 3ee7a2ce-77c4-08c4-7825-bc1fa8ebe70e
            port: SUCCESS
    results:
      SUCCESS:
        3ee7a2ce-77c4-08c4-7825-bc1fa8ebe70e:
          x: 384
          'y': 154
      CUSTOM:
        36bfc708-ab3a-365f-58b3-43f1fab2a8a1:
          x: 322
          'y': 337
