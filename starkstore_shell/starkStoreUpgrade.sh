#!/bin/sh
mount -o remount,rw /system
if [ -f /system/media/changjia_stark_store.apk ]; then
    rm -rf /system/media/changjia_stark_store.apk
fi

if [ -d /system/app/StarkStore/ ]; then
    rm -rf /system/app/StarkStore/
fi

if [ -d /system/priv-app/StarkStore/ ]; then
    rm -rf /system/priv-app/StarkStore/*
fi

pm clear com.stark.store

if [ ! -d /system/priv-app/StarkStore/ ]; then
    mkdir /system/priv-app/StarkStore/
    chmod 755 /system/priv-app/StarkStore/
fi

mv -f /cache/StarkStore.apk /system/priv-app/StarkStore/
chmod 644 /system/priv-app/StarkStore/StarkStore.apk
sync

sed -i 's/ro.cvte.customer=.*/ro.cvte.customer=CHANGJIA/g' /system/build.prop
