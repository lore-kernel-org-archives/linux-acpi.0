From: "Alexander Isacson" <alexander-O4oeKNg1Q5OZuzBka8ofvg@public.gmane.org>
Subject: Please, please help me enable a serial port.
Date: Thu, 27 Nov 2003 09:09:19 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <14650.192.176.33.6.1069920559.squirrel@firewall.isacson.dyndns.info>
Reply-To: alexander-O4oeKNg1Q5OZuzBka8ofvg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20031127090919_67631"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

------=_20031127090919_67631
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all.

I'm in desperate need of help to enable a serial port on the Compaq table
PC TC1000. I had it working with kernel 2.4.22 but I had to upgrade the
kernel to 2.6.0-test10 to make the WLAN drivers for my new card work. The
TC1000 will be used to remotely operate a small robot as part of my maste=
r
thesis.

The driver I was using before is called fpi2002 and I found it here:
http://linux-tablet-pc.dhs.org/. I attached it below along with the
readme. All it does is enable /dev/ttyS0. I'm no kernel programmer so thi=
s
is like rocket-science to me. I also attached the compilation error I get
when trying to recompile the driver for 2.6.0-test10

I have enabled the kernel option that states "8259/16550 device discovery
via ACPI namespace" but that doesn't seem to enable the port.

I have tried to gather as much information as possible to help you help m=
e
get this show back on the road!

Regards
/Alexander Isacson

------=_20031127090919_67631
Content-Type: application/octet-stream; name="fpi2002.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fpi2002.c"

LyoKICogQ29tcGFxIFRDMTAwMCBUb3VjaHNjcmVlbiBEZXZpY2UKICogVmVyc2lvbiAwLjEKICog
Q29weXJpZ2h0IChjKSBGcmFuayBCcnVubyA8ZmJydW5vQGF0dGJpLmNvbT4KICoKICogQ2FuIGJl
IGZyZWVseSBkaXN0cmlidXRlZCBhbmQgdXNlZCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
UEwuCiAqIAogKiBUaGlzIG1vZHVsZSBmaWxlIGlzIGEgaGFjay4gSXQgaXMgdGhlIERTRFQgaW5p
dCByb3V0aW5lIGZvciB0aGUgCiAqIENPTTEgaW50ZXJmYWNlIG9mIHRoZSBWaWEgdnQ4MmM2ODZi
IGNoaXBzZXQuIFRoaXMgc2hvdWxkIHJlYWxseSBnbwogKiBpbiB0aGUgc2VyaWFsLmMgZmlsZSBz
b21ld2hlcmUsIG9yIGlkZWFsbHkgdGhlIEFDUEkgaW50ZXJwcmV0dGVyCiAqIFNob3VsZCBoYW5k
bGUgYWxsIG9mIHRoaXMuCiAqLwoKI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgojaW5jbHVkZSA8
bGludXgva2VybmVsLmg+CiNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4KI2luY2x1ZGUgPGxpbnV4
L3ZlcnNpb24uaD4KI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KI2luY2x1ZGUgPGxpbnV4L3BjaS5o
PgojaW5jbHVkZSA8bGludXgvZnMuaD4gICAgICAgLyogVGhlIGNoYXJhY3RlciBkZXZpY2UgCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBkZWZpbml0aW9ucyBhcmUgaGVyZSAqLwojaW5j
bHVkZSA8bGludXgvd3JhcHBlci5oPiAgLyogQSB3cmFwcGVyIHdoaWNoIGRvZXMgCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKiBuZXh0IHRvIG5vdGhpbmcgYXQKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAqIGF0IHByZXNlbnQsIGJ1dCBtYXkgCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKiBoZWxwIGZvciBjb21wYXRpYmlsaXR5CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKiB3aXRoIGZ1dHVyZSB2ZXJzaW9ucyAKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqIG9mIExpbnV4ICovCgpjb25zdCB1bnNpZ25lZCBzaG9ydCBjb25maW5kZXg9MHgzRjAsY29u
ZmRhdGE9MHgzRjE7CmNvbnN0IHVuc2lnbmVkIGNoYXIgc3BjaWR4PTB4RUU7CmNvbnN0IHVuc2ln
bmVkIGNoYXIgY3IyPTB4RTI7CmNvbnN0IHVuc2lnbmVkIGNoYXIgY3IzPTB4RTM7CmNvbnN0IHVu
c2lnbmVkIGNoYXIgY3I2PTB4RTY7CmNvbnN0IHVuc2lnbmVkIGNoYXIgY3I3PTB4RTc7CmNvbnN0
IHVuc2lnbmVkIGNoYXIgY3I4PTB4RTg7CmNvbnN0IHVuc2lnbmVkIGNoYXIgY3JlPTB4RUU7Cgpz
dGF0aWMgaW50IGZwaTIwMDJfaW5pdCh2b2lkKQp7CiAgc3RydWN0IHBjaV9kZXYgKnBjaWRldiA9
IE5VTEw7CiAgdW5zaWduZWQgY2hhciBjb25mdmFsLHZhbDsKICB1bnNpZ25lZCBjaGFyIGxvY2Fs
MCwgbG9jYWwxOwogIC8qIFNlZSBpZiB3ZSBoYXZlIGEgdmlhIGNoaXAgKi8KICBwY2lkZXYgPSBw
Y2lfZmluZF9kZXZpY2UgKFBDSV9WRU5ET1JfSURfVklBLFBDSV9ERVZJQ0VfSURfVklBXzgyQzY4
NixOVUxMKTsKICBpZiAocGNpZGV2KSB7CiAgICBjbGkoKTsKICAgIC8qIHN0YXJ0IGNvbmZpZyBB
Q1BJIEVOQ0cgKi8KICAgIHBjaV9yZWFkX2NvbmZpZ19ieXRlKHBjaWRldiwweDg1LCZjb25mdmFs
KTsKICAgIGNvbmZ2YWwgfD0gMHgyOwogICAgcGNpX3dyaXRlX2NvbmZpZ19ieXRlIChwY2lkZXYs
IDB4ODUsY29uZnZhbCk7CiAgICAvKiBMb2FkIENSMiBJTyBhZGRyZXNzICovCiAgICBvdXRiKGNy
Mixjb25maW5kZXgpOyAvKiBzZXQgaW5kZXggKi8KICAgIGxvY2FsMCA9ICh1bnNpZ25lZCBjaGFy
KSBpbmIoY29uZmRhdGEpOwogICAgbG9jYWwwID0gbG9jYWwwICYgMHhmYjsKICAgIG91dGIoY3Iy
LGNvbmZpbmRleCk7CiAgICBvdXRiKGxvY2FsMCxjb25mZGF0YSk7CiAgICAvKiAgICBsb2NhbDAg
PSAoMHhmOCA8PCAyKSAmIDB4ZmU7IC8vIElPIGxvdwoJICBsb2NhbDEgPSAoMHgwMyA8PCA2KTsK
CSAgbG9jYWwwID0gbG9jYWwwIHwgbG9jYWwxOyAqLwogICAgb3V0YihjcjcsY29uZmluZGV4KTsg
Lyogc2V0IGluZGV4ICovCiAgICBvdXRiKDB4ZmUsY29uZmRhdGEpOyAvKiAweDNmOCA+PiAyICAo
SU8gcG9ydCkgKi8KICAgIC8qIExvYWQgSVJRICovCiAgICBwY2lfcmVhZF9jb25maWdfYnl0ZShw
Y2lkZXYsMHg1MiwmY29uZnZhbCk7CiAgICBsb2NhbDAgPSAoY29uZnZhbCAmIDB4ZjApIHwgMHgw
NDsKICAgIHBjaV93cml0ZV9jb25maWdfYnl0ZSAocGNpZGV2LCAweDUyLGxvY2FsMCk7CiAgICBv
dXRiKGNyMixjb25maW5kZXgpOwogICAgb3V0Yihsb2NhbDAsY29uZmRhdGEpOwogICAgbG9jYWww
ID0gbG9jYWwwIHwgMHgwNDsKICAgIG91dGIoY3IyLGNvbmZpbmRleCk7CiAgICBsb2NhbDAgPSAo
dW5zaWduZWQgY2hhcikgaW5iKGNvbmZkYXRhKTsKICAgIGxvY2FsMCA9IGxvY2FsMCB8IDB4MDQ7
CiAgICBvdXRiKGNyMixjb25maW5kZXgpOyAvKiBzZXQgaW5kZXggKi8KICAgIG91dGIobG9jYWww
LGNvbmZkYXRhKTsKICAgIC8qIEVYQ0cgKi8KICAgIHBjaV9yZWFkX2NvbmZpZ19ieXRlKHBjaWRl
diwweDg1LCZjb25mdmFsKTsKICAgIGNvbmZ2YWwgJj0gMHhmZDsKICAgIHBjaV93cml0ZV9jb25m
aWdfYnl0ZSAocGNpZGV2LCAweDg1LGNvbmZ2YWwpOwoKICAgIHN0aSgpOwogICAgcHJpbnRrIChL
RVJOX0lORk8gIkVuYWJsZWQgRlBJMjAwMiBJbnRlcmZhY2VcbiIpOwogIH0KICBlbHNlIHsKICAg
IHByaW50ayAoS0VSTl9JTkZPICJDb3VsZG4ndCBsb2NhdGUgVklBIGNoaXBzZXRcbiIpOwogICAg
cmV0dXJuIC0xOwogIH0KICByZXR1cm4gMDsKfQoKc3RhdGljIHZvaWQgZnBpMjAwMl9leGl0KHZv
aWQpCnsKICBzdHJ1Y3QgcGNpX2RldiAqcGNpZGV2ID0gTlVMTDsKICB1bnNpZ25lZCBjaGFyIGNv
bmZ2YWwsdmFsOwogIHVuc2lnbmVkIGNoYXIgbG9jYWwwLCBsb2NhbDE7CiAgcGNpZGV2ID0gcGNp
X2ZpbmRfZGV2aWNlIChQQ0lfVkVORE9SX0lEX1ZJQSxQQ0lfREVWSUNFX0lEX1ZJQV84MkM2ODYs
TlVMTCk7CiAgaWYgKHBjaWRldikgewogICAgY2xpKCk7CiAgICAvKiBzdGFydCBjb25maWcgKi8K
ICAgIHBjaV9yZWFkX2NvbmZpZ19ieXRlKHBjaWRldiwweDg1LCZjb25mdmFsKTsKICAgIGNvbmZ2
YWwgfD0gMHgyOwogICAgcGNpX3dyaXRlX2NvbmZpZ19ieXRlIChwY2lkZXYsIDB4ODUsY29uZnZh
bCk7CgogICAgb3V0YihjcjIsY29uZmluZGV4KTsgLyogc2V0IGluZGV4ICovCiAgICBsb2NhbDAg
PSAodW5zaWduZWQgY2hhcikgaW5iKGNvbmZkYXRhKTsKICAgIG91dGIoY3IyLGNvbmZpbmRleCk7
IC8qIHNldCBpbmRleCAqLwogICAgb3V0Yihsb2NhbDAsY29uZmRhdGEpOyAKICAgIG91dGIoY3I3
LGNvbmZpbmRleCk7IC8qIHNldCBpbmRleCAqLwogICAgb3V0YigweDAsY29uZmRhdGEpOyAKICAg
IHBjaV9yZWFkX2NvbmZpZ19ieXRlKHBjaWRldiwweDUyLCZjb25mdmFsKTsKICAgIGxvY2FsMCA9
IChjb25mdmFsICYgMHhmMCk7CiAgICBwY2lfd3JpdGVfY29uZmlnX2J5dGUgKHBjaWRldiwgMHg1
Mixsb2NhbDApOwogICAgCiAgICAvKiBFWENHICovCiAgICBwY2lfcmVhZF9jb25maWdfYnl0ZShw
Y2lkZXYsMHg4NSwmY29uZnZhbCk7CiAgICBjb25mdmFsICY9IDB4ZmQ7CiAgICBwY2lfd3JpdGVf
Y29uZmlnX2J5dGUgKHBjaWRldiwgMHg4NSxjb25mdmFsKTsKICAgIHN0aSgpOwogICAgcHJpbnRr
IChLRVJOX0lORk8gIkZQSTIwMDIgZGlzYWJsZWRcbiIpOwogIH0KfQoKbW9kdWxlX2luaXQoZnBp
MjAwMl9pbml0KTsKbW9kdWxlX2V4aXQoZnBpMjAwMl9leGl0KTsKTU9EVUxFX0RFU0NSSVBUSU9O
KCJGUEkyMDAyIHBvcnQgZW5hYmxlciIpOwpNT0RVTEVfQVVUSE9SKCJGcmFuayBCcnVubyA8ZmJy
dW5vQGF0dGJpLmNvbT4iKTsKCg==
------=_20031127090919_67631
Content-Type: text/plain; name="fpi-README"
Content-Disposition: attachment; filename="fpi-README"
Content-Transfer-Encoding: quoted-printable

This module file is a hack from the viahss-0.6 driver. I took that module
and implemented the ACPI init function for the Via serial port to enable
accessing the Serial port under linux. Ideally this should be handled via
the ACPI routines or in the serial.c driver.

The issue is that the Bios does not enable the serial port connected to t=
he
touchscreen controller. ACPI is used to enable it. Linux does not support
enough ACPI to enable the interface. To verify the operation, run
'setserial /dev/ttyS0' and you will see an unknown interface. After runni=
ng
the commands below, run the setserial command again and you will see a
16550a interface. Now to figure out the touchscreen commands.

To build:
1) make
2) make install

To use:
1) insmod fpi2002
2) setserial /dev/ttyS0 autoconfig

Now the serial port is visible and useable.
------=_20031127090919_67631
Content-Type: text/plain; name="kernel-2.6.0-test10.error.txt"
Content-Disposition: attachment; filename="kernel-2.6.0-test10.error.txt"
Content-Transfer-Encoding: quoted-printable

gcc -O2 -D__KERNEL__ -DMODULE -fomit-frame-pointer -I/usr/src/linux/inclu=
de -I/usr/src/linux/include/asm -c fpi2002.c -o fpi2002.o
In file included from /usr/src/linux/include/asm/smp.h:18,
                 from /usr/src/linux/include/linux/smp.h:17,
                 from /usr/src/linux/include/linux/sched.h:23,
                 from /usr/src/linux/include/linux/module.h:10,
                 from fpi2002.c:14:
/usr/src/linux/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or =
directory
In file included from /usr/src/linux/include/asm/smp.h:18,
                 from /usr/src/linux/include/linux/smp.h:17,
                 from /usr/src/linux/include/linux/sched.h:23,
                 from /usr/src/linux/include/linux/module.h:10,
                 from fpi2002.c:14:
/usr/src/linux/include/asm/mpspec.h:8: `MAX_MP_BUSSES' undeclared here (n=
ot in a function)
/usr/src/linux/include/asm/mpspec.h:9: `MAX_MP_BUSSES' undeclared here (n=
ot in a function)
/usr/src/linux/include/asm/mpspec.h:10: `MAX_MP_BUSSES' undeclared here (=
not in a function)
/usr/src/linux/include/asm/mpspec.h:12: `MAX_MP_BUSSES' undeclared here (=
not in a function)
/usr/src/linux/include/asm/mpspec.h:19: `MAX_APICS' undeclared here (not =
in a function)
/usr/src/linux/include/asm/mpspec.h:20: `MAX_MP_BUSSES' undeclared here (=
not in a function)
/usr/src/linux/include/asm/mpspec.h:20: conflicting types for `mp_bus_id_=
to_type'
/usr/src/linux/include/asm/mpspec.h:8: previous declaration of `mp_bus_id=
_to_type'
/usr/src/linux/include/asm/mpspec.h:22: `MAX_IRQ_SOURCES' undeclared here=
 (not in a function)
/usr/src/linux/include/asm/mpspec.h:24: `MAX_MP_BUSSES' undeclared here (=
not in a function)
/usr/src/linux/include/asm/mpspec.h:24: conflicting types for `mp_bus_id_=
to_pci_bus'
/usr/src/linux/include/asm/mpspec.h:12: previous declaration of `mp_bus_i=
d_to_pci_bus'
/usr/src/linux/include/asm/mpspec.h:54: `MAX_APICS' undeclared here (not =
in a function)
In file included from /usr/src/linux/include/asm/smp.h:20,
                 from /usr/src/linux/include/linux/smp.h:17,
                 from /usr/src/linux/include/linux/sched.h:23,
                 from /usr/src/linux/include/linux/module.h:10,
                 from fpi2002.c:14:
/usr/src/linux/include/asm/io_apic.h:120: `MAX_IRQ_SOURCES' undeclared he=
re (not in a function)
/usr/src/linux/include/asm/io_apic.h:120: conflicting types for `mp_irqs'
/usr/src/linux/include/asm/mpspec.h:22: previous declaration of `mp_irqs'
In file included from /usr/src/linux/include/linux/smp.h:17,
                 from /usr/src/linux/include/linux/sched.h:23,
                 from /usr/src/linux/include/linux/module.h:10,
                 from fpi2002.c:14:
/usr/src/linux/include/asm/smp.h:73:26: mach_apicdef.h: No such file or d=
irectory
make: *** [fpi2002.o] Error 1
------=_20031127090919_67631
Content-Type: text/plain; name="output-acpidmp.txt"
Content-Disposition: attachment; filename="output-acpidmp.txt"
Content-Transfer-Encoding: quoted-printable

RSDP "PTLTD" @ 0x000f7860
  0000: 52 53 44 20 50 54 52 20 97 50 54 4c 54 44 20 00  RSD PTR .PTLTD .
  0010: 58 bd 7f 0e                                      X...

RSDT @ 0x0e7fbd58
  0000: 52 53 44 54 28 00 00 00 01 51 50 54 4c 54 44 20  RSDT(....QPTLTD=20
  0010: 20 20 52 53 44 54 20 20 00 00 04 06 20 4c 54 50    RSDT  .... LTP
  0020: 00 00 00 00 80 bd 7f 0e                          ........

FACP @ 0x0e7fbd80
  0000: 46 41 43 50 74 00 00 00 01 a0 43 6f 6d 70 61 71  FACPt.....Compaq
  0010: 30 30 42 35 20 20 20 20 00 00 04 06 50 54 4c 20  00B5    ....PTL=20
  0020: 00 00 00 01 c0 ff 7f 0e f4 bd 7f 0e 00 00 0a 00  ................
  0030: 2f 80 00 00 f0 f1 00 00 00 80 00 00 00 00 00 00  /...............
  0040: 04 80 00 00 00 00 00 00 50 80 00 00 08 80 00 00  ........P.......
  0050: 20 80 00 00 00 00 00 00 04 02 01 04 04 00 00 00   ...............
  0060: 0f 00 e9 03 00 00 00 00 00 00 7d 7e 32 00 00 00  ..........}~2...
  0070: a5 02 00 00                                      ....

DSDT @ 0x0e7fbdf4
  0000: 44 53 44 54 0c 32 00 00 01 19 43 4f 4d 50 41 51  DSDT.2....COMPAQ
  0010: 30 30 42 35 20 20 20 20 00 00 04 06 4d 53 46 54  00B5    ....MSFT
  0020: 0e 00 00 01 5b 01 4d 55 54 30 00 08 45 43 46 4c  ....[.MUT0..ECFL
  0030: 00 08 4f 53 54 59 00 08 43 53 53 54 00 08 5c 5f  ..OSTY..CSST..\_
  0040: 53 30 5f 12 06 02 0a 00 0a 00 08 5c 5f 53 31 5f  S0_........\_S1_
  0050: 12 06 02 0a 04 0a 04 08 5c 5f 53 33 5f 12 06 02  ........\_S3_...
  0060: 0a 01 0a 01 08 5c 5f 53 34 5f 12 06 02 0a 02 0a  .....\_S4_......
  0070: 02 08 5c 5f 53 35 5f 12 06 02 0a 02 0a 02 5b 80  ..\_S5_.......[.
  0080: 44 42 47 5f 01 0a 80 0a 01 5b 81 0b 44 42 47 5f  DBG_.....[..DBG_
  0090: 01 44 45 42 47 08 10 40 07 5c 5f 50 52 5f 5b 83  .DEBG..-4b8TPpkIZ3Q@public.gmane.org\_PR_[.
  00a0: 47 06 43 50 55 30 01 10 80 00 00 06 08 5f 50 43  G.CPU0......._PC
  00b0: 54 12 2c 02 11 14 0a 11 82 0c 00 7f 08 00 00 00  T.,.............
  00c0: 00 00 00 00 00 00 00 79 00 11 14 0a 11 82 0c 00  .......y........
  00d0: 7f 08 00 00 00 00 00 00 00 00 00 00 79 00 08 5f  ............y.._
  00e0: 50 53 53 12 19 01 12 16 06 0b e8 03 0b 1c 25 0a  PSS...........%.
  00f0: 14 0a 14 0c 00 00 64 00 0c 00 00 64 00 14 09 5f  ......d....d..._
  0100: 50 50 43 00 a4 0a 00 14 48 0b 5c 5f 50 54 53 01  PPC.....H.\_PTS.
  0110: 70 68 43 53 53 54 5b 23 4d 55 54 30 ff ff 70 43  phCSST[#MUT0..pC
  0120: 53 53 54 5c 2f 05 5f 53 42 5f 50 43 49 30 50 49  SST\/._SB_PCI0PI
  0130: 42 5f 45 43 5f 5f 53 4c 50 54 a0 22 93 43 53 53  B_EC__SLPT.".CSS
  0140: 54 0a 05 70 0a 00 5c 2f 05 5f 53 42 5f 50 43 49  T..p..\/._SB_PCI
  0150: 30 50 49 42 5f 45 43 5f 5f 41 43 50 49 5b 27 4d  0PIB_EC__ACPI['M
  0160: 55 54 30 a0 31 93 43 53 53 54 0a 03 7b 5c 2f 04  UT0.1.CSST..{\/.
  0170: 5f 53 42 5f 50 43 49 30 50 4d 5f 5f 50 42 43 52  _SB_PCI0PM__PBCR
  0180: 0a fb 5c 2f 04 5f 53 42 5f 50 43 49 30 50 4d 5f  ..\/._SB_PCI0PM_
  0190: 5f 50 42 43 52 70 7d 5c 2f 04 5f 53 42 5f 50 43  _PBCRp}\/._SB_PC
  01a0: 49 30 50 4d 5f 5f 47 4f 31 36 0a 20 00 5c 2f 04  I0PM__GO16. .\/.
  01b0: 5f 53 42 5f 50 43 49 30 50 4d 5f 5f 47 4f 31 36  _SB_PCI0PM__GO16
  01c0: 14 46 22 5c 5f 57 41 4b 01 70 43 53 53 54 44 45  .F"\_WAK.pCSSTDE
  01d0: 42 47 70 7b 5c 2f 04 5f 53 42 5f 50 43 49 30 50  BGp{\/._SB_PCI0P
  01e0: 4d 5f 5f 47 4f 31 36 0a df 00 5c 2f 04 5f 53 42  M__GO16...\/._SB
  01f0: 5f 50 43 49 30 50 4d 5f 5f 47 4f 31 36 5b 23 4d  _PCI0PM__GO16[#M
  0200: 55 54 30 ff ff 70 0a 00 5c 2f 05 5f 53 42 5f 50  UT0..p..\/._SB_P
  0210: 43 49 30 50 49 42 5f 45 43 5f 5f 53 4c 50 54 70  CI0PIB_EC__SLPTp
  0220: 0a 00 5c 2f 05 5f 53 42 5f 50 43 49 30 50 49 42  ..\/._SB_PCI0PIB
  0230: 5f 45 43 5f 5f 54 31 4c 4f a0 35 93 5c 2f 05 5f  _EC__T1LO.5.\/._
  0240: 53 42 5f 50 43 49 30 50 49 42 5f 45 43 5f 5f 4e  SB_PCI0PIB_EC__N
  0250: 44 4d 44 0a 01 70 0a 40 5c 2f 05 5f 53 42 5f 50  DMD..p.@\/._SB_P
  0260: 43 49 30 50 49 42 5f 45 43 5f 5f 54 31 48 49 a1  CI0PIB_EC__T1HI.
  0270: 1b 70 0a 4e 5c 2f 05 5f 53 42 5f 50 43 49 30 50  .p.N\/._SB_PCI0P
  0280: 49 42 5f 45 43 5f 5f 54 31 48 49 5b 27 4d 55 54  IB_EC__T1HI['MUT
  0290: 30 70 01 5c 2e 5f 54 5a 5f 54 53 43 49 86 5c 2e  0p.\._TZ_TSCI.\.
  02a0: 5f 54 5a 5f 54 48 52 4d 0a 81 86 5c 2e 5f 54 5a  _TZ_THRM...\._TZ
  02b0: 5f 54 48 52 4d 0a 80 86 5c 2f 03 5f 53 42 5f 50  _THRM...\/._SB_P
  02c0: 43 49 30 43 52 44 30 0a 00 86 5c 2f 03 5f 53 42  CI0CRD0...\/._SB
  02d0: 5f 50 43 49 30 43 52 44 31 0a 00 86 5c 2f 03 5f  _PCI0CRD1...\/._
  02e0: 53 42 5f 50 43 49 30 55 53 42 30 0a 00 86 5c 2f  SB_PCI0USB0...\/
  02f0: 03 5f 53 42 5f 50 43 49 30 55 53 42 31 0a 00 86  ._SB_PCI0USB1...
  0300: 5c 2f 03 5f 53 42 5f 50 43 49 30 55 53 42 32 0a  \/._SB_PCI0USB2.
  0310: 00 86 5c 2e 5f 53 42 5f 41 43 5f 5f 0a 80 86 5c  ..\._SB_AC__...\
  0320: 2e 5f 53 42 5f 43 4d 42 30 0a 81 86 5c 2e 5f 53  ._SB_CMB0...\._S
  0330: 42 5f 43 4d 42 30 0a 80 5b 23 4d 55 54 30 ff ff  B_CMB0..[#MUT0..
  0340: 70 5c 2f 03 5f 53 42 5f 57 4d 49 44 53 54 44 5f  p\/._SB_WMIDSTD_
  0350: 60 70 5c 2f 05 5f 53 42 5f 50 43 49 30 50 49 42  `p\/._SB_PCI0PIB
  0360: 5f 45 43 5f 5f 4e 44 4d 44 61 70 61 5c 2f 03 5f  _EC__NDMDapa\/._
  0370: 53 42 5f 57 4d 49 44 53 54 44 5f 5b 27 4d 55 54  SB_WMIDSTD_['MUT
  0380: 30 a0 12 92 93 60 61 86 5c 2e 5f 53 42 5f 57 4d  0....`a.\._SB_WM
  0390: 49 44 0a 80 a0 4c 04 92 95 5c 2f 04 5f 53 42 5f  ID...L...\/._SB_
  03a0: 50 43 49 30 50 49 42 5f 43 4c 4b 52 0a 47 a0 32  PCI0PIB_CLKR.G.2
  03b0: 92 95 43 53 53 54 0a 03 7d 5c 2f 04 5f 53 42 5f  ..CSST..}\/._SB_
  03c0: 50 43 49 30 50 4d 5f 5f 50 42 43 52 0a 04 5c 2f  PCI0PM__PBCR..\/
  03d0: 04 5f 53 42 5f 50 43 49 30 50 4d 5f 5f 50 42 43  ._SB_PCI0PM__PBC
  03e0: 52 70 00 43 53 53 54 10 06 5c 5f 53 49 5f 10 2e  Rp.CSST..\_SI_..
  03f0: 5c 5f 47 50 45 14 27 5f 4c 30 35 00 86 5c 2e 5f  \_GPE.'_L05..\._
  0400: 53 42 5f 50 43 49 30 0a 02 86 5c 2e 5f 53 42 5f  SB_PCI0...\._SB_
  0410: 50 57 52 42 0a 02 70 0a 05 44 45 42 47 10 89 7f  PWRB..p..DEBG...
  0420: 02 5c 5f 53 42 5f 5b 82 45 07 57 4d 49 44 08 5f  .\_SB_[.E.WMID._
  0430: 48 49 44 0c 41 d0 0c 14 08 5f 55 49 44 0a 00 08  HID.A...._UID...
  0440: 53 54 44 5f 0a 00 08 5f 57 44 47 11 2b 0a 28 71  STD_..._WDG.+.(q
  0450: ac 64 c3 db 36 5a 49 84 94 b4 39 d4 72 a5 05 42  .d..6ZI...9.r..B
  0460: 41 01 00 ee b5 17 07 66 f4 10 41 a5 54 c5 58 8b  A......f..A.T.X.
  0470: 80 28 c0 80 00 01 08 14 11 57 51 42 41 01 70 53  .(.......WQBA.pS
  0480: 54 44 5f 60 a4 53 54 44 5f 14 09 5f 57 45 44 01  TD_`.STD_.._WED.
  0490: a4 0a 00 14 09 57 45 38 30 01 a4 0a 00 5b 80 53  .....WE80....[.S
  04a0: 4d 49 30 01 0c 00 fe 00 00 0c 02 00 00 00 5b 81  MI0...........[.
  04b0: 0b 53 4d 49 30 00 53 4d 49 43 08 5b 80 53 4d 49  .SMI0.SMIC.[.SMI
  04c0: 31 00 0c c2 fe 7f 0e 0c 90 00 00 00 5b 81 16 53  1...........[..S
  04d0: 4d 49 31 00 42 43 4d 44 08 44 49 44 5f 20 49 4e  MI1.BCMD.DID_ IN
  04e0: 46 4f 40 40 5b 81 10 53 4d 49 31 00 01 01 00 00  FO@@[..SMI1.....
  04f0: 28 49 4e 46 5f 08 5b 82 44 07 41 43 5f 5f 08 5f  (INF_.[.D.AC__._
  0500: 48 49 44 0d 41 43 50 49 30 30 30 33 00 08 41 43  HID.ACPI0003..AC
  0510: 50 57 ff 08 5f 50 43 4c 12 07 01 5c 5f 53 42 5f  PW.._PCL...\_SB_
  0520: 08 5f 53 54 41 0a 0f 14 44 04 5f 50 53 52 00 a0  ._STA...D._PSR..
  0530: 37 5c 45 43 46 4c 5b 23 4d 55 54 30 ff ff 7b 5c  7\ECFL[#MUT0..{\
  0540: 2f 05 5f 53 42 5f 50 43 49 30 50 49 42 5f 45 43  /._SB_PCI0PIB_EC
  0550: 5f 5f 41 44 50 5f 0a 01 41 43 50 57 5b 27 4d 55  __ADP_..ACPW['MU
  0560: 54 30 a4 41 43 50 57 a1 04 a4 0a 01 5b 82 41 27  T0.ACPW.....[.A'
  0570: 43 4d 42 30 08 5f 48 49 44 0c 41 d0 0c 0a 08 5f  CMB0._HID.A...._
  0580: 55 49 44 0a 01 08 42 41 54 53 ff 08 43 52 49 54  UID...BATS..CRIT
  0590: 0a 00 08 5f 50 43 4c 12 07 01 5c 5f 53 42 5f 14  ..._PCL...\_SB_.
  05a0: 40 05 5f 53 54 41 00 a0 43 04 5c 45 43 46 4c 5b  @._STA..C.\ECFL[
  05b0: 23 4d 55 54 30 ff ff 7b 5c 2f 05 5f 53 42 5f 50  #MUT0..{\/._SB_P
  05c0: 43 49 30 50 49 42 5f 45 43 5f 5f 42 41 54 50 0a  CI0PIB_EC__BATP.
  05d0: 01 42 41 54 53 5b 27 4d 55 54 30 a0 0a 93 42 41  .BATS['MUT0...BA
  05e0: 54 53 00 a4 0a 0f a1 04 a4 0a 1f a1 04 a4 0a 0f  TS..............
  05f0: 08 50 42 49 46 12 2d 0d 0a 00 ff ff 0a 01 ff 0b  .PBIF.-.........
  0600: 20 03 0b 20 03 0a 64 0a 64 0d 42 41 54 31 00 0d   .. ..d.d.BAT1..
  0610: 31 32 33 34 00 0d 4c 49 4f 4e 00 0d 43 4f 4d 50  1234..LION..COMP
  0620: 41 51 00 14 48 0b 5f 42 49 46 00 a0 4b 0a 5c 45  AQ..H._BIF..K.\E
  0630: 43 46 4c 5b 23 4d 55 54 30 ff ff 70 5c 2f 05 5f  CFL[#MUT0..p\/._
  0640: 53 42 5f 50 43 49 30 50 49 42 5f 45 43 5f 5f 42  SB_PCI0PIB_EC__B
  0650: 44 43 5f 88 50 42 49 46 0a 01 00 70 5c 2f 05 5f  DC_.PBIF...p\/._
  0660: 53 42 5f 50 43 49 30 50 49 42 5f 45 43 5f 5f 42  SB_PCI0PIB_EC__B
  0670: 46 43 5f 88 50 42 49 46 0a 02 00 70 0a 01 88 50  FC_.PBIF...p...P
  0680: 42 49 46 0a 03 00 70 5c 2f 05 5f 53 42 5f 50 43  BIF...p\/._SB_PC
  0690: 49 30 50 49 42 5f 45 43 5f 5f 42 44 56 5f 88 50  I0PIB_EC__BDV_.P
  06a0: 42 49 46 0a 04 00 70 5c 2f 05 5f 53 42 5f 50 43  BIF...p\/._SB_PC
  06b0: 49 30 50 49 42 5f 45 43 5f 5f 42 43 57 5f 88 50  I0PIB_EC__BCW_.P
  06c0: 42 49 46 0a 05 00 70 0a 10 88 50 42 49 46 0a 06  BIF...p...PBIF..
  06d0: 00 5b 27 4d 55 54 30 a4 50 42 49 46 08 42 55 46  .['MUT0.PBIF.BUF
  06e0: 46 12 13 04 0a 00 0c ff ff ff ff 0c ff ff ff ff  F...............
  06f0: 0c ff ff ff ff 14 49 0c 5f 42 53 54 00 a0 4c 0b  ......I._BST..L.
  0700: 5c 45 43 46 4c 5b 23 4d 55 54 30 ff ff 70 5c 2f  \ECFL[#MUT0..p\/
  0710: 05 5f 53 42 5f 50 43 49 30 50 49 42 5f 45 43 5f  ._SB_PCI0PIB_EC_
  0720: 5f 42 53 54 5f 60 70 7b 60 0a 07 00 61 70 61 88  _BST_`p{`...apa.
  0730: 42 55 46 46 0a 00 00 70 5c 2f 05 5f 53 42 5f 50  BUFF...p\/._SB_P
  0740: 43 49 30 50 49 42 5f 45 43 5f 5f 42 50 52 5f 60  CI0PIB_EC__BPR_`
  0750: 70 60 61 a0 11 7b 60 0b 00 80 00 70 74 0c 00 00  p`a..{`....pt...
  0760: 01 00 61 00 62 a1 04 70 61 62 70 62 88 42 55 46  ..a.b..pabpb.BUF
  0770: 46 0a 01 00 70 5c 2f 05 5f 53 42 5f 50 43 49 30  F...p\/._SB_PCI0
  0780: 50 49 42 5f 45 43 5f 5f 42 52 43 5f 88 42 55 46  PIB_EC__BRC_.BUF
  0790: 46 0a 02 00 70 5c 2f 05 5f 53 42 5f 50 43 49 30  F...p\/._SB_PCI0
  07a0: 50 49 42 5f 45 43 5f 5f 42 50 56 5f 88 42 55 46  PIB_EC__BPV_.BUF
  07b0: 46 0a 03 00 5b 27 4d 55 54 30 a4 42 55 46 46 14  F...['MUT0.BUFF.
  07c0: 1f 5f 42 54 50 01 a0 18 5c 45 43 46 4c 70 0d 5f  ._BTP...\ECFLp._
  07d0: 53 42 2e 43 4d 42 30 2e 5f 42 54 50 00 5b 31 5b  SB.CMB0._BTP.[1[
  07e0: 82 1b 50 57 52 42 08 5f 48 49 44 0c 41 d0 0c 0c  ..PWRB._HID.A...
  07f0: 08 5f 50 52 57 12 06 02 0a 0b 0a 04 5b 82 88 3e  ._PRW.......[..>
  0800: 02 50 43 49 30 08 5f 48 49 44 0c 41 d0 0a 03 08  .PCI0._HID.A....
  0810: 5f 41 44 52 0a 00 08 5f 50 52 57 12 06 02 0a 05  _ADR..._PRW.....
  0820: 0a 03 14 46 10 5f 49 4e 49 00 a0 31 5b 12 5c 5f  ...F._INI..1[.\_
  0830: 4f 53 49 60 a0 27 5c 5f 4f 53 49 0d 57 69 6e 64  OSI`.'\_OSI.Wind
  0840: 6f 77 73 20 32 30 30 31 00 70 0a 04 4f 53 54 59  ows 2001.p..OSTY
  0850: 5c 2e 5f 53 42 5f 56 53 4d 49 0a 84 a1 4c 0c a0  \._SB_VSMI...L..
  0860: 3a 93 5c 53 43 4d 50 5c 5f 4f 53 5f 0d 4d 69 63  :.\SCMP\_OS_.Mic
  0870: 72 6f 73 6f 66 74 20 57 69 6e 64 6f 77 73 00 00  rosoft Windows..
  0880: 70 0a 01 45 43 46 4c 70 0a 01 4f 53 54 59 5c 2e  p..ECFLp..OSTY\.
  0890: 5f 53 42 5f 56 53 4d 49 0a 81 a1 4e 08 a0 36 93  _SB_VSMI...N..6.
  08a0: 5c 53 43 4d 50 5c 5f 4f 53 5f 0d 4d 69 63 72 6f  \SCMP\_OS_.Micro
  08b0: 73 6f 66 74 20 57 69 6e 64 6f 77 73 20 4e 54 00  soft Windows NT.
  08c0: 00 70 0a 03 4f 53 54 59 5c 2e 5f 53 42 5f 56 53  .p..OSTY\._SB_VS
  08d0: 4d 49 0a 83 a1 44 05 a0 41 05 93 5c 53 43 4d 50  MI...D..A..\SCMP
  08e0: 5c 5f 4f 53 5f 0d 4d 69 63 72 6f 73 6f 66 74 20  \_OS_.Microsoft=20
  08f0: 57 69 6e 64 6f 77 73 4d 45 3a 20 4d 69 6c 6c 65  WindowsME: Mille
  0900: 6e 6e 69 75 6d 20 45 64 69 74 69 6f 6e 00 00 70  nnium Edition..p
  0910: 0a 01 45 43 46 4c 70 0a 02 4f 53 54 59 5c 2e 5f  ..ECFLp..OSTY\._
  0920: 53 42 5f 56 53 4d 49 0a 81 14 09 5f 53 54 41 00  SB_VSMI...._STA.
  0930: a4 0a 0f 5b 80 52 45 47 53 02 0a 40 0a 34 5b 81  ...[.REGS..-Sbe9MoszGmM@public.gmane.org[.
  0940: 37 52 45 47 53 03 00 40 05 54 4f 4d 5f 10 00 40  7REGS..-KA90NuMEhbs@public.gmane.org@
  0950: 07 50 41 4d 31 08 50 41 4d 32 08 50 41 4d 33 08  .PAM1.PAM2.PAM3.
  0960: 50 41 4d 34 08 50 41 4d 35 08 50 41 4d 36 08 00  PAM4.PAM5.PAM6..
  0970: 48 09 54 5f 45 4e 01 08 52 53 52 43 11 4c 1b 0b  H.T_EN..RSRC.L..
  0980: b7 01 88 0e 00 02 0c 00 00 00 00 00 ff 00 00 00  ................
  0990: 01 00 00 47 01 f8 0c f8 0c 01 08 88 0e 00 01 0c  ...G............
  09a0: 03 00 00 00 00 f7 0c 00 00 f8 0c 00 87 18 00 00  ................
  09b0: 0c 03 00 00 00 00 00 00 0a 00 ff ff 0b 00 00 00  ................
  09c0: 00 00 00 00 02 00 00 87 18 00 00 0c 03 00 00 00  ................
  09d0: 00 00 00 0c 00 ff 3f 0c 00 00 00 00 00 00 40 00  ......?.......-4b8TPpkIZ3Q@public.gmane.org
  09e0: 00 00 87 18 00 00 0c 03 00 00 00 00 00 40 0c 00  .............-rVxdn2TrCWA@public.gmane.org
  09f0: ff 7f 0c 00 00 00 00 00 00 40 00 00 00 87 18 00  .........-E2U9adUjKaY@public.gmane.org
  0a00: 00 0c 03 00 00 00 00 00 80 0c 00 ff bf 0c 00 00  ................
  0a10: 00 00 00 00 40 00 00 00 87 18 00 00 0c 03 00 00  ....-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org
  0a20: 00 00 00 c0 0c 00 ff ff 0c 00 00 00 00 00 00 40  ...............@
  0a30: 00 00 00 87 18 00 00 0c 03 00 00 00 00 00 00 0d  ................
  0a40: 00 ff 3f 0d 00 00 00 00 00 00 40 00 00 00 87 18  ..?.......-5mgE8MpiMJg@public.gmane.org
  0a50: 00 00 0c 03 00 00 00 00 00 40 0d 00 ff 7f 0d 00  .........-E2U9adUjKaY@public.gmane.org
  0a60: 00 00 00 00 00 40 00 00 00 87 18 00 00 0c 03 00  .....-BlbsxGdv4A6tXF2fZOsJYA@public.gmane.org
  0a70: 00 00 00 00 80 0d 00 ff bf 0d 00 00 00 00 00 00  ................
  0a80: 40 00 00 00 87 18 00 00 0c 03 00 00 00 00 00 c0  @...............
  0a90: 0d 00 ff ff 0d 00 00 00 00 00 00 40 00 00 00 87  ...........-9D9NNryygCw@public.gmane.org
  0aa0: 18 00 00 0c 03 00 00 00 00 00 00 0e 00 ff 3f 0e  ..............?.
  0ab0: 00 00 00 00 00 00 40 00 00 00 87 18 00 00 0c 03  ......-BlbsxGdv4A7hvxM+mQhndA@public.gmane.org
  0ac0: 00 00 00 00 00 40 0e 00 ff 7f 0e 00 00 00 00 00  .....-BlbsxGdv4A6tXF2fZOsJYA@public.gmane.org
  0ad0: 00 40 00 00 00 87 18 00 00 0c 03 00 00 00 00 00  .-BlbsxGdv4A4TZT1p1SMppg@public.gmane.org
  0ae0: 80 0e 00 ff bf 0e 00 00 00 00 00 00 40 00 00 00  ............-47IYjYMXMt4@public.gmane.org
  0af0: 87 18 00 00 0c 03 00 00 00 00 00 c0 0e 00 ff ff  ................
  0b00: 0e 00 00 00 00 00 00 40 00 00 00 87 18 00 00 0c  .......-BlbsxGdv4A4@public.gmane.org
  0b10: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0b20: 00 00 00 00 00 00 88 0e 00 01 0c 03 00 00 00 0d  ................
  0b30: ff ff 00 00 00 f3 00 79 00 14 46 4f 5f 43 52 53  .......y..FO_CRS
  0b40: 08 8a 52 53 52 43 0b 93 01 41 54 4d 4e 8a 52 53  ..RSRC...ATMN.RS
  0b50: 52 43 0b 97 01 41 54 4d 58 8a 52 53 52 43 0b 9f  RC...ATMX.RSRC..
  0b60: 01 41 54 4c 4e 77 54 4f 4d 5f 0c 00 00 01 00 60  .ATLNwTOM_.....`
  0b70: a0 10 54 5f 45 4e 72 60 0c 00 00 0e 00 41 54 4d  ..T_ENr`.....ATM
  0b80: 4e a1 07 70 60 41 54 4d 4e 74 0c 00 00 e0 ff 41  N..p`ATMNt.....A
  0b90: 54 4d 4e 41 54 4c 4e 74 72 41 54 4d 4e 41 54 4c  TMNATLNtrATMNATL
  0ba0: 4e 00 0a 01 41 54 4d 58 8d 52 53 52 43 0b 50 02  N...ATMX.RSRC.P.
  0bb0: 43 30 52 57 8a 52 53 52 43 0a 4f 43 30 4d 4e 8a  C0RW.RSRC.OC0MN.
  0bc0: 52 53 52 43 0a 53 43 30 4d 58 8a 52 53 52 43 0a  RSRC.SC0MX.RSRC.
  0bd0: 5b 43 30 4c 4e 70 01 43 30 52 57 a0 12 93 7b 50  [C0LNp.C0RW...{P
  0be0: 41 4d 31 0a 03 00 0a 01 70 00 43 30 52 57 70 00  AM1.....p.C0RWp.
  0bf0: 43 30 4c 4e a0 12 92 7b 50 41 4d 31 0a 03 00 70  C0LN...{PAM1...p
  0c00: 0b 00 40 43 30 4c 4e 8d 52 53 52 43 0b 28 03 43  ..-/V45kY350IyFqyXNGmKg3w@public.gmane.org(.C
  0c10: 34 52 57 8a 52 53 52 43 0a 6a 43 34 4d 4e 8a 52  4RW.RSRC.jC4MN.R
  0c20: 53 52 43 0a 6e 43 34 4d 58 8a 52 53 52 43 0a 76  SRC.nC4MX.RSRC.v
  0c30: 43 34 4c 4e 70 01 43 34 52 57 a0 12 93 7b 50 41  C4LNp.C4RW...{PA
  0c40: 4d 31 0a 30 00 0a 10 70 00 43 34 52 57 70 00 43  M1.0...p.C4RWp.C
  0c50: 34 4c 4e a0 12 92 7b 50 41 4d 31 0a 30 00 70 0b  4LN...{PAM1.0.p.
  0c60: 00 40 43 34 4c 4e 8d 52 53 52 43 0b 00 04 43 38  .-zyS2Hbx/uF6dI16ORf6Wfw@public.gmane.org
  0c70: 52 57 8a 52 53 52 43 0a 85 43 38 4d 4e 8a 52 53  RW.RSRC..C8MN.RS
  0c80: 52 43 0a 89 43 38 4d 58 8a 52 53 52 43 0a 91 43  RC..C8MX.RSRC..C
  0c90: 38 4c 4e 70 01 43 38 52 57 a0 12 93 7b 50 41 4d  8LNp.C8RW...{PAM
  0ca0: 32 0a 03 00 0a 01 70 00 43 38 52 57 70 00 43 38  2.....p.C8RWp.C8
  0cb0: 4c 4e a0 12 92 7b 50 41 4d 32 0a 03 00 70 0b 00  LN...{PAM2...p..
  0cc0: 40 43 38 4c 4e 8d 52 53 52 43 0b d8 04 43 43 52  @C8LN.RSRC...CCR
  0cd0: 57 8a 52 53 52 43 0a a0 43 43 4d 4e 8a 52 53 52  W.RSRC..CCMN.RSR
  0ce0: 43 0a a4 43 43 4d 58 8a 52 53 52 43 0a ac 43 43  C..CCMX.RSRC..CC
  0cf0: 4c 4e 70 01 43 43 52 57 a0 12 93 7b 50 41 4d 32  LNp.CCRW...{PAM2
  0d00: 0a 30 00 0a 10 70 00 43 43 52 57 70 00 43 43 4c  .0...p.CCRWp.CCL
  0d10: 4e a0 12 92 7b 50 41 4d 32 0a 30 00 70 0b 00 40  N...{PAM2.0.p..@
  0d20: 43 43 4c 4e 8d 52 53 52 43 0b b0 05 44 30 52 57  CCLN.RSRC...D0RW
  0d30: 8a 52 53 52 43 0a bb 44 30 4d 4e 8a 52 53 52 43  .RSRC..D0MN.RSRC
  0d40: 0a bf 44 30 4d 58 8a 52 53 52 43 0a c7 44 30 4c  ..D0MX.RSRC..D0L
  0d50: 4e 70 01 44 30 52 57 a0 12 93 7b 50 41 4d 33 0a  Np.D0RW...{PAM3.
  0d60: 03 00 0a 01 70 00 44 30 52 57 70 00 44 30 4c 4e  ....p.D0RWp.D0LN
  0d70: a0 12 92 7b 50 41 4d 33 0a 03 00 70 0b 00 40 44  ...{PAM3...p..-QzqGQSpSiBI@public.gmane.org
  0d80: 30 4c 4e 8d 52 53 52 43 0b 88 06 44 34 52 57 8a  0LN.RSRC...D4RW.
  0d90: 52 53 52 43 0a d6 44 34 4d 4e 8a 52 53 52 43 0a  RSRC..D4MN.RSRC.
  0da0: da 44 34 4d 58 8a 52 53 52 43 0a e2 44 34 4c 4e  .D4MX.RSRC..D4LN
  0db0: 70 01 44 34 52 57 a0 12 93 7b 50 41 4d 33 0a 30  p.D4RW...{PAM3.0
  0dc0: 00 0a 10 70 00 44 34 52 57 70 00 44 34 4c 4e a0  ...p.D4RWp.D4LN.
  0dd0: 12 92 7b 50 41 4d 33 0a 30 00 70 0b 00 40 44 34  ..{PAM3.0.p..-YfRg8wK/X+g@public.gmane.org
  0de0: 4c 4e 8d 52 53 52 43 0b 60 07 44 38 52 57 8a 52  LN.RSRC.`.D8RW.R
  0df0: 53 52 43 0a f1 44 38 4d 4e 8a 52 53 52 43 0a f5  SRC..D8MN.RSRC..
  0e00: 44 38 4d 58 8a 52 53 52 43 0a fd 44 38 4c 4e 70  D8MX.RSRC..D8LNp
  0e10: 01 44 38 52 57 a0 12 93 7b 50 41 4d 34 0a 03 00  .D8RW...{PAM4...
  0e20: 0a 01 70 00 44 38 52 57 70 00 44 38 4c 4e a0 12  ..p.D8RWp.D8LN..
  0e30: 92 7b 50 41 4d 34 0a 03 00 70 0b 00 40 44 38 4c  .{PAM4...p..-IH8I4FTxK7U@public.gmane.org
  0e40: 4e 8d 52 53 52 43 0b 38 08 44 43 52 57 8a 52 53  N.RSRC.8.DCRW.RS
  0e50: 52 43 0b 0c 01 44 43 4d 4e 8a 52 53 52 43 0b 10  RC...DCMN.RSRC..
  0e60: 01 44 43 4d 58 8a 52 53 52 43 0b 18 01 44 43 4c  .DCMX.RSRC...DCL
  0e70: 4e 70 01 44 43 52 57 a0 12 93 7b 50 41 4d 34 0a  Np.DCRW...{PAM4.
  0e80: 30 00 0a 10 70 00 44 43 52 57 70 00 44 43 4c 4e  0...p.DCRWp.DCLN
  0e90: a0 12 92 7b 50 41 4d 34 0a 30 00 70 0b 00 40 44  ...{PAM4.0.p..-QzqGQSpSiBI@public.gmane.org
  0ea0: 43 4c 4e 8d 52 53 52 43 0b 10 09 45 30 52 57 8a  CLN.RSRC...E0RW.
  0eb0: 52 53 52 43 0b 27 01 45 30 4d 4e 8a 52 53 52 43  RSRC.'.E0MN.RSRC
  0ec0: 0b 2b 01 45 30 4d 58 8a 52 53 52 43 0b 33 01 45  .+.E0MX.RSRC.3.E
  0ed0: 30 4c 4e 70 01 45 30 52 57 a0 12 93 7b 50 41 4d  0LNp.E0RW...{PAM
  0ee0: 35 0a 03 00 0a 01 70 00 45 30 52 57 70 00 45 30  5.....p.E0RWp.E0
  0ef0: 4c 4e a0 12 92 7b 50 41 4d 35 0a 03 00 70 0b 00  LN...{PAM5...p..
  0f00: 40 45 30 4c 4e 8d 52 53 52 43 0b e8 09 45 34 52  @E0LN.RSRC...E4R
  0f10: 57 8a 52 53 52 43 0b 42 01 45 34 4d 4e 8a 52 53  W.RSRC.B.E4MN.RS
  0f20: 52 43 0b 46 01 45 34 4d 58 8a 52 53 52 43 0b 4e  RC.F.E4MX.RSRC.N
  0f30: 01 45 34 4c 4e 70 01 45 34 52 57 a0 12 93 7b 50  .E4LNp.E4RW...{P
  0f40: 41 4d 35 0a 30 00 0a 10 70 00 45 34 52 57 70 00  AM5.0...p.E4RWp.
  0f50: 45 34 4c 4e a0 12 92 7b 50 41 4d 35 0a 30 00 70  E4LN...{PAM5.0.p
  0f60: 0b 00 40 45 34 4c 4e 8d 52 53 52 43 0b c0 0a 45  ..-45QKx6p2129NNAR7reVVHg@public.gmane.org
  0f70: 38 52 57 8a 52 53 52 43 0b 5d 01 45 38 4d 4e 8a  8RW.RSRC.].E8MN.
  0f80: 52 53 52 43 0b 61 01 45 38 4d 58 8a 52 53 52 43  RSRC.a.E8MX.RSRC
  0f90: 0b 69 01 45 38 4c 4e 70 01 45 38 52 57 a0 12 93  .i.E8LNp.E8RW...
  0fa0: 7b 50 41 4d 36 0a 03 00 0a 01 70 00 45 38 52 57  {PAM6.....p.E8RW
  0fb0: 70 00 45 38 4c 4e a0 12 92 7b 50 41 4d 36 0a 03  p.E8LN...{PAM6..
  0fc0: 00 70 0b 00 40 45 38 4c 4e 8d 52 53 52 43 0b 98  .p..-n3Psk3W62Clfve50JFu0JA@public.gmane.org
  0fd0: 0b 45 43 52 57 8a 52 53 52 43 0b 78 01 45 43 4d  .ECRW.RSRC.x.ECM
  0fe0: 4e 8a 52 53 52 43 0b 7c 01 45 43 4d 58 8a 52 53  N.RSRC.|.ECMX.RS
  0ff0: 52 43 0b 84 01 45 43 4c 4e 70 01 45 43 52 57 a0  RC...ECLNp.ECRW.
  1000: 12 93 7b 50 41 4d 36 0a 30 00 0a 10 70 00 45 43  ..{PAM6.0...p.EC
  1010: 52 57 70 00 45 43 4c 4e a0 12 92 7b 50 41 4d 36  RWp.ECLN...{PAM6
  1020: 0a 30 00 70 0b 00 40 45 43 4c 4e a4 52 53 52 43  .0.p..-PxdhSnB0ktF/8xXOW9rC8g@public.gmane.org
  1030: 08 5f 50 52 54 12 46 19 0d 12 1e 04 0c ff ff 07  ._PRT.F.........
  1040: 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 50 49  ...\/._SB_PCI0PI
  1050: 42 5f 4c 4e 4b 41 0a 00 12 1e 04 0c ff ff 07 00  B_LNKA..........
  1060: 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30 50 49 42  ..\/._SB_PCI0PIB
  1070: 5f 4c 4e 4b 42 0a 00 12 1e 04 0c ff ff 07 00 0a  _LNKB...........
  1080: 02 5c 2f 04 5f 53 42 5f 50 43 49 30 50 49 42 5f  .\/._SB_PCI0PIB_
  1090: 4c 4e 4b 43 0a 00 12 1e 04 0c ff ff 07 00 0a 03  LNKC............
  10a0: 5c 2f 04 5f 53 42 5f 50 43 49 30 50 49 42 5f 4c  \/._SB_PCI0PIB_L
  10b0: 4e 4b 44 0a 00 12 1e 04 0c ff ff 0c 00 0a 00 5c  NKD............\
  10c0: 2f 04 5f 53 42 5f 50 43 49 30 50 49 42 5f 4c 4e  /._SB_PCI0PIB_LN
  10d0: 4b 41 0a 00 12 1e 04 0c ff ff 0c 00 0a 01 5c 2f  KA............\/
  10e0: 04 5f 53 42 5f 50 43 49 30 50 49 42 5f 4c 4e 4b  ._SB_PCI0PIB_LNK
  10f0: 42 0a 00 12 1e 04 0c ff ff 0c 00 0a 02 5c 2f 04  B............\/.
  1100: 5f 53 42 5f 50 43 49 30 50 49 42 5f 4c 4e 4b 43  _SB_PCI0PIB_LNKC
  1110: 0a 00 12 1e 04 0c ff ff 05 00 0a 00 5c 2f 04 5f  ............\/._
  1120: 53 42 5f 50 43 49 30 50 49 42 5f 4c 4e 4b 42 0a  SB_PCI0PIB_LNKB.
  1130: 00 12 1e 04 0c ff ff 08 00 0a 00 5c 2f 04 5f 53  ...........\/._S
  1140: 42 5f 50 43 49 30 50 49 42 5f 4c 4e 4b 41 0a 00  B_PCI0PIB_LNKA..
  1150: 12 1e 04 0c ff ff 0b 00 0a 00 5c 2f 04 5f 53 42  ..........\/._SB
  1160: 5f 50 43 49 30 50 49 42 5f 4c 4e 4b 41 0a 00 12  _PCI0PIB_LNKA...
  1170: 1e 04 0c ff ff 0b 00 0a 01 5c 2f 04 5f 53 42 5f  .........\/._SB_
  1180: 50 43 49 30 50 49 42 5f 4c 4e 4b 42 0a 00 12 1e  PCI0PIB_LNKB....
  1190: 04 0c ff ff 09 00 0a 00 5c 2f 04 5f 53 42 5f 50  ........\/._SB_P
  11a0: 43 49 30 50 49 42 5f 4c 4e 4b 41 0a 00 12 1e 04  CI0PIB_LNKA.....
  11b0: 0c ff ff 0a 00 0a 00 5c 2f 04 5f 53 42 5f 50 43  .......\/._SB_PC
  11c0: 49 30 50 49 42 5f 4c 4e 4b 44 0a 00 5b 82 8d 14  I0PIB_LNKD..[...
  11d0: 01 50 49 42 5f 08 5f 41 44 52 0c 00 00 07 00 5b  .PIB_._ADR.....[
  11e0: 80 49 52 51 52 02 0a 00 0a f8 5b 81 41 08 49 52  .IRQR.....[.A.IR
  11f0: 51 52 01 00 40 24 00 02 45 55 53 42 01 00 3d 46  QR..@$..EUSB..=3D=
F
  1200: 44 44 41 02 4c 50 44 41 02 00 04 46 44 49 51 04  DDA.LPDA...FDIQ.
  1210: 4c 50 49 51 04 53 41 49 51 04 53 42 49 51 04 00  LPIQ.SAIQ.SBIQ..
  1220: 10 00 04 50 49 52 41 04 50 49 52 42 04 50 49 52  ...PIRA.PIRB.PIR
  1230: 43 04 00 04 50 49 52 44 04 00 40 10 5a 30 30 30  C...PIRD..-jHbn9DYqPhY@public.gmane.org
  1240: 10 00 38 50 44 43 31 08 50 44 43 32 08 50 44 43  ..8PDC1.PDC2.PDC
  1250: 33 08 50 44 43 34 08 45 58 46 45 08 00 20 5a 30  3.PDC4.EXFE.. Z0
  1260: 30 31 01 00 07 00 48 35 43 4c 4b 52 08 5b 82 45  01....H5CLKR.[.E
  1270: 12 4c 4e 4b 41 08 5f 48 49 44 0c 41 d0 0c 0f 08  .LNKA._HID.A....
  1280: 5f 55 49 44 0a 01 08 5f 50 52 53 11 09 0a 06 23  _UID..._PRS....#
  1290: 00 02 18 79 00 14 1b 5f 44 49 53 00 70 00 5c 2f  ...y..._DIS.p.\/
  12a0: 04 5f 53 42 5f 50 43 49 30 50 49 42 5f 50 49 52  ._SB_PCI0PIB_PIR
  12b0: 41 14 26 5f 53 54 41 00 a0 1a 93 5c 2f 04 5f 53  A.&_STA....\/._S
  12c0: 42 5f 50 43 49 30 50 49 42 5f 50 49 52 41 0a 00  B_PCI0PIB_PIRA..
  12d0: a4 0a 09 a1 04 a4 0a 0b 14 4f 06 5f 43 52 53 00  .........O._CRS.
  12e0: 08 42 55 46 41 11 09 0a 06 23 00 00 18 79 00 8c  .BUFA....#...y..
  12f0: 42 55 46 41 0a 01 49 52 41 31 8c 42 55 46 41 0a  BUFA..IRA1.BUFA.
  1300: 02 49 52 41 32 70 5c 2f 04 5f 53 42 5f 50 43 49  .IRA2p\/._SB_PCI
  1310: 30 50 49 42 5f 50 49 52 41 60 a0 28 94 60 0a 00  0PIB_PIRA`.(.`..
  1320: a0 15 94 60 0a 07 74 60 0a 08 60 70 0a 01 61 79  ...`..t`..`p..ay
  1330: 61 60 49 52 41 32 a1 0c 70 0a 01 61 79 61 60 49  a`IRA2..p..aya`I
  1340: 52 41 31 a4 42 55 46 41 14 4b 04 5f 53 52 53 01  RA1.BUFA.K._SRS.
  1350: 8c 68 0a 01 49 52 41 31 8c 68 0a 02 49 52 41 32  .h..IRA1.h..IRA2
  1360: a0 14 94 49 52 41 32 00 81 49 52 41 32 60 76 60  ...IRA2..IRA2`v`
  1370: 72 60 0a 08 60 a1 09 81 49 52 41 31 60 76 60 70  r`..`...IRA1`v`p
  1380: 60 5c 2f 04 5f 53 42 5f 50 43 49 30 50 49 42 5f  `\/._SB_PCI0PIB_
  1390: 50 49 52 41 5b 82 45 12 4c 4e 4b 42 08 5f 48 49  PIRA[.E.LNKB._HI
  13a0: 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 02 08 5f 50  D.A...._UID..._P
  13b0: 52 53 11 09 0a 06 23 00 08 18 79 00 14 1b 5f 44  RS....#...y..._D
  13c0: 49 53 00 70 00 5c 2f 04 5f 53 42 5f 50 43 49 30  IS.p.\/._SB_PCI0
  13d0: 50 49 42 5f 50 49 52 42 14 26 5f 53 54 41 00 a0  PIB_PIRB.&_STA..
  13e0: 1a 93 5c 2f 04 5f 53 42 5f 50 43 49 30 50 49 42  ..\/._SB_PCI0PIB
  13f0: 5f 50 49 52 42 0a 00 a4 0a 09 a1 04 a4 0a 0b 14  _PIRB...........
  1400: 4f 06 5f 43 52 53 00 08 42 55 46 42 11 09 0a 06  O._CRS..BUFB....
  1410: 23 00 00 18 79 00 8c 42 55 46 42 0a 01 49 52 42  #...y..BUFB..IRB
  1420: 31 8c 42 55 46 42 0a 02 49 52 42 32 70 5c 2f 04  1.BUFB..IRB2p\/.
  1430: 5f 53 42 5f 50 43 49 30 50 49 42 5f 50 49 52 42  _SB_PCI0PIB_PIRB
  1440: 60 a0 28 94 60 0a 00 a0 15 94 60 0a 07 74 60 0a  `.(.`.....`..t`.
  1450: 08 60 70 0a 01 61 79 61 60 49 52 42 32 a1 0c 70  .`p..aya`IRB2..p
  1460: 0a 01 61 79 61 60 49 52 42 31 a4 42 55 46 42 14  ..aya`IRB1.BUFB.
  1470: 4b 04 5f 53 52 53 01 8c 68 0a 01 49 52 42 31 8c  K._SRS..h..IRB1.
  1480: 68 0a 02 49 52 42 32 a0 14 94 49 52 42 32 00 81  h..IRB2...IRB2..
  1490: 49 52 42 32 60 76 60 72 60 0a 08 60 a1 09 81 49  IRB2`v`r`..`...I
  14a0: 52 42 31 60 76 60 70 60 5c 2f 04 5f 53 42 5f 50  RB1`v`p`\/._SB_P
  14b0: 43 49 30 50 49 42 5f 50 49 52 42 5b 82 45 12 4c  CI0PIB_PIRB[.E.L
  14c0: 4e 4b 43 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55  NKC._HID.A...._U
  14d0: 49 44 0a 03 08 5f 50 52 53 11 09 0a 06 23 80 00  ID..._PRS....#..
  14e0: 18 79 00 14 1b 5f 44 49 53 00 70 00 5c 2f 04 5f  .y..._DIS.p.\/._
  14f0: 53 42 5f 50 43 49 30 50 49 42 5f 50 49 52 43 14  SB_PCI0PIB_PIRC.
  1500: 26 5f 53 54 41 00 a0 1a 93 5c 2f 04 5f 53 42 5f  &_STA....\/._SB_
  1510: 50 43 49 30 50 49 42 5f 50 49 52 43 0a 00 a4 0a  PCI0PIB_PIRC....
  1520: 09 a1 04 a4 0a 0b 14 4f 06 5f 43 52 53 00 08 42  .......O._CRS..B
  1530: 55 46 43 11 09 0a 06 23 00 00 18 79 00 8c 42 55  UFC....#...y..BU
  1540: 46 43 0a 01 49 52 43 31 8c 42 55 46 43 0a 02 49  FC..IRC1.BUFC..I
  1550: 52 43 32 70 5c 2f 04 5f 53 42 5f 50 43 49 30 50  RC2p\/._SB_PCI0P
  1560: 49 42 5f 50 49 52 43 60 a0 28 94 60 0a 00 a0 15  IB_PIRC`.(.`....
  1570: 94 60 0a 07 74 60 0a 08 60 70 0a 01 61 79 61 60  .`..t`..`p..aya`
  1580: 49 52 43 32 a1 0c 70 0a 01 61 79 61 60 49 52 43  IRC2..p..aya`IRC
  1590: 31 a4 42 55 46 43 14 4b 04 5f 53 52 53 01 8c 68  1.BUFC.K._SRS..h
  15a0: 0a 01 49 52 43 31 8c 68 0a 02 49 52 43 32 a0 14  ..IRC1.h..IRC2..
  15b0: 94 49 52 43 32 00 81 49 52 43 32 60 76 60 72 60  .IRC2..IRC2`v`r`
  15c0: 0a 08 60 a1 09 81 49 52 43 31 60 76 60 70 60 5c  ..`...IRC1`v`p`\
  15d0: 2f 04 5f 53 42 5f 50 43 49 30 50 49 42 5f 50 49  /._SB_PCI0PIB_PI
  15e0: 52 43 5b 82 4b 12 4c 4e 4b 44 08 5f 48 49 44 0c  RC[.K.LNKD._HID.
  15f0: 41 d0 0c 0f 08 5f 55 49 44 0a 04 08 5f 50 52 53  A...._UID..._PRS
  1600: 11 09 0a 06 23 00 80 18 79 00 14 1b 5f 44 49 53  ....#...y..._DIS
  1610: 00 70 00 5c 2f 04 5f 53 42 5f 50 43 49 30 50 49  .p.\/._SB_PCI0PI
  1620: 42 5f 50 49 52 44 14 26 5f 53 54 41 00 a0 1a 93  B_PIRD.&_STA....
  1630: 5c 2f 04 5f 53 42 5f 50 43 49 30 50 49 42 5f 50  \/._SB_PCI0PIB_P
  1640: 49 52 44 0a 00 a4 0a 09 a1 04 a4 0a 0b 14 45 07  IRD...........E.
  1650: 5f 43 52 53 00 08 42 55 46 44 11 09 0a 06 23 00  _CRS..BUFD....#.
  1660: 00 18 79 00 8c 42 55 46 44 0a 01 49 52 44 31 8c  ..y..BUFD..IRD1.
  1670: 42 55 46 44 0a 02 49 52 44 32 70 5c 2f 04 5f 53  BUFD..IRD2p\/._S
  1680: 42 5f 50 43 49 30 50 49 42 5f 50 49 52 44 60 a0  B_PCI0PIB_PIRD`.
  1690: 2e 94 60 0a 00 a0 18 94 60 0a 07 74 60 0a 08 62  ..`.....`..t`..b
  16a0: 70 0a 01 61 79 61 62 63 70 63 49 52 44 32 a1 0f  p..ayabcpcIRD2..
  16b0: 70 0a 01 61 79 61 60 62 70 62 49 52 44 31 a4 42  p..aya`bpbIRD1.B
  16c0: 55 46 44 14 4b 04 5f 53 52 53 01 8c 68 0a 01 49  UFD.K._SRS..h..I
  16d0: 52 44 31 8c 68 0a 02 49 52 44 32 a0 14 94 49 52  RD1.h..IRD2...IR
  16e0: 44 32 00 81 49 52 44 32 60 76 60 72 60 0a 08 60  D2..IRD2`v`r`..`
  16f0: a1 09 81 49 52 44 31 60 76 60 70 60 5c 2f 04 5f  ...IRD1`v`p`\/._
  1700: 53 42 5f 50 43 49 30 50 49 42 5f 50 49 52 44 5b  SB_PCI0PIB_PIRD[
  1710: 82 35 44 4d 41 43 08 5f 48 49 44 0c 41 d0 02 00  .5DMAC._HID.A...
  1720: 08 5f 43 52 53 11 20 0a 1d 47 01 00 00 00 00 01  ._CRS. ..G......
  1730: 10 47 01 81 00 81 00 01 0f 47 01 c0 00 c0 00 01  .G.......G......
  1740: 20 2a 10 02 79 00 5b 82 2c 50 49 43 5f 08 5f 48   *..y.[.,PIC_._H
  1750: 49 44 0b 41 d0 08 5f 43 52 53 11 19 0a 16 47 01  ID.A.._CRS....G.
  1760: 20 00 20 00 01 02 47 01 a0 00 a0 00 01 02 23 04   . ...G.......#.
  1770: 00 01 79 00 5b 82 26 54 49 4d 45 08 5f 48 49 44  ..y.[.&TIME._HID
  1780: 0c 41 d0 01 00 08 5f 43 52 53 11 11 0a 0e 47 01  .A...._CRS....G.
  1790: 40 00 40 00 01 04 23 01 00 01 79 00 5b 82 26 52  @.-47IYjYMXMt4@public.gmane.org#...y.[.&R
  17a0: 54 43 5f 08 5f 48 49 44 0c 41 d0 0b 00 08 5f 43  TC_._HID.A...._C
  17b0: 52 53 11 11 0a 0e 47 01 70 00 70 00 01 06 23 00  RS....G.p.p...#.
  17c0: 01 01 79 00 5b 82 26 4d 41 54 48 08 5f 48 49 44  ..y.[.&MATH._HID
  17d0: 0c 41 d0 0c 04 08 5f 43 52 53 11 11 0a 0e 47 01  .A...._CRS....G.
  17e0: f0 00 f0 00 01 0f 23 00 20 01 79 00 5b 82 22 53  ......#. .y.[."S
  17f0: 50 4b 52 08 5f 48 49 44 0c 41 d0 08 00 08 5f 43  PKR._HID.A...._C
  1800: 52 53 11 0d 0a 0a 47 01 61 00 61 00 01 01 79 00  RS....G.a.a...y.
  1810: 5b 82 48 07 53 59 53 52 08 5f 48 49 44 0c 41 d0  [.H.SYSR._HID.A.
  1820: 0c 02 08 5f 43 52 53 11 42 06 0a 5e 47 01 80 00  ..._CRS.B..^G...
  1830: 80 00 01 01 47 01 22 00 22 00 01 01 47 01 b1 00  ....G."."...G...
  1840: b1 00 01 01 47 01 a8 00 a8 00 01 02 47 01 92 00  ....G.......G...
  1850: 92 00 01 01 47 01 10 38 10 38 01 10 47 01 d0 04  ....G..8.8..G...
  1860: d0 04 01 02 47 01 d6 04 d6 04 01 01 47 01 80 04  ....G.......G...
  1870: 80 04 01 10 47 01 0b 04 0b 04 01 01 86 09 00 00  ....G...........
  1880: 00 00 fc ff 00 00 04 00 79 00 5b 82 42 2b 44 49  ........y.[.B+DI
  1890: 47 49 08 5f 48 49 44 0c 1a 09 20 02 08 5f 55 49  GI._HID... .._UI
  18a0: 44 0a 01 08 52 53 52 43 11 10 0a 0d 47 01 00 00  D...RSRC....G...
  18b0: 00 00 08 08 22 00 00 79 00 08 5f 50 52 53 11 13  ...."..y.._PRS..
  18c0: 0a 10 31 04 47 01 f8 03 f8 03 08 08 22 10 00 38  ..1.G......."..8
  18d0: 79 00 5b 80 56 53 49 4f 01 0b f0 03 0a 02 5b 81  y.[.VSIO......[.
  18e0: 10 56 53 49 4f 01 49 4e 44 58 08 44 41 54 41 08  .VSIO.INDX.DATA.
  18f0: 5b 86 2f 49 4e 44 58 44 41 54 41 01 00 40 71 43  [./INDXDATA..-5J4fTS0Ylc8@public.gmane.org
  1900: 52 45 32 08 43 52 45 33 08 00 10 43 52 45 36 08  RE2.CRE3...CRE6.
  1910: 43 52 45 37 08 43 52 45 38 08 00 28 43 52 45 45  CRE7.CRE8..(CREE
  1920: 08 14 35 45 4e 43 47 00 70 5c 2f 04 5f 53 42 5f  ..5ENCG.p\/._SB_
  1930: 50 43 49 30 50 49 42 5f 45 58 46 45 60 7d 60 0a  PCI0PIB_EXFE`}`.
  1940: 02 60 70 60 5c 2f 04 5f 53 42 5f 50 43 49 30 50  .`p`\/._SB_PCI0P
  1950: 49 42 5f 45 58 46 45 14 35 45 58 43 47 00 70 5c  IB_EXFE.5EXCG.p\
  1960: 2f 04 5f 53 42 5f 50 43 49 30 50 49 42 5f 45 58  /._SB_PCI0PIB_EX
  1970: 46 45 60 7b 60 0a fd 60 70 60 5c 2f 04 5f 53 42  FE`{`..`p`\/._SB
  1980: 5f 50 43 49 30 50 49 42 5f 45 58 46 45 14 2c 5f  _PCI0PIB_EXFE.,_
  1990: 53 54 41 00 45 4e 43 47 70 43 52 45 32 60 7b 60  STA.ENCGpCRE2`{`
  19a0: 0a 04 60 a0 0f 60 70 43 52 45 37 61 45 58 43 47  ..`..`pCRE7aEXCG
  19b0: a4 0a 0f 45 58 43 47 a4 0a 0d 14 3a 5f 44 49 53  ...EXCG....:_DIS
  19c0: 00 45 4e 43 47 70 43 52 45 32 60 7b 60 0a fb 60  .ENCGpCRE2`{`..`
  19d0: 70 60 43 52 45 32 70 00 43 52 45 37 45 58 43 47  p`CRE2p.CRE7EXCG
  19e0: 70 00 5c 2f 04 5f 53 42 5f 50 43 49 30 50 49 42  p.\/._SB_PCI0PIB
  19f0: 5f 53 41 49 51 14 4c 0b 5f 43 52 53 00 08 42 55  _SAIQ.L._CRS..BU
  1a00: 46 30 11 10 0a 0d 47 01 f8 03 f8 03 08 08 22 10  F0....G.......".
  1a10: 00 79 00 8c 42 55 46 30 0a 02 49 4f 4c 4f 8c 42  .y..BUF0..IOLO.B
  1a20: 55 46 30 0a 03 49 4f 48 49 8c 42 55 46 30 0a 04  UF0..IOHI.BUF0..
  1a30: 49 4f 52 4c 8c 42 55 46 30 0a 05 49 4f 52 48 8c  IORL.BUF0..IORH.
  1a40: 42 55 46 30 0a 09 49 52 51 4c 45 4e 43 47 70 43  BUF0..IRQLENCGpC
  1a50: 52 45 37 60 70 60 61 7b 61 0a c0 61 7a 61 0a 06  RE7`p`a{a..aza..
  1a60: 61 7b 60 0a 3f 60 79 60 0a 02 60 70 60 49 4f 4c  a{`.?`y`..`p`IOL
  1a70: 4f 70 61 49 4f 48 49 70 49 4f 4c 4f 49 4f 52 4c  OpaIOHIpIOLOIORL
  1a80: 70 49 4f 48 49 49 4f 52 48 45 58 43 47 70 5c 2f  pIOHIIORHEXCGp\/
  1a90: 04 5f 53 42 5f 50 43 49 30 50 49 42 5f 53 41 49  ._SB_PCI0PIB_SAI
  1aa0: 51 60 70 0a 01 61 79 61 60 49 52 51 4c a4 42 55  Q`p..aya`IRQL.BU
  1ab0: 46 30 14 4b 08 5f 53 52 53 01 8c 68 0a 02 49 4f  F0.K._SRS..h..IO
  1ac0: 4c 4f 8c 68 0a 03 49 4f 48 49 8c 68 0a 09 49 52  LO.h..IOHI.h..IR
  1ad0: 51 4c 45 4e 43 47 70 43 52 45 32 60 7b 60 0a fb  QLENCGpCRE2`{`..
  1ae0: 60 70 60 43 52 45 32 70 49 4f 4c 4f 60 7a 60 0a  `p`CRE2pIOLO`z`.
  1af0: 02 60 7b 60 0a fe 60 70 49 4f 48 49 61 79 61 0a  .`{`..`pIOHIaya.
  1b00: 06 61 7d 60 61 60 70 60 43 52 45 37 82 49 52 51  .a}`a`p`CRE7.IRQ
  1b10: 4c 60 76 60 70 60 5c 2f 04 5f 53 42 5f 50 43 49  L`v`p`\/._SB_PCI
  1b20: 30 50 49 42 5f 53 41 49 51 70 43 52 45 32 60 7d  0PIB_SAIQpCRE2`}
  1b30: 60 0a 04 60 70 60 43 52 45 32 45 58 43 47 5b 82  `..`p`CRE2EXCG[.
  1b40: 4d 04 42 54 4e 53 08 5f 48 49 44 0d 43 6f 6d 70  M.BTNS._HID.Comp
  1b50: 61 71 20 54 61 62 6c 65 74 50 43 20 42 75 74 74  aq TabletPC Butt
  1b60: 6f 6e 73 00 08 5f 43 52 53 11 19 0a 16 47 01 60  ons.._CRS....G.`
  1b70: 00 60 00 01 01 47 01 64 00 64 00 01 01 23 02 00  .`...G.d.d...#..
  1b80: 01 79 00 14 09 5f 53 54 41 00 a4 0a 0f 5b 82 4c  .y..._STA....[.L
  1b90: 78 45 43 5f 5f 08 5f 48 49 44 0c 41 d0 0c 09 08  xEC__._HID.A....
  1ba0: 5f 47 50 45 0a 01 08 53 46 42 45 00 08 5f 43 52  _GPE...SFBE.._CR
  1bb0: 53 11 15 0a 12 47 01 62 00 62 00 01 01 47 01 66  S....G.b.b...G.f
  1bc0: 00 66 00 01 01 79 00 5b 80 45 52 41 4d 03 0a 00  .f...y.[.ERAM...
  1bd0: 0a ff 5b 81 45 1d 45 52 41 4d 01 00 40 40 4e 4d  ..[.E.ERAM..@@NM
  1be0: 53 47 08 53 4c 45 44 04 53 4c 50 54 04 4d 4f 44  SG.SLED.SLPT.MOD
  1bf0: 45 01 4b 59 49 4e 01 41 43 50 49 01 50 57 42 4e  E.KYIN.ACPI.PWBN
  1c00: 01 54 4d 57 4b 01 54 4d 45 31 01 46 41 4e 43 01  .TMWK.TME1.FANC.
  1c10: 44 45 54 46 01 4c 49 44 53 01 4c 57 4b 45 01 49  DETF.LIDS.LWKE.I
  1c20: 57 4b 45 01 49 4e 54 4d 01 4d 57 4b 45 01 43 4f  WKE.INTM.MWKE.CO
  1c30: 4d 4d 01 50 4d 45 5f 01 53 42 56 44 01 41 44 50  MM.PME_.SBVD.ADP
  1c40: 5f 01 41 46 4c 54 01 00 01 4c 43 54 56 01 42 41  _.AFLT...LCTV.BA
  1c50: 54 50 04 42 50 55 30 01 00 07 42 53 45 4c 04 00  TP.BPU0...BSEL..
  1c60: 14 42 44 43 5f 10 00 10 42 46 43 5f 10 00 10 42  .BDC_...BFC_...B
  1c70: 54 43 5f 01 00 1f 42 44 56 5f 10 00 10 42 53 54  TC_...BDV_...BST
  1c80: 5f 04 00 1c 42 50 52 5f 10 00 10 42 52 43 5f 10  _...BPR_...BRC_.
  1c90: 00 10 42 50 56 5f 10 00 10 42 54 50 5f 10 00 10  ..BPV_...BTP_...
  1ca0: 42 43 57 5f 10 00 10 42 43 4c 5f 10 00 10 42 43  BCW_...BCL_...BC
  1cb0: 47 5f 08 00 18 42 43 47 32 08 00 18 42 4d 4f 5f  G_...BCG2...BMO_
  1cc0: 08 00 18 42 49 46 5f 20 42 49 46 31 20 42 53 4e  ...BIF_ BIF1 BSN
  1cd0: 5f 20 42 53 4e 31 20 42 54 59 5f 20 54 31 4c 4f  _ BSN1 BTY_ T1LO
  1ce0: 08 54 31 48 49 08 54 32 4c 4f 08 54 32 48 49 08  .T1HI.T2LO.T2HI.
  1cf0: 43 52 54 31 08 43 52 54 32 08 54 4d 50 31 08 54  CRT1.CRT2.TMP1.T
  1d00: 4d 50 32 08 4e 41 42 54 04 42 43 4d 5f 04 43 43  MP2.NABT.BCM_.CC
  1d10: 42 51 10 43 42 54 5f 10 00 08 4f 53 54 5f 04 43  BQ.CBT_...OST_.C
  1d20: 33 46 47 01 00 03 46 53 52 5f 08 46 4f 4d 31 08  3FG...FSR_.FOM1.
  1d30: 46 4f 4d 32 08 46 4f 46 31 08 46 4f 46 32 08 46  FOM2.FOF1.FOF2.F
  1d40: 46 5a 31 08 46 46 5a 32 08 46 46 4d 31 08 46 46  FZ1.FFZ2.FFM1.FF
  1d50: 4d 32 08 53 48 54 31 08 53 48 54 32 08 54 4d 4f  M2.SHT1.SHT2.TMO
  1d60: 44 08 46 4d 44 5f 08 46 46 44 5f 08 46 43 44 5f  D.FMD_.FFD_.FCD_
  1d70: 08 54 53 54 41 04 00 04 57 52 53 5f 01 53 4c 42  .TSTA...WRS_.SLB
  1d80: 5f 01 53 50 57 5f 01 4b 53 43 43 01 4c 42 31 44  _.SPW_.KSCC.LB1D
  1d90: 01 4c 42 32 44 01 54 4d 31 44 01 00 01 4c 42 56  .LB2D.TM1D...LBV
  1da0: 5f 04 00 04 4e 44 4d 44 06 14 43 0d 5f 52 45 47  _...NDMD..C._REG
  1db0: 02 a0 4b 0c 93 68 0a 03 70 69 5c 45 43 46 4c 5b  ..K..h..pi\ECFL[
  1dc0: 23 4d 55 54 30 ff ff 70 00 5c 2f 05 5f 53 42 5f  #MUT0..p.\/._SB_
  1dd0: 50 43 49 30 50 49 42 5f 45 43 5f 5f 54 4d 45 31  PCI0PIB_EC__TME1
  1de0: 70 4e 44 4d 44 5c 2f 03 5f 53 42 5f 57 4d 49 44  pNDMD\/._SB_WMID
  1df0: 53 54 44 5f 70 00 5c 2f 03 5f 53 42 5f 50 43 49  STD_p.\/._SB_PCI
  1e00: 30 4c 52 45 4e 70 0a 00 5c 2f 05 5f 53 42 5f 50  0LRENp..\/._SB_P
  1e10: 43 49 30 50 49 42 5f 45 43 5f 5f 54 31 4c 4f a0  CI0PIB_EC__T1LO.
  1e20: 22 93 4e 44 4d 44 0a 01 70 0a 40 5c 2f 05 5f 53  ".NDMD..p.@\/._S
  1e30: 42 5f 50 43 49 30 50 49 42 5f 45 43 5f 5f 54 31  B_PCI0PIB_EC__T1
  1e40: 48 49 a1 1b 70 0a 4e 5c 2f 05 5f 53 42 5f 50 43  HI..p.N\/._SB_PC
  1e50: 49 30 50 49 42 5f 45 43 5f 5f 54 31 48 49 70 01  I0PIB_EC__T1HIp.
  1e60: 5c 2f 05 5f 53 42 5f 50 43 49 30 50 49 42 5f 45  \/._SB_PCI0PIB_E
  1e70: 43 5f 5f 54 4d 45 31 5b 27 4d 55 54 30 14 42 04  C__TME1['MUT0.B.
  1e80: 5f 51 30 33 00 5b 23 4d 55 54 30 ff ff 70 01 5c  _Q03.[#MUT0..p.\
  1e90: 2f 05 5f 53 42 5f 50 43 49 30 50 49 42 5f 45 43  /._SB_PCI0PIB_EC
  1ea0: 5f 5f 4c 42 31 44 5b 27 4d 55 54 30 86 5c 2e 5f  __LB1D['MUT0.\._
  1eb0: 53 42 5f 43 4d 42 30 0a 80 70 0a 83 44 45 42 47  SB_CMB0..p..DEBG
  1ec0: 14 4b 05 5f 51 30 34 00 5b 23 4d 55 54 30 ff ff  .K._Q04.[#MUT0..
  1ed0: 70 01 5c 2f 05 5f 53 42 5f 50 43 49 30 50 49 42  p.\/._SB_PCI0PIB
  1ee0: 5f 45 43 5f 5f 4c 42 31 44 70 01 5c 2f 05 5f 53  _EC__LB1Dp.\/._S
  1ef0: 42 5f 50 43 49 30 50 49 42 5f 45 43 5f 5f 4c 42  B_PCI0PIB_EC__LB
  1f00: 32 44 5b 27 4d 55 54 30 86 5c 2e 5f 53 42 5f 43  2D['MUT0.\._SB_C
  1f10: 4d 42 30 0a 80 70 0a 84 44 45 42 47 14 27 5f 51  MB0..p..DEBG.'_Q
  1f20: 30 36 00 86 5c 2e 5f 53 42 5f 41 43 5f 5f 0a 80  06..\._SB_AC__..
  1f30: 86 5c 2e 5f 53 42 5f 43 4d 42 30 0a 80 70 0a 86  .\._SB_CMB0..p..
  1f40: 44 45 42 47 14 1a 5f 51 30 38 00 86 5c 2e 5f 53  DEBG.._Q08..\._S
  1f50: 42 5f 43 4d 42 30 0a 81 70 0a 88 44 45 42 47 14  B_CMB0..p..DEBG.
  1f60: 31 5f 51 30 39 00 a0 1d 92 95 53 46 42 45 0a 02  1_Q09.....SFBE..
  1f70: 86 5c 2e 5f 53 42 5f 43 4d 42 30 0a 80 70 0a 89  .\._SB_CMB0..p..
  1f80: 44 45 42 47 a1 0c 72 53 46 42 45 0a 01 53 46 42  DEBG..rSFBE..SFB
  1f90: 45 14 44 0c 5f 51 32 30 00 70 0d 3d 3d 3d 3d 3d  E.D._Q20.p.=3D=3D=
=3D=3D=3D
  1fa0: 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 20 54 68 65 72 6d  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D Therm
  1fb0: 61 6c 20 73 65 6e 73 6f 72 20 74 72 69 70 70 65  al sensor trippe
  1fc0: 64 20 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d  d =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
  1fd0: 3d 3d 3d 00 5b 31 70 0a a0 44 45 42 47 5b 23 4d  =3D=3D=3D.[1p..D=
EBG[#M
  1fe0: 55 54 30 ff ff 70 5c 2f 05 5f 53 42 5f 50 43 49  UT0..p\/._SB_PCI
  1ff0: 30 50 49 42 5f 45 43 5f 5f 54 4d 50 31 60 70 5c  0PIB_EC__TMP1`p\
  2000: 2f 05 5f 53 42 5f 50 43 49 30 50 49 42 5f 45 43  /._SB_PCI0PIB_EC
  2010: 5f 5f 54 31 48 49 61 70 5c 2f 05 5f 53 42 5f 50  __T1HIap\/._SB_P
  2020: 43 49 30 50 49 42 5f 45 43 5f 5f 54 31 4c 4f 62  CI0PIB_EC__T1LOb
  2030: 53 4e 54 50 60 61 62 70 01 5c 2e 5f 54 5a 5f 54  SNTP`abp.\._TZ_T
  2040: 53 43 49 5b 27 4d 55 54 30 86 5c 2e 5f 54 5a 5f  SCI['MUT0.\._TZ_
  2050: 54 48 52 4d 0a 80 14 4c 05 5f 51 32 31 00 70 0a  THRM...L._Q21.p.
  2060: a1 44 45 42 47 5b 23 4d 55 54 30 ff ff 70 01 5c  .DEBG[#MUT0..p.\
  2070: 2f 05 5f 53 42 5f 50 43 49 30 50 49 42 5f 45 43  /._SB_PCI0PIB_EC
  2080: 5f 5f 54 4d 31 44 5b 27 4d 55 54 30 86 5c 2e 5f  __TM1D['MUT0.\._
  2090: 54 5a 5f 54 48 52 4d 0a 81 86 5c 2e 5f 54 5a 5f  TZ_THRM...\._TZ_
  20a0: 54 48 52 4d 0a 80 86 5c 2e 5f 53 42 5f 50 57 52  THRM...\._SB_PWR
  20b0: 42 0a 80 14 4a 0f 5f 51 32 34 00 70 0a a4 44 45  B...J._Q24.p..DE
  20c0: 42 47 70 5c 2f 03 5f 53 42 5f 57 4d 49 44 53 54  BGp\/._SB_WMIDST
  20d0: 44 5f 60 5b 23 4d 55 54 30 ff ff 70 4e 44 4d 44  D_`[#MUT0..pNDMD
  20e0: 61 5b 27 4d 55 54 30 70 61 5c 2f 03 5f 53 42 5f  a['MUT0pa\/._SB_
  20f0: 57 4d 49 44 53 54 44 5f 7b 60 0a 01 60 7b 61 0a  WMIDSTD_{`..`{a.
  2100: 01 61 a0 4e 09 92 93 60 61 5b 23 4d 55 54 30 ff  .a.N...`a[#MUT0.
  2110: ff 70 0a 00 5c 2f 05 5f 53 42 5f 50 43 49 30 50  .p..\/._SB_PCI0P
  2120: 49 42 5f 45 43 5f 5f 54 31 4c 4f a0 2d 93 5c 2f  IB_EC__T1LO.-.\/
  2130: 03 5f 53 42 5f 57 4d 49 44 53 54 44 5f 0a 01 70  ._SB_WMIDSTD_..p
  2140: 0a 40 5c 2f 05 5f 53 42 5f 50 43 49 30 50 49 42  .@\/._SB_PCI0PIB
  2150: 5f 45 43 5f 5f 54 31 48 49 a1 1b 70 0a 4e 5c 2f  _EC__T1HI..p.N\/
  2160: 05 5f 53 42 5f 50 43 49 30 50 49 42 5f 45 43 5f  ._SB_PCI0PIB_EC_
  2170: 5f 54 31 48 49 5b 27 4d 55 54 30 70 01 5c 2e 5f  _T1HI['MUT0p.\._
  2180: 54 5a 5f 54 53 43 49 86 5c 2e 5f 54 5a 5f 54 48  TZ_TSCI.\._TZ_TH
  2190: 52 4d 0a 81 86 5c 2e 5f 54 5a 5f 54 48 52 4d 0a  RM...\._TZ_THRM.
  21a0: 80 86 5c 2e 5f 53 42 5f 57 4d 49 44 0a 80 14 4c  ..\._SB_WMID...L
  21b0: 16 53 4e 54 50 03 70 00 5c 2f 05 5f 53 42 5f 50  .SNTP.p.\/._SB_P
  21c0: 43 49 30 50 49 42 5f 45 43 5f 5f 54 4d 45 31 70  CI0PIB_EC__TME1p
  21d0: 5c 2f 05 5f 53 42 5f 50 43 49 30 50 49 42 5f 45  \/._SB_PCI0PIB_E
  21e0: 43 5f 5f 54 53 54 41 60 a0 43 06 7b 60 0a 01 00  C__TSTA`.C.{`...
  21f0: 70 0d 2d 2d 2d 2d 2d 2d 2d 2d 2d 41 62 6f 76 65  p.---------Above
  2200: 20 41 43 54 49 56 45 5f 54 50 2d 2d 2d 00 5b 31   ACTIVE_TP---.[1
  2210: 74 69 0a 02 61 70 61 5c 2f 05 5f 53 42 5f 50 43  ti..apa\/._SB_PC
  2220: 49 30 50 49 42 5f 45 43 5f 5f 54 31 4c 4f 72 69  I0PIB_EC__T1LOri
  2230: 0a 02 61 70 61 5c 2f 05 5f 53 42 5f 50 43 49 30  ..apa\/._SB_PCI0
  2240: 50 49 42 5f 45 43 5f 5f 54 31 48 49 a0 45 0b 7b  PIB_EC__T1HI.E.{
  2250: 60 0a 02 00 70 0d 2d 2d 2d 2d 2d 2d 2d 2d 2d 42  `...p.---------B
  2260: 65 6c 6f 77 20 53 45 4e 53 4f 52 31 5f 41 43 54  elow SENSOR1_ACT
  2270: 49 56 45 5f 54 50 2d 2d 2d 00 5b 31 74 6a 0a 02  IVE_TP---.[1tj..
  2280: 61 a0 11 90 93 4e 44 4d 44 0a 01 95 61 0a 40 70  a....NDMD...a.-eBImoM+uyKU@public.gmane.org
  2290: 0a 00 61 a0 12 90 92 93 4e 44 4d 44 0a 01 95 61  ..a.....NDMD...a
  22a0: 0a 4e 70 0a 00 61 70 61 5c 2f 05 5f 53 42 5f 50  .Np..apa\/._SB_P
  22b0: 43 49 30 50 49 42 5f 45 43 5f 5f 54 31 4c 4f 72  CI0PIB_EC__T1LOr
  22c0: 6a 0a 02 62 a0 11 90 93 4e 44 4d 44 0a 01 95 62  j..b....NDMD...b
  22d0: 0a 40 70 0a 40 62 a0 12 90 92 93 4e 44 4d 44 0a  .-+uyfzKhf1HQ@public.gmane.org@b.....NDMD.
  22e0: 01 95 62 0a 4e 70 0a 4e 62 70 62 5c 2f 05 5f 53  ..b.Np.Nbpb\/._S
  22f0: 42 5f 50 43 49 30 50 49 42 5f 45 43 5f 5f 54 31  B_PCI0PIB_EC__T1
  2300: 48 49 70 01 5c 2f 05 5f 53 42 5f 50 43 49 30 50  HIp.\/._SB_PCI0P
  2310: 49 42 5f 45 43 5f 5f 54 4d 45 31 08 52 45 47 54  IB_EC__TME1.REGT
  2320: 12 2c 15 0a 10 0a 20 0a 21 0a 22 0a 23 0a 33 0a  .,.... .!.".#.3.
  2330: 34 0a 35 0a 36 0a 37 0a 47 0a 48 0a 49 0a 4a 0a  4.5.6.7.G.H.I.J.
  2340: 4b 0a 4c 0a 5c 0a 5d 0a 5e 0a 5f 0a 6f 08 44 4d  K.L.\.].^._.o.DM
  2350: 54 42 12 12 08 0a 05 0a 04 0a 03 0a 02 0a 02 0a  TB..............
  2360: 01 0a 01 0a 00 08 50 49 4f 54 12 12 07 0b 58 02  ......PIOT....X.
  2370: 0b 7f 01 0a f0 0a b4 0a 78 0a 5a 0a 00 5b 82 4f  ........x.Z..[.O
  2380: 41 49 44 45 5f 08 5f 41 44 52 0c 01 00 07 00 5b  AIDE_._ADR.....[
  2390: 80 50 43 49 5f 02 0a 48 0a 60 5b 81 30 50 43 49  .PCI_..H.`[.0PCI
  23a0: 5f 03 53 44 52 31 08 53 44 52 30 08 50 44 52 31  _.SDR1.SDR0.PDR1
  23b0: 08 50 44 52 30 08 53 44 53 54 04 50 44 53 54 04  .PDR0.SDST.PDST.
  23c0: 00 18 55 44 4d 53 10 55 44 4d 50 10 14 4c 0d 47  ..UDMS.UDMP..L.G
  23d0: 54 4d 5f 03 70 11 03 0a 14 60 8a 60 0a 00 50 49  TM_.p....`.`..PI
  23e0: 4f 30 8a 60 0a 04 44 4d 41 30 8a 60 0a 08 50 49  O0.`..DMA0.`..PI
  23f0: 4f 31 8a 60 0a 0c 44 4d 41 31 8a 60 0a 10 46 4c  O1.`..DMA1.`..FL
  2400: 41 47 70 00 46 4c 41 47 7d 46 4c 41 47 0a 10 46  AGp.FLAG}FLAG..F
  2410: 4c 41 47 72 7b 69 0a 0f 00 7a 69 0a 04 00 61 72  LAGr{i...zi...ar
  2420: 61 0a 02 61 77 61 0a 1e 50 49 4f 30 7d 46 4c 41  a..awa..PIO0}FLA
  2430: 47 0a 02 46 4c 41 47 72 7b 6a 0a 0f 00 7a 6a 0a  G..FLAGr{j...zj.
  2440: 04 00 61 72 61 0a 02 61 77 61 0a 1e 50 49 4f 31  ..ara..awa..PIO1
  2450: 7d 46 4c 41 47 0a 08 46 4c 41 47 a0 12 7b 68 0b  }FLAG..FLAG..{h.
  2460: 00 e0 00 7d 46 4c 41 47 0a 01 46 4c 41 47 72 7a  ...}FLAG..FLAGrz
  2470: 7b 68 0b 00 07 00 0a 08 00 0a 02 61 77 61 0a 0a  {h.........awa..
  2480: 44 4d 41 30 a0 11 7b 68 0a e0 00 7d 46 4c 41 47  DMA0..{h...}FLAG
  2490: 0a 04 46 4c 41 47 72 7b 68 0a 07 00 0a 02 61 77  ..FLAGr{h.....aw
  24a0: 61 0a 0a 44 4d 41 31 a4 60 14 40 13 53 54 4d 5f  a..DMA1.`.-9BQ0Qf6Xbd4@public.gmane.org
  24b0: 03 70 11 03 0a 05 67 8b 67 0a 00 55 44 4d 54 8b  .p....g.g..UDMT.
  24c0: 67 0a 02 50 49 4f 54 8c 67 0a 04 52 34 43 54 8a  g..PIOT.g..R4CT.
  24d0: 68 0a 00 50 49 4f 30 8a 68 0a 04 44 4d 41 30 8a  h..PIO0.h..DMA0.
  24e0: 68 0a 08 50 49 4f 31 8a 68 0a 0c 44 4d 41 31 8a  h..PIO1.h..DMA1.
  24f0: 68 0a 10 46 4c 41 47 70 46 4c 41 47 64 70 0b 07  h..FLAGpFLAGdp..
  2500: 07 61 a0 26 7b 64 0a 01 00 7b 61 0a 07 61 78 44  .a.&{d...{a..axD
  2510: 4d 41 30 0a 0a 00 63 74 63 0a 02 63 7d 63 0a e0  MA0...ctc..c}c..
  2520: 63 7d 79 63 0a 08 63 61 61 a0 22 7b 64 0a 04 00  c}yc..caa."{d...
  2530: 7b 61 0b 00 ff 61 78 44 4d 41 31 0a 0a 00 63 74  {a...axDMA1...ct
  2540: 63 0a 02 63 7d 7d 63 0a e0 00 61 61 70 61 55 44  c..c}}c...aapaUD
  2550: 4d 54 70 0a 0a 62 a0 34 7b 64 0a 02 00 78 50 49  MTp..b.4{d...xPI
  2560: 4f 30 0a 1e 00 63 74 63 0a 03 63 a0 0f 95 63 0a  O0...ctc..c...c.
  2570: 0c 7b 62 0a 03 62 7d 62 0a 04 62 70 79 83 88 5e  .{b..b}b..bpy..^
  2580: 5e 52 45 47 54 63 00 0a 08 00 66 a1 05 70 0a 00  ^REGTc....f..p..
  2590: 66 a0 30 7b 64 0a 08 00 78 50 49 4f 31 0a 1e 00  f.0{d...xPIO1...
  25a0: 63 74 63 0a 03 63 a0 0f 95 63 0a 0c 7b 62 0a 0c  ctc..c...c..{b..
  25b0: 62 7d 62 0a 01 62 70 83 88 5e 5e 52 45 47 54 63  b}b..bp..^^REGTc
  25c0: 00 66 a1 09 70 7b 66 0b 00 ff 00 66 70 62 52 34  .f..p{f....fpbR4
  25d0: 43 54 70 66 50 49 4f 54 a4 67 14 44 09 47 54 46  CTpfPIOT.g.D.GTF
  25e0: 5f 03 a0 0f 6a 70 11 0a 0a 07 03 00 00 00 00 a0  _...jp..........
  25f0: ef 67 a1 0e 70 11 0a 0a 07 03 00 00 00 00 b0 ef  .g..p...........
  2600: 67 8c 67 0a 01 4d 4f 44 45 72 7b 68 0a 0f 00 7a  g.g..MODEr{h...z
  2610: 68 0a 04 00 61 72 61 0a 02 61 77 61 0a 1e 60 70  h...ara..awa..`p
  2620: 89 5e 5e 50 49 4f 54 03 60 00 0a 00 0a 00 61 a0  .^^PIOT.`.....a.
  2630: 04 61 76 61 a0 1e 7b 69 0a e0 00 70 83 88 5e 5e  .ava..{i...p..^^
  2640: 44 4d 54 42 7b 69 0a 07 00 00 60 7d 60 0a 40 4d  DMTB{i....`}`.-fM0AETQt39g@public.gmane.org
  2650: 4f 44 45 a1 09 7d 61 0a 08 4d 4f 44 45 73 67 67  ODE..}a..MODEsgg
  2660: 66 7d 61 0a 08 4d 4f 44 45 73 66 67 65 a4 65 5b  f}a..MODEsfge.e[
  2670: 82 4d 12 50 52 49 4d 08 5f 41 44 52 0a 00 14 3f  .M.PRIM._ADR...?
  2680: 5f 47 54 4d 00 70 0d 47 54 4d 20 2d 20 50 72 69  _GTM.p.GTM - Pri
  2690: 6d 61 72 79 20 43 6f 6e 74 72 6f 6c 6c 65 72 00  mary Controller.
  26a0: 5b 31 70 5e 5e 47 54 4d 5f 5e 5e 55 44 4d 50 5e  [1p^^GTM_^^UDMP^
  26b0: 5e 50 44 52 30 5e 5e 50 44 52 31 60 a4 60 14 45  ^PDR0^^PDR1`.`.E
  26c0: 08 5f 53 54 4d 03 70 0d 53 54 4d 20 2d 20 50 72  ._STM.p.STM - Pr
  26d0: 69 6d 61 72 79 20 43 6f 6e 74 72 6f 6c 6c 65 72  imary Controller
  26e0: 00 5b 31 70 5e 5e 53 54 4d 5f 68 69 6a 60 8b 60  .[1p^^STM_hij`.`
  26f0: 0a 00 55 44 4d 41 8b 60 0a 02 50 49 4f 4d 8c 60  ..UDMA.`..PIOM.`
  2700: 0a 04 41 44 53 54 70 55 44 4d 41 5e 5e 55 44 4d  ..ADSTpUDMA^^UDM
  2710: 50 70 7b 50 49 4f 4d 0a ff 00 61 a0 0a 61 70 61  Pp{PIOM...a..apa
  2720: 5e 5e 50 44 52 31 7a 50 49 4f 4d 0a 08 61 a0 0a  ^^PDR1zPIOM..a..
  2730: 61 70 61 5e 5e 50 44 52 30 70 41 44 53 54 5e 5e  apa^^PDR0pADST^^
  2740: 50 44 53 54 5b 82 48 05 4d 41 53 54 08 5f 41 44  PDST[.H.MAST._AD
  2750: 52 0a 00 14 3f 5f 47 54 46 00 70 0d 47 54 46 20  R...?_GTF.p.GTF=20
  2760: 2d 20 50 72 69 6d 61 72 79 20 4d 61 73 74 65 72  - Primary Master
  2770: 00 5b 31 7a 5e 5e 5e 55 44 4d 50 0a 08 60 70 5e  .[1z^^^UDMP..`p^
  2780: 5e 5e 47 54 46 5f 5e 5e 5e 50 44 52 30 60 0a 01  ^^GTF_^^^PDR0`..
  2790: 60 a4 60 08 46 57 53 4f 0d 46 57 53 4f 00 5b 82  `.`.FWSO.FWSO.[.
  27a0: 4a 12 50 4d 5f 5f 08 5f 48 49 44 0c 41 d0 0c 02  J.PM__._HID.A...
  27b0: 08 5f 55 49 44 0a f1 08 52 53 52 43 11 15 0a 12  ._UID...RSRC....
  27c0: 47 01 00 10 00 10 01 80 47 01 00 10 00 10 01 80  G.......G.......
  27d0: 79 00 08 5f 41 44 52 0c 04 00 07 00 5b 80 53 42  y.._ADR.....[.SB
  27e0: 37 34 02 0a 00 0b 00 01 5b 81 1e 53 42 37 34 01  74......[..SB74.
  27f0: 00 40 24 5a 30 30 34 10 00 40 13 5a 30 30 35 10  .@$Z004..-UFAkP6YLonA@public.gmane.org
  2800: 00 40 0f 5a 30 30 36 10 5b 80 50 4d 49 4f 01 0b  .-plZWRbuQpmk@public.gmane.org[.PMIO..
  2810: 00 80 0a 50 5b 81 4f 04 50 4d 49 4f 01 00 48 08  ...P[.O.PMIO..H.
  2820: 50 42 43 52 08 00 40 07 47 50 53 4c 08 47 50 53  PBCR..-/th+CNC1v0mndFcnP4VZoA@public.gmane.org
  2830: 48 08 00 48 06 53 43 4d 44 08 00 40 0c 47 49 30  H..H.SCMD..-OgoOcQVi5OU@public.gmane.org
  2840: 30 08 47 49 30 38 08 47 49 31 36 08 47 49 32 34  0.GI08.GI16.GI24
  2850: 08 47 4f 30 30 08 47 4f 30 38 08 47 4f 31 36 08  .GO00.GO08.GO16.
  2860: 47 4f 32 34 08 14 44 06 5f 43 52 53 08 8b 52 53  GO24..D._CRS..RS
  2870: 52 43 0a 02 50 4d 4d 4e 8b 52 53 52 43 0a 04 50  RC..PMMN.RSRC..P
  2880: 4d 4d 58 7b 5e 5a 30 30 34 0b 80 ff 50 4d 4d 4e  MMX{^Z004...PMMN
  2890: 70 50 4d 4d 4e 50 4d 4d 58 8b 52 53 52 43 0a 0a  pPMMNPMMX.RSRC..
  28a0: 48 4d 4d 4e 8b 52 53 52 43 0a 0c 48 4d 4d 58 7b  HMMN.RSRC..HMMX{
  28b0: 5e 5a 30 30 35 0b 80 ff 48 4d 4d 4e 70 48 4d 4d  ^Z005...HMMNpHMM
  28c0: 4e 48 4d 4d 58 a4 52 53 52 43 5b 82 2a 41 55 44  NHMMX.RSRC[.*AUD
  28d0: 4f 08 5f 41 44 52 0c 05 00 07 00 5b 80 53 42 37  O._ADR.....[.SB7
  28e0: 35 02 0a 00 0a 85 5b 81 0e 53 42 37 35 00 00 40  5.....[..SB75..@
  28f0: 1e 41 43 49 52 04 5b 82 0f 4d 4f 44 4d 08 5f 41  .ACIR.[..MODM._A
  2900: 44 52 0c 06 00 07 00 5b 82 0f 56 49 44 4f 08 5f  DR.....[..VIDO._
  2910: 41 44 52 0c 00 00 05 00 5b 82 1b 4c 41 4e 49 08  ADR.....[..LANI.
  2920: 5f 41 44 52 0c 00 00 08 00 08 5f 50 52 57 12 06  _ADR......_PRW..
  2930: 02 0a 05 0a 03 5b 82 4e 09 43 52 44 30 08 5f 41  .....[.N.CRD0._A
  2940: 44 52 0c 00 00 0b 00 5b 80 43 42 44 30 02 0a 00  DR.....[.CBD0...
  2950: 0a c0 5b 81 3b 43 42 44 30 00 00 40 1e 43 44 33  ..[.;CBD0..-j1LxNWvtFfk@public.gmane.org
  2960: 43 08 00 38 43 44 34 34 20 00 40 1c 4f 50 4d 45  C..8CD44 .-he5F/HZsbQ4@public.gmane.org
  2970: 01 00 47 07 4d 46 30 36 04 00 44 0a 50 57 53 54  ..G.MF06..D.PWST
  2980: 02 00 06 50 4d 45 45 01 00 06 50 4d 53 54 01 14  ...PMEE...PMST..
  2990: 39 5f 49 4e 49 00 7d 43 44 33 43 0a ff 43 44 33  9_INI.}CD3C..CD3
  29a0: 43 70 0a 00 43 44 34 34 7d 4f 50 4d 45 0a 01 4f  Cp..CD44}OPME..O
  29b0: 50 4d 45 7d 50 4d 45 45 0a 01 50 4d 45 45 7d 4d  PME}PMEE..PMEE}M
  29c0: 46 30 36 0a 01 4d 46 30 36 08 5f 50 52 57 12 06  F06..MF06._PRW..
  29d0: 02 0a 05 0a 03 5b 82 4e 09 43 52 44 31 08 5f 41  .....[.N.CRD1._A
  29e0: 44 52 0c 01 00 0b 00 5b 80 43 42 44 31 02 0a 00  DR.....[.CBD1...
  29f0: 0a b4 5b 81 3b 43 42 44 31 00 00 40 1e 43 44 33  ..[.;CBD1..-j1LxNWvtFfk@public.gmane.org
  2a00: 43 08 00 38 43 44 34 34 20 00 40 1c 4f 50 4d 45  C..8CD44 .-he5F/HZsbQ4@public.gmane.org
  2a10: 01 00 47 07 4d 46 30 36 04 00 44 0a 50 57 53 54  ..G.MF06..D.PWST
  2a20: 02 00 06 50 4d 45 45 01 00 06 50 4d 53 54 01 14  ...PMEE...PMST..
  2a30: 39 5f 49 4e 49 00 7d 43 44 33 43 0a ff 43 44 33  9_INI.}CD3C..CD3
  2a40: 43 70 0a 00 43 44 34 34 7d 4f 50 4d 45 0a 01 4f  Cp..CD44}OPME..O
  2a50: 50 4d 45 7d 50 4d 45 45 0a 01 50 4d 45 45 7d 4d  PME}PMEE..PMEE}M
  2a60: 46 30 36 0a 01 4d 46 30 36 08 5f 50 52 57 12 06  F06..MF06._PRW..
  2a70: 02 0a 05 0a 03 5b 82 44 07 55 53 42 30 08 5f 41  .....[.D.USB0._A
  2a80: 44 52 0c 00 00 0c 00 5b 80 4e 55 44 30 02 0a 00  DR.....[.NUD0...
  2a90: 0a e8 5b 81 13 4e 55 44 30 00 00 40 22 50 4d 43  ..[..NUD0..@"PMC
  2aa0: 52 08 50 4d 43 53 08 08 5f 50 52 57 12 06 02 0a  R.PMCS.._PRW....
  2ab0: 05 0a 03 5b 82 36 52 48 55 42 08 5f 41 44 52 0a  ...[.6RHUB._ADR.
  2ac0: 00 5b 82 0c 50 4f 54 30 08 5f 41 44 52 0a 00 5b  .[..POT0._ADR..[
  2ad0: 82 0c 50 4f 54 31 08 5f 41 44 52 0a 01 5b 82 0c  ..POT1._ADR..[..
  2ae0: 50 4f 54 32 08 5f 41 44 52 0a 02 5b 82 46 06 55  POT2._ADR..[.F.U
  2af0: 53 42 31 08 5f 41 44 52 0c 01 00 0c 00 5b 80 4e  SB1._ADR.....[.N
  2b00: 55 44 31 02 0a 00 0a e8 5b 81 13 4e 55 44 31 00  UD1.....[..NUD1.
  2b10: 00 40 22 50 4d 43 52 08 50 4d 43 53 08 08 5f 50  .@"PMCR.PMCS.._P
  2b20: 52 57 12 06 02 0a 05 0a 03 5b 82 28 52 48 55 42  RW.......[.(RHUB
  2b30: 08 5f 41 44 52 0a 00 5b 82 0c 50 4f 54 30 08 5f  ._ADR..[..POT0._
  2b40: 41 44 52 0a 00 5b 82 0c 50 4f 54 31 08 5f 41 44  ADR..[..POT1._AD
  2b50: 52 0a 01 5b 82 41 09 55 53 42 32 08 5f 41 44 52  R..[.A.USB2._ADR
  2b60: 0c 02 00 0c 00 5b 80 4e 55 44 32 02 0a 00 0a e8  .....[.NUD2.....
  2b70: 5b 81 13 4e 55 44 32 00 00 40 22 50 4d 43 52 08  [..NUD2..@"PMCR.
  2b80: 50 4d 43 53 08 08 5f 50 52 57 12 06 02 0a 05 0a  PMCS.._PRW......
  2b90: 03 5b 82 43 05 52 48 55 42 08 5f 41 44 52 0a 00  .[.C.RHUB._ADR..
  2ba0: 5b 82 0c 50 4f 54 30 08 5f 41 44 52 0a 00 5b 82  [..POT0._ADR..[.
  2bb0: 0c 50 4f 54 31 08 5f 41 44 52 0a 01 5b 82 0c 50  .POT1._ADR..[..P
  2bc0: 4f 54 32 08 5f 41 44 52 0a 02 5b 82 0c 50 4f 54  OT2._ADR..[..POT
  2bd0: 33 08 5f 41 44 52 0a 03 5b 82 0c 50 4f 54 34 08  3._ADR..[..POT4.
  2be0: 5f 41 44 52 0a 04 5b 01 56 53 4d 58 00 14 29 56  _ADR..[.VSMX..)V
  2bf0: 53 4d 49 09 5b 23 56 53 4d 58 ff ff 70 68 5c 2f  SMI.[#VSMX..ph\/
  2c00: 04 5f 53 42 5f 50 43 49 30 50 4d 5f 5f 53 43 4d  ._SB_PCI0PM__SCM
  2c10: 44 5b 27 56 53 4d 58 10 2d 5c 2e 5f 53 42 5f 50  D['VSMX.-\._SB_P
  2c20: 43 49 30 5b 80 4c 52 43 52 02 0a a8 0a 04 5b 81  CI0[.LRCR.....[.
  2c30: 15 4c 52 43 52 01 4c 52 4f 4e 01 4c 52 52 56 03  .LRCR.LRON.LRRV.
  2c40: 4c 52 45 4e 01 10 45 4b 5c 5f 54 5a 5f 08 54 53  LREN..EK\_TZ_.TS
  2c50: 43 50 0a 00 08 4c 30 53 54 0a 00 08 4c 31 53 54  CP...L0ST...L1ST
  2c60: 0a 00 08 4c 32 53 54 0a 00 08 54 53 43 49 0a 00  ...L2ST...TSCI..
  2c70: 5b 84 43 0e 4c 52 50 30 00 00 00 14 19 5f 53 54  [.C.LRP0....._ST
  2c80: 41 00 70 0d 4c 52 50 30 20 5f 53 54 41 00 5b 31  A.p.LRP0 _STA.[1
  2c90: a4 4c 30 53 54 14 4b 04 5f 4f 4e 5f 08 a0 43 04  .L0ST.K._ON_..C.
  2ca0: 54 53 43 49 70 0a e0 44 45 42 47 70 0d 4c 52 50  TSCIp..DEBGp.LRP
  2cb0: 30 20 5f 4f 4e 00 5b 31 70 01 4c 30 53 54 70 0a  0 _ON.[1p.L0STp.
  2cc0: 05 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 52 52 56  .\/._SB_PCI0LRRV
  2cd0: 70 01 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 52 45  p.\/._SB_PCI0LRE
  2ce0: 4e 14 43 07 5f 4f 46 46 08 a0 4b 06 54 53 43 49  N.C._OFF..K.TSCI
  2cf0: 70 0d 4c 52 50 30 20 5f 4f 46 46 00 5b 31 70 00  p.LRP0 _OFF.[1p.
  2d00: 4c 30 53 54 70 0a f0 44 45 42 47 a0 36 91 4c 31  L0STp..DEBG.6.L1
  2d10: 53 54 4c 32 53 54 a0 17 4c 31 53 54 70 0a 06 5c  STL2ST..L1STp..\
  2d20: 2f 03 5f 53 42 5f 50 43 49 30 4c 52 52 56 a1 13  /._SB_PCI0LRRV..
  2d30: 70 0a 07 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 52  p..\/._SB_PCI0LR
  2d40: 52 56 a1 12 70 00 5c 2f 03 5f 53 42 5f 50 43 49  RV..p.\/._SB_PCI
  2d50: 30 4c 52 45 4e 5b 84 48 0f 4c 52 50 31 00 00 00  0LREN[.H.LRP1...
  2d60: 14 19 5f 53 54 41 00 70 0d 4c 52 50 31 20 5f 53  .._STA.p.LRP1 _S
  2d70: 54 41 00 5b 31 a4 4c 31 53 54 14 43 05 5f 4f 4e  TA.[1.L1ST.C._ON
  2d80: 5f 08 a0 4b 04 92 4c 30 53 54 a0 43 04 54 53 43  _..K..L0ST.C.TSC
  2d90: 49 70 0a e1 44 45 42 47 70 0d 4c 52 50 31 20 5f  Ip..DEBGp.LRP1 _
  2da0: 4f 4e 00 5b 31 70 01 4c 31 53 54 70 0a 06 5c 2f  ON.[1p.L1STp..\/
  2db0: 03 5f 53 42 5f 50 43 49 30 4c 52 52 56 70 01 5c  ._SB_PCI0LRRVp.\
  2dc0: 2f 03 5f 53 42 5f 50 43 49 30 4c 52 45 4e 14 40  /._SB_PCI0LREN.@
  2dd0: 08 5f 4f 46 46 08 a0 48 07 54 53 43 49 70 0d 4c  ._OFF..H.TSCIp.L
  2de0: 52 50 31 20 5f 4f 46 46 00 5b 31 70 00 4c 31 53  RP1 _OFF.[1p.L1S
  2df0: 54 70 0a f1 44 45 42 47 a0 43 04 91 4c 30 53 54  Tp..DEBG.C..L0ST
  2e00: 4c 32 53 54 a0 23 4c 30 53 54 70 00 4c 30 53 54  L2ST.#L0STp.L0ST
  2e10: 70 0a 07 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 52  p..\/._SB_PCI0LR
  2e20: 52 56 70 01 4c 32 53 54 a1 13 70 0a 07 5c 2f 03  RVp.L2ST..p..\/.
  2e30: 5f 53 42 5f 50 43 49 30 4c 52 52 56 a1 12 70 00  _SB_PCI0LRRV..p.
  2e40: 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 52 45 4e 5b  \/._SB_PCI0LREN[
  2e50: 84 4d 10 4c 52 50 32 00 00 00 14 19 5f 53 54 41  .M.LRP2....._STA
  2e60: 00 70 0d 4c 52 50 32 20 5f 53 54 41 00 5b 31 a4  .p.LRP2 _STA.[1.
  2e70: 4c 32 53 54 14 48 05 5f 4f 4e 5f 08 a0 40 05 92  L2ST.H._ON_..-rVxdn2TrCWA@public.gmane.org
  2e80: 91 4c 30 53 54 4c 31 53 54 a0 43 04 54 53 43 49  .L0STL1ST.C.TSCI
  2e90: 70 0a e2 44 45 42 47 70 0d 4c 52 50 32 20 5f 4f  p..DEBGp.LRP2 _O
  2ea0: 4e 00 5b 31 70 01 4c 32 53 54 70 0a 07 5c 2f 03  N.[1p.L2STp..\/.
  2eb0: 5f 53 42 5f 50 43 49 30 4c 52 52 56 70 01 5c 2f  _SB_PCI0LRRVp.\/
  2ec0: 03 5f 53 42 5f 50 43 49 30 4c 52 45 4e 14 40 09  ._SB_PCI0LREN.-4b8TPpkIZ3Q@public.gmane.org
  2ed0: 5f 4f 46 46 08 a0 48 08 54 53 43 49 70 0d 4c 52  _OFF..H.TSCIp.LR
  2ee0: 50 32 20 5f 4f 46 46 00 5b 31 70 00 4c 32 53 54  P2 _OFF.[1p.L2ST
  2ef0: 70 0a f2 44 45 42 47 70 00 4c 31 53 54 70 00 4c  p..DEBGp.L1STp.L
  2f00: 30 53 54 70 00 5c 2f 03 5f 53 42 5f 50 43 49 30  0STp.\/._SB_PCI0
  2f10: 4c 52 45 4e a0 36 91 4c 30 53 54 4c 31 53 54 a0  LREN.6.L0STL1ST.
  2f20: 17 4c 30 53 54 70 0a 05 5c 2f 03 5f 53 42 5f 50  .L0STp..\/._SB_P
  2f30: 43 49 30 4c 52 52 56 a1 13 70 0a 06 5c 2f 03 5f  CI0LRRV..p..\/._
  2f40: 53 42 5f 50 43 49 30 4c 52 52 56 a1 12 70 00 5c  SB_PCI0LRRV..p.\
  2f50: 2f 03 5f 53 42 5f 50 43 49 30 4c 52 45 4e 5b 82  /._SB_PCI0LREN[.
  2f60: 22 46 41 4e 30 08 5f 48 49 44 0c 41 d0 0c 0b 08  "FAN0._HID.A....
  2f70: 5f 55 49 44 0a 01 08 5f 50 52 30 12 06 01 4c 52  _UID..._PR0...LR
  2f80: 50 30 5b 82 22 46 41 4e 31 08 5f 48 49 44 0c 41  P0[."FAN1._HID.A
  2f90: d0 0c 0b 08 5f 55 49 44 0a 02 08 5f 50 52 30 12  ...._UID..._PR0.
  2fa0: 06 01 4c 52 50 31 5b 82 22 46 41 4e 32 08 5f 48  ..LRP1[."FAN2._H
  2fb0: 49 44 0c 41 d0 0c 0b 08 5f 55 49 44 0a 03 08 5f  ID.A...._UID..._
  2fc0: 50 52 30 12 06 01 4c 52 50 32 5b 85 4f 12 54 48  PR0...LRP2[.O.TH
  2fd0: 52 4d 08 53 43 49 46 0a 00 14 18 5f 41 43 30 00  RM.SCIF...._AC0.
  2fe0: 70 0d 5f 41 43 30 00 5b 31 a4 47 41 43 58 0a 48  p._AC0.[1.GACX.H
  2ff0: 0a 5e 08 5f 41 4c 30 12 06 01 46 41 4e 30 14 18  .^._AL0...FAN0..
  3000: 5f 41 43 31 00 70 0d 5f 41 43 31 00 5b 31 a4 47  _AC1.p._AC1.[1.G
  3010: 41 43 58 0a 44 0a 56 08 5f 41 4c 31 12 06 01 46  ACX.D.V._AL1...F
  3020: 41 4e 31 14 18 5f 41 43 32 00 70 0d 5f 41 43 32  AN1.._AC2.p._AC2
  3030: 00 5b 31 a4 47 41 43 58 0a 40 0a 4e 08 5f 41 4c  .[1.GACX.-/AfyJXdn13Y@public.gmane.org
  3040: 32 12 06 01 46 41 4e 32 14 16 5f 43 52 54 00 70  2...FAN2.._CRT.p
  3050: 0d 5f 43 52 54 00 5b 31 a4 4b 45 4c 56 0a 64 14  ._CRT.[1.KELV.d.
  3060: 44 04 5f 54 4d 50 00 a0 33 5c 45 43 46 4c 5b 23  D._TMP..3\ECFL[#
  3070: 4d 55 54 30 ff ff 70 5c 2f 05 5f 53 42 5f 50 43  MUT0..p\/._SB_PC
  3080: 49 30 50 49 42 5f 45 43 5f 5f 54 4d 50 31 60 5b  I0PIB_EC__TMP1`[
  3090: 27 4d 55 54 30 a4 4b 45 4c 56 60 a1 08 a4 4b 45  'MUT0.KELV`...KE
  30a0: 4c 56 0a 3c 14 13 4b 45 4c 56 01 77 68 0a 0a 60  LV.<..KELV.wh..`
  30b0: 72 60 0b ac 0a 60 a4 60 14 19 5f 53 43 50 01 70  r`...`.`.._SCP.p
  30c0: 68 54 53 43 50 86 5c 2e 5f 54 5a 5f 54 48 52 4d  hTSCP.\._TZ_THRM
  30d0: 0a 81 14 28 47 41 43 58 0a a0 19 93 5c 2f 03 5f  ...(GACX....\/._
  30e0: 53 42 5f 57 4d 49 44 53 54 44 5f 0a 01 a4 4b 45  SB_WMIDSTD_...KE
  30f0: 4c 56 68 a1 07 a4 4b 45 4c 56 69 14 32 49 54 4f  LVh...KELVi.2ITO
  3100: 53 01 70 0d 00 60 70 0a 04 61 a2 21 61 76 61 7b  S.p..`p..a.!ava{
  3110: 7a 68 79 61 0a 02 00 00 0a 0f 64 70 83 88 43 48  zhya......dp..CH
  3120: 41 52 64 00 62 73 60 62 65 70 65 60 a4 60 08 43  ARd.bs`bepe`.`.C
  3130: 48 41 52 12 32 10 0d 30 00 0d 31 00 0d 32 00 0d  HAR.2..0..1..2..
  3140: 33 00 0d 34 00 0d 35 00 0d 36 00 0d 37 00 0d 38  3..4..5..6..7..8
  3150: 00 0d 39 00 0d 41 00 0d 42 00 0d 43 00 0d 44 00  ..9..A..B..C..D.
  3160: 0d 45 00 0d 46 00 14 11 4d 49 4e 5f 02 a0 06 95  .E..F...MIN_....
  3170: 68 69 a4 68 a1 03 a4 69 14 09 53 4c 45 4e 01 a4  hi.h...i..SLEN..
  3180: 87 68 14 21 53 32 42 46 09 72 53 4c 45 4e 68 01  .h.!S2BF.rSLENh.
  3190: 60 08 42 55 46 46 11 02 60 70 68 42 55 46 46 a4  `.BUFF..`phBUFF.
  31a0: 42 55 46 46 14 47 06 53 43 4d 50 02 70 53 32 42  BUFF.G.SCMP.pS2B
  31b0: 46 68 60 70 53 32 42 46 69 61 70 00 64 70 53 4c  Fh`pS2BFiap.dpSL
  31c0: 45 4e 68 65 70 53 4c 45 4e 69 66 70 4d 49 4e 5f  ENhepSLENifpMIN_
  31d0: 65 66 67 a2 24 95 64 67 70 83 88 60 64 00 62 70  efg.$.dgp..`d.bp
  31e0: 83 88 61 64 00 63 a0 06 94 62 63 a4 01 a1 08 a0  ..ad.c...bc.....
  31f0: 06 95 62 63 a4 ff 75 64 a0 06 95 64 65 a4 01 a1  ..bc..ud...de...
  3200: 0c a0 06 95 64 66 a4 ff a1 03 a4 00              ....df......

FACS @ 0x0e7fffc0
  0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00  FACS-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

------=_20031127090919_67631
Content-Type: text/plain; name="output-dmesg.txt"
Content-Disposition: attachment; filename="output-dmesg.txt"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.0-test10-gentoo-r1 (root-CaYfgzKW20U@public.gmane.org) (gcc version 3.2.3 2=
0030422 (Gentoo Linux 1.4 3.2.3-r2, propolice)) #4 SMP Tue Nov 25 19:15:5=
5 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
 BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000e7f0000 (usable)
 BIOS-e820: 000000000e7f0000 - 000000000e7ff000 (ACPI data)
 BIOS-e820: 000000000e7ff000 - 000000000e800000 (ACPI NVS)
 BIOS-e820: 000000000e800000 - 000000000e900000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
231MB LOWMEM available.
On node 0 totalpages: 59376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 55280 pages, LIFO batch:13
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7860
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0e7fbd58
ACPI: FADT (v001 Compaq 00B5     0x06040000 PTL  0x01000000) @ 0x0e7fbd80
ACPI: DSDT (v001 COMPAQ 00B5     0x06040000 MSFT 0x0100000e) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=3D/dev/hda3 vga=3D791
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 995.740 MHz processor.
Console: colour VGA+ 80x25
Memory: 230992k/237504k available (2054k kernel code, 5796k reserved, 765=
k data, 172k init, 0k highmem)
Calibrating delay loop... 1888.25 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0080893f 0081813f 00000000 0000000=
0
CPU:     After vendor identify, caps: 0080893f 0081813f 000001ce 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.4.1.0, 1000 MHz
CPU: Code Morphing Software revision 4.4.0-10-156
CPU: 20030501 16:35 official release 62.0.1-4.4.0#1
CPU:     After all inits, caps: 0080893f 0081813f 000001ce 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Transmeta(tm) Crusoe(tm) Processor TM5800 stepping 03
per-CPU timeslice cutoff: 1463.33 usecs.
task migration cache decay timeout: 2 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Starting migration thread for cpu 0
CPUS done 8
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd80c, last bus=3D0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 7)
ACPI: PCI Interrupt Link [LNKD] (IRQs 15)
ACPI: Embedded Controller [EC] (gpe 1)
ACPI: Power Resource [LRP0] (off)
ACPI: Power Resource [LRP1] (off)
ACPI: Power Resource [LRP2] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f78f0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa377, dseg 0x400
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x8000-0x807f has been reserved
pnp: 00:0b: ioport range 0x8100-0x810f has been reserved
pnp: 00:0c: ioport range 0x3400-0x347f has been reserved
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 15
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even =
'acpi=3Doff'
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
PCI: Via IRQ fixup for 0000:00:07.5, from 255 to 10
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [CMB0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Fan [FAN2] (off)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (31 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x1040-0x1047, BIOS settings: hda:DMA, hdb:pio
hda: HITACHI_DK23EA-30, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=3D58140/16/63, UDMA=
(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:=
36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error =3D -16
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 172k freed
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:0c.0: OHCI Host Controller
ohci_hcd 0000:00:0c.0: irq 9, pci mem cf047000
ohci_hcd 0000:00:0c.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:00:0c.1: OHCI Host Controller
ohci_hcd 0000:00:0c.1: irq 11, pci mem cf049000
hub 1-0:1.0: new USB device on port 2, assigned address 2
ohci_hcd 0000:00:0c.1: new USB bus registered, assigned bus number 2
drivers/usb/core/usb.c: registered new driver hiddev
input: USB HID v1.10 Keyboard [Jing-Mold USB K/B+Mouse] on usb-0000:00:0c=
.0-2
input: USB HID v1.10 Mouse [Jing-Mold USB K/B+Mouse] on usb-0000:00:0c.0-=
2
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Loaded prism54 driver, version 1.0.2.2
PCI: Enabling device 0000:00:0a.0 (0010 -> 0012)
eth0: uploading firmware...
eth0: firmware uploaded done, now triggering reset...
eth0: islpci_open()
eth0: resetting device...
eth0: uploading firmware...
eth0: firmware uploaded done, now triggering reset...
eth0: prism54_mib_init()
eth0: done with prism54_mib_init()!
Real Time Clock Driver v1.12
TRAP: oid 0x1, device 2, flags 0x0 length 4
TRAP: oid 0x1, device 2, flags 0x0 length 4
TRAP: oid 0x1, device 2, flags 0x0 length 4
TRAP: oid 0x1, device 2, flags 0x0 length 4
TRAP: oid 0x1, device 2, flags 0x0 length 4
atkbd.c: Unknown key pressed (translated set 2, code 0x11e, data 0x3, on =
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x11e, data 0x83, o=
n isa0060/serio0).
hub 2-0:1.0: new USB device on port 1, assigned address 2
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor:           Model: USB DISK Pro      Rev: 3.07
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
SCSI device sda: 504832 512-byte hdwr sectors (258 MB)
sda: Write Protect is off
sda: Mode Sense: 00 46 00 00
sda: assuming drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
------=_20031127090919_67631
Content-Type: text/plain; name="output-dmidecode.txt"
Content-Disposition: attachment; filename="output-dmidecode.txt"
Content-Transfer-Encoding: quoted-printable

# dmidecode 2.3
SMBIOS 2.3 present.
20 structures occupying 771 bytes.
Table at 0x000E7010.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: Phoenix
		Version: 4.06CJ15  =20
		Release Date: 10/25/2002
		Address: 0xE8220
		Runtime Size: 97760 bytes
		ROM Size: 512 kB
		Characteristics:
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			Selectable boot is supported
			ACPI is supported
			USB legacy is supported
			LS-120 boot is supported
			ATAPI Zip drive boot is supported
			Smart battery is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: Compaq
		Product Name: Compaq Tablet PC TC1000         =20
		Version: 0F04
		Serial Number: 5Y2CLBSZC0C6
		UUID: 00200A88-5163-0010-B036-3AE66DE12236
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: Compaq
		Product Name: 0828
		Version: 19.xx
		Serial Number: 5Y2CLBSZC0C6
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: Compaq
		Type: Sub Notebook
		Lock: Not Present
		Version: N/A
		Serial Number: None
		Asset Tag: 5Y2CLBSZC0C6
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00001234
Handle 0x0004
	DMI type 4, 32 bytes.
	Processor Information
		Socket Designation: BGA-474
		Type: Central Processor
		Family: K6-3
		Manufacturer: GenuineTMx86
		ID: 43 05 00 00 3F 89 80 00
		Signature: Type 0, Family 5, Model 4, Stepping 3
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			CX8 (CMPXCHG8 instruction supported)
			SEP (Fast system call)
			CMOV (Conditional move instruction supported)
			MMX (MMX technology supported)
		Version: Transmeta(tm) Cru
		Voltage: 3.3 V
		External Clock: Unknown
		Max Speed: 1000 MHz
		Current Speed: 1000 MHz
		Status: Populated, Enabled
		Upgrade: ZIF Socket
		L1 Cache Handle: 0x0005
		L2 Cache Handle: 0x0006
		L3 Cache Handle: Not Provided
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 256 KB
		Maximum Size: 256 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 512 KB
		Maximum Size: 512 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Synchronous
		Installed SRAM Type: None
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x0007
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: Mini PCI Slot 1
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 0
		Characteristics:
			3.3 V is provided
			PME signal is supported
Handle 0x0008
	DMI type 10, 12 bytes.
	On Board Device Information
		Type: Video
		Status: Enabled
		Description: nVidia GeForce2 Go
	On Board Device Information
		Type: Sound
		Status: Enabled
		Description: AC97 AD Audio
	On Board Device Information
		Type: Ethernet
		Status: Enabled
		Description: Internal Ethernet
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: Ti 1520 Cardbus
Handle 0x0009
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: no Ownership Tag - limited to 40 chars =20
		String 2: 0123456789012345678901234567890123456789
Handle 0x000A
	DMI type 15, 29 bytes.
	System Event Log
		Area Length: 16 bytes
		Header Start Offset: 0x0000
		Header Length: 16 bytes
		Data Start Offset: 0x0010
		Access Method: General-purpose non-volatile data functions
		Access Address: 0x0000
		Status: Valid, Not Full
		Change Token: 0x00000059
		Header Format: Type 1
		Supported Log Type Descriptors: 3
		Descriptor 1: POST error
		Data Format 1: POST results bitmap
		Descriptor 2: Single-bit ECC memory error
		Data Format 2: Multiple-event
		Descriptor 3: Multi-bit ECC memory error
		Data Format 3: Multiple-event
Handle 0x000B
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 1 GB
		Error Information Handle: Not Provided
		Number Of Devices: 3
Handle 0x000C
	DMI type 17, 23 bytes.
	Memory Device
		Array Handle: 0x000B
		Error Information Handle: No Error
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: 1
		Locator: M1
		Bank Locator: Bank 0
		Type: DRAM
		Type Detail: Unknown
		Speed: Unknown
Handle 0x000D
	DMI type 17, 23 bytes.
	Memory Device
		Array Handle: 0x000B
		Error Information Handle: No Error
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: 1
		Locator: M2
		Bank Locator: Bank 1
		Type: DRAM
		Type Detail: Unknown
		Speed: Unknown
Handle 0x000E
	DMI type 17, 23 bytes.
	Memory Device
		Array Handle: 0x000B
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 232 MB
		Form Factor: DIMM
		Set: 1
		Locator: M3
		Bank Locator: CMS
		Type: DRAM
		Type Detail: Synchronous
		Speed: Unknown
Handle 0x000F
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000E7FFFFF
		Range Size: 232 MB
		Physical Array Handle: 0x000B
		Partition Width: 0
Handle 0x0010
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x000000003FF
		Range Size: 1 kB
		Physical Device Handle: 0x000C
		Memory Array Mapped Address Handle: 0x000F
		Partition Row Position: 1
Handle 0x0011
	DMI type 32, 20 bytes.
	System Boot Information
		Status: No errors detected
Handle 0x0012
	DMI type 126, 4 bytes.
	Inactive
Handle 0x0013
	DMI type 127, 4 bytes.
	End Of Table
------=_20031127090919_67631
Content-Type: text/plain; name="output-interrupts.txt"
Content-Disposition: attachment; filename="output-interrupts.txt"
Content-Transfer-Encoding: quoted-printable

           CPU0      =20
  0:    3099742          XT-PIC  timer
  1:         20          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
  9:       1471          XT-PIC  ohci_hcd
 10:          4          XT-PIC  acpi
 11:        332          XT-PIC  ohci_hcd
 14:      42513          XT-PIC  ide0
 15:         65          XT-PIC  eth0
NMI:          0=20
LOC:          0=20
ERR:          0
MIS:          0
------=_20031127090919_67631
Content-Type: text/plain; name="output-lspci.txt"
Content-Disposition: attachment; filename="output-lspci.txt"
Content-Transfer-Encoding: quoted-printable

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 03)
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e8100000 (32-bit, non-prefetchable) [size=3D1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-

00:05.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 Go] =
(rev b2) (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e9000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3c=
old-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] =
(rev 40)
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3c=
old-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT=
8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP Pri=
P])
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 9
	Region 4: I/O ports at 1040 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3c=
old-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (=
rev 40)
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 10
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3c=
old-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97=
 Audio Controller (rev 50)
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at 1400 [disabled] [size=3D256]
	Region 1: I/O ports at 1054 [disabled] [size=3D4]
	Region 2: I/O ports at 1050 [disabled] [size=3D4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3c=
old-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:08.0 Ethernet controller: Intel Corp. 82551QM Ethernet Controller (rev=
 10)
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8020000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at 1000 [size=3D64]
	Region 2: Memory at e8000000 (32-bit, non-prefetchable) [size=3D128K]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3c=
old-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

00:0a.0 Network controller: Harris Semiconductor D-Links DWL-g650 A1 (rev=
 01)
	Subsystem: Unknown device 17cf:0014
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 7000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: Memory at e8022000 (32-bit, non-prefetchable) [size=3D8K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0b.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Control=
ler (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D01, subordinate=3D04, sec-latency=3D176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

00:0b.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Control=
ler (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR+
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D05, subordinate=3D08, sec-latency=3D176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

00:0c.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR+
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8024000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0c.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR+
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at e8025000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHC=
I])
	Subsystem: Compaq Computer Corporation: Unknown device 00b5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR+
	Latency: 132 (4000ns min, 8500ns max), cache line size 08
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at e8021000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

------=_20031127090919_67631--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
