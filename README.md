salt-django-example
===================

A skeleton example for deploying a django web application out of a git repository with salt.

** Warning: This state tree is a demo and untested. **

Instructions:

1. Follow the instructions to install and setup a salt-master and one or more salt-minions
2. Copy the contents of this repo to /srv/ on your salt-master
3. Update files with your own git repo and settings.
4. Target the minions you want to deploy and call highstate.

```sh
# salt '*' state.highstate
```

