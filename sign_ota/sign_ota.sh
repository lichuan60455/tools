#!/bin/sh
PKGNAME=$1

function source_env()
{
    cd /home/code/release/android/n-cn/
    source build/envsetup.sh
    source ../../../customers/buildtools/script/cvte_proj_env.sh
    source ../../../customers/buildtools/script/proj_toolchain.sh
    lunch 12
}

function signe_package()
{
    pkgName=`echo ${PKGNAME} | cut -d "." -f 1`
    signedName=${pkgName}_singed.zip
    java -Xmx2048m -Djava.library.path=out/host/linux-x86/lib64 -jar out/host/linux-x86/framework/signapk.jar -w build/target/product/security/testkey.x509.pem build/target/product/security/testkey.pk8 ${PKGNAME} ${signedName}
}

if [ x"$1" == x"" ]; then
    echo "error no package found"
    return
fi

#source_env
signe_package
