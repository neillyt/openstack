#!/bin/bash

systemctl restart nagios
systemctl restart nrpe
ansible all -a "systemctl restart nrpe"
