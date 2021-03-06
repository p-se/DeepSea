
prevent empty rendering:
  test.nop:
    - name: skip

{% set keyring_file = salt['keyring.file']('deepsea_cephfs_bench') %}
{% set secret = salt['keyring.gen_secret']() %}
{{ keyring_file }}:
  file.managed:
    - source: salt://ceph/cephfs/benchmarks/files/keyring.j2
    - template: jinja
    - user: salt
    - group: salt
    - mode: 600
    - makedirs: True
    - context:
      secret: {{ secret }}
    - fire_event: True

auth {{ keyring_file }}:
  cmd.run:
    - name: 'ceph auth add client.deepsea_cephfs_bench -i {{ keyring_file }}'
    - require:
      - file: {{ keyring_file }}

{{ salt['keyring.file']('deepsea_cephfs_bench_secret') }}:
  file.managed:
    - contents: {{ secret }}
