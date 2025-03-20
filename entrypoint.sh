#!/bin/bash
exec proot -b /proc -b /dev -b /sys \
    -r /termux \
    /usr/bin/env -i \
    HOME=$HOME \
    TERM=$TERM \
    PATH=/termux/usr/bin:/termux/usr/sbin \
    LD_LIBRARY_PATH=/termux/usr/lib \
    /termux/usr/bin/bash -l
