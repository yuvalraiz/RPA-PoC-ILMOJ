namespace: YuvalRaiz.PoC.IL-MOJ.internals
flow:
  name: call_GetCourtFiles
  inputs:
    - court_id
    - from_date
    - to_date
    - send_to
  workflow:
    - GetCourtFiles:
        do:
          YuvalRaiz.PoC.IL-MOJ.internals.actions.GetCourtFiles:
            - court_id_part1: "${court_id.split('-')[0]}"
            - court_id_part2: "${'-'.join(court_id.split('-')[1:])}"
            - from_date: '${from_date}'
            - to_date: '${to_date}'
            - send_to: '${send_to}'
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      GetCourtFiles:
        x: 143
        'y': 215
        navigate:
          ec6a428c-cb46-d20c-5d0c-91b9ff48c776:
            targetId: 3ee7a2ce-77c4-08c4-7825-bc1fa8ebe70e
            port: SUCCESS
          0697ab64-eb70-29cb-c6d8-e69dee4c0c5a:
            targetId: 3ee7a2ce-77c4-08c4-7825-bc1fa8ebe70e
            port: WARNING
    results:
      SUCCESS:
        3ee7a2ce-77c4-08c4-7825-bc1fa8ebe70e:
          x: 384
          'y': 154
