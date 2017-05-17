#!/bin/bash
sudo puppet apply --modulepath modules/ -e 'class  {"asennawp":}'
sudo puppet apply /etc/puppet/manifests/site.pp
firefox 'localhost'
