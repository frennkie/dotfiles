# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from __future__ import print_function

# additional clean up after upgrade
# dpkg --list |grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge

# python fabric file (apt-get install fabric || pip install fabric)
# Fabfile to:
#  - get df (disc free)
#  - get uptime
#  - change password for a given "username"
#  - update the remote system(s) using apt-get
#  - reboot

# Import Fabric's API module
from fabric.api import *

# call with e.g. "fab -R prod df" for "prod" role host
env.roledefs = {
    'self': ['localhost'],
    #'prod': ['dom0', 'dom1', 'dom5', 'dom1v2', 'dr-backup'],
    'prod': ['dom0', 'dom1', 'dom5', 'dom1v2'],
    'dev': ['user@dev.example.com'],
    'staging': ['user@staging.example.com'],
    'production': ['user@production.example.com']
}

def df():
    """get disk free results of host(s)"""
    run("df -h")

def uptime():
    """get uptime of host(s)"""
    run("uptime")

def upgrade():
    """run the usual update/upgrade commands"""
    sudo("apt-get    update")
    sudo("apt-get -y upgrade")
    sudo("apt-get -y dist-upgrade")
    sudo("apt-get -y autoremove")
    sudo("apt-get -y autoclean")

def do_reboot():
    """reboot host(s)"""
    reboot()

def change_password(username=None):
    """use sudo to change the password of a user"""
    if not username:
        print("Error: No username given!")
        print("Syntax: fap change_password:username=alice")
        raise Exception("Error: No username given!")
    else:
        sudo("passwd %s" % username)

