ssh_config:
  file.managed:
    - name: /root/.ssh/config
    - source: salt://deploy/ssh_config
    - makedirs: True

deploykey:
  file.managed:
    - name: /root/.ssh/github
    - source: salt://deploy/id_rsa
    - makedirs: True
    - mode: 600

publickey:
  file.managed:
    - name: /root/.ssh/github.pub
    - source: salt://deploy/id_rsa.pub
    - makedirs: True
    - mode: 600
