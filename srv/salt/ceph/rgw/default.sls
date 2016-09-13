{% set rgw_name = salt['pillar.get']('rgw_service_name', 'rgw')  %}
install rgw:
  pkg.installed:
    - name: ceph-radosgw

start rgw:
  service.running:
    - name: ceph-radosgw@{{ rgw_name }}.{{ pillar['short_id'] }}
    - enable: True
    - require:
        - pkg: install rgw
