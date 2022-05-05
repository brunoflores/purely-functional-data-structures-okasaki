#!/usr/bin/env bash

wget http://smlnj.cs.uchicago.edu/dist/working/110.99.2/config.tgz
tar -xzf config.tgz
config/install.sh

sml -help
