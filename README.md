# salt-django-example


A salt state tree for deploying a django app to a production server.

## The Stack


* __Ubuntu 12.04 64bit __: The package names and the rest of the stack are only known to work with Ubuntu 12.04
* __NGINX__: As a reverse proxy for the wsgi container and to serve static content
* __gunicorn__: As our wsgi container
* __circus__: Process watcher for gunicorn
* __git__: For deploying our web application
* __pip__ & __virtualenv__: For installing our requirements

## The Setup


There is no one click solution here, but when you are complete you will be able to deploy stateless web applications with relative easy and consistency. This tutorial does not include:

1. Setting up a salt-master
2. Configuring the salt-minion conf
3. Creating and hosting your database

When you are certain you already have those setup, you can continue.

### Deploy Keys

If you don't already have a deploy key for your application, you will want to create one. This guide assumes you are deploying from a private repository on github. See the guide here for details: https://help.github.com/articles/managing-deploy-keys

After you have created your deploy key, you will want to place the keypair in `salt/deploy/` as `id_rsa` and `id_rsa.pub` respectively. If you name them something different, you will need to go into ``salt/webserver/init.sls`` and change the reference.

### Entering your details

Now you will need to edit the ``pillar/settings.sls`` file. Here you will enter the string values for your git repository, the branch or commit you wish to deploy, and your database settings.

You will now need to copy over your settings from settings.py to the one located in ``salt/webserver/settings.py``. Make sure to you do not overwrite the template pillar fields and that you have included ``gunicorn`` in the installed apps.

Check to make sure that the static folder specified in ``salt/webserver/nginx.conf`` correlates to the location of your static files. 

### Deploying

Make sure you've placed your this state tree on the file_root for your salt-master (normally ``/srv/salt``). From your salt master you can now run ``salt '*' state.highstate``.

### Notes

The example is still missing conditional states to initiate your database with syncdb, run migrations, or running collectstatic on your files. These will be added in an upcoming release.