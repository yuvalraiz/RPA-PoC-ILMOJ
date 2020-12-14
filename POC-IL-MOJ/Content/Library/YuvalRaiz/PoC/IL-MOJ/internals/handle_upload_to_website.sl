namespace: YuvalRaiz.PoC.IL-MOJ.internals
flow:
  name: handle_upload_to_website
  inputs:
    - line_id
    - court_id
    - email_date
    - sender
    - all_names
    - pdf_path
  workflow:
    - manipulate_data:
        do:
          io.cloudslang.base.utils.do_nothing:
            - email_date: '${email_date}'
            - all_names: '${all_names}'
        publish:
          - DD: "${email_date.split('-')[2]}"
          - MM: "${email_date.split('-')[1]}"
          - YYYY: "${email_date.split('-')[0]}"
          - id1: "${all_names.split('\\n')[0].split(',')[1].split()[-1]}"
          - name1: "${all_names.split('\\n')[0].split(',')[0]}"
          - id2: "${'' if len(all_names.split('\\n')) == 1 else all_names.split('\\n')[1].split(',')[1].split()[-1]}"
          - name2: "${'' if len(all_names.split('\\n')) == 1 else all_names.split('\\n')[1].split(',')[0]}"
        navigate:
          - SUCCESS: UpdatePoCWebSite
          - FAILURE: on_failure
    - UpdatePoCWebSite:
        do:
          YuvalRaiz.PoC.IL-MOJ.internals.actions.UpdatePoCWebSite:
            - company: MF
            - court_id: '${court_id}'
            - DD: '${DD}'
            - MM: '${MM}'
            - YYYY: '${YYYY}'
            - name1: '${name1}'
            - id1: '${id1}'
            - name2: '${name2}'
            - id2: '${id2}'
            - pdf_path: '${pdf_path}'
            - upload_password:
                value: "${get_sp('YuvalRaiz.PoC.IL-MOJ.poc_upload_password')}"
                sensitive: true
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
      manipulate_data:
        x: 37
        'y': 113
      UpdatePoCWebSite:
        x: 205
        'y': 118
        navigate:
          fdf19aaa-31cf-08ba-ec8b-a72db9c0abab:
            targetId: 0a5275e3-d084-1806-2f8b-c51f2cfd61cb
            port: WARNING
          384ff6b4-7e06-e2be-09e8-ece3f159e76d:
            targetId: 0a5275e3-d084-1806-2f8b-c51f2cfd61cb
            port: SUCCESS
    results:
      SUCCESS:
        0a5275e3-d084-1806-2f8b-c51f2cfd61cb:
          x: 661
          'y': 124
