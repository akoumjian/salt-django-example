include:
  - circus

app-pkgs:
  pkg.installed:
    - names:
      - git
      - python-virtualenv
      - python-dev
      - libmysqlclient-dev

webapp:
  git.latest:
    - name: git@github.com:username/repo.git
    - rev: {{ pillar['git_rev'] }}
    - target: /var/www/myapp/
    - force: true
    - require:
      - pkg: app-pkgs

settings:
  file.managed:
    - name: /var/www/myapp/settings.py
    - source: salt://webserver/settings.py
    - template: jinja
    - watch:
      - git: webapp

/var/www/env:
  virtualenv.manage:
    - requirements: /var/www/myapp/requirements.txt
    - no_site_packages: true
    - clear: false
    - require:
      - pkg: app-pkgs
      - file: settings

nginx:
  pkg:
    - latest
  service:
    - running
    - watch:
      - file: nginxconf

nginxconf:
  file.managed:
    - name: /etc/nginx/sites-enabled/default
    - source: salt://webserver/nginx.conf
    - template: jinja
    - makedirs: True
    - mode: 755

gunicorn_circus:
    file.managed:
        - name: /etc/circus.d/gunicorn.ini
        - source: salt://webserver/gunicorn.ini
        - makedirs: True
        - watch_in:
            - service: circusd
