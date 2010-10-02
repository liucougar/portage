liucougar Gentoo Overlay
========================

How to Use
----------
[layman] should be installed first, then issue the following command to add `liucougar` overlay

    layman -f -o http://github.com/liucougar/portage/raw/master/profiles/layman.xml -a liucougar

Now you can emerge anything included in this overlay, such as [s3ql]

    emerge s3ql

Some packages in [testing branch] are required as of Oct. 2010 in order to install s3ql, and the following is what I have in `/etc/portage/package.keywords` for `s3ql`:

    sys-fs/s3ql
    dev-python/pycryptopp
    dev-python/pyliblzma
    dev-python/unittest2 #only useful if you intend to test the package
    dev-python/apsw
    dev-cpp/gccxml
    dev-db/sqlite

 [layman]: http://www.gentoo.org/proj/en/overlays/userguide.xml
 [s3ql]: http://code.google.com/p/s3ql/
 [Testing branch]: http://www.gentoo.org/doc/en/handbook/handbook-x86.xml?part=3&chap=3#doc_chap2
