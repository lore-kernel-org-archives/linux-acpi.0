From: Jarkko Haapalainen <jarkko.haapalainen-X3B1VOXEql0@public.gmane.org>
Subject: Shutdown problems and DSDT with LG LS70 Express laptop
Date: Sat, 01 Oct 2005 18:18:38 +0300
Message-ID: <200510011818.39189.jarkko.haapalainen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Resent-message-id: <200510022342.00760.jarkko.haapalainen-X3B1VOXEql0@public.gmane.org>
Content-disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

I have problem on shutting down (poweroff) my laptop. I have tried to disable 
APIC and tried many other things with no success.

Weird is that it sometimes works and never if I use Open Sound System (OSS) 
sound drivers. Loading OSS with soundon (I have to run 
soundon;soundoff;soundon to get sound) is no problem, my laptop will shutdown 
after this but doesn't if I listen music after loading drivers. Very weird.

And I noticed that my laptop will not shutdon also if I don't 
run /etc/init.d/coldplug (using gentoo which "probes" the hardware). List of 
modules which it loads, see [Ref 1][LSMOD]

So I started to investigate this and contacted also OSS guys and they think 
this is BIOS issue. Reading from internet about DSDT and thinking if fixing 
DSDT will help me I started to research this. See errors and warnings when 
disassembling dsdt with iasl [Ref 2][IASL] . I tried to fix DSDT doing this, 
see for diff [Ref 3][IASL]. But only got these errors to dmesg:

PCI: Probing PCI hardware (bus 00)
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0._CRS] (Node 
df6677c0), AE_AML_B
UFFER_LIMIT
    ACPI-0156: *** Error: Method execution failed [\_SB_.PCI0._CRS] (Node 
df6677c0), AE_AML_B
UFFER_LIMIT

No change for shutdown issue. And also I have to use p4-clockmod driver for 
cpu frequency scaling, no speedstepping in Pentium Celeron M ?! Don't know 
about that.

Laptop is fairly new and it has Intel 915GM chipset. My kernel is 
2.6.13-archck6.2 and latest ACPI (20050902). Also I have tried many different 
kernels and configurations with no success.

Can anyone help me with this? 

I have struggled with this problem about month now. Any help is appreciated.

Best regards,
 Jarkko Haapalainen




[Ref 1][LSMOD]
$ lsmod
Module                  Size  Used by
michael_mic             2304  2
arc4                    1600  2
ieee80211_crypt_tkip     9408  2
psmouse                32580  0
irtty_sir               5696  0
sir_dev                13804  1 irtty_sir
irda                  117368  1 sir_dev
crc_ccitt               1728  1 irda
parport_pc             25028  0
parport                32456  1 parport_pc
8250_pnp                8256  0
8250                   22116  1 8250_pnp
serial_core            19968  1 8250
eth1394                17224  0
ipw2200               172744  0
ieee80211              47108  1 ipw2200
ieee80211_crypt         4868  2 ieee80211_crypt_tkip,ieee80211
firmware_class          7808  1 ipw2200
ohci1394               32244  0
ieee1394               89656  2 eth1394,ohci1394
yenta_socket           22668  0
rsrc_nonstatic         10304  1 yenta_socket
pcmcia_core            36048  2 yenta_socket,rsrc_nonstatic
i2c_i801                7628  0
i2c_core               17360  1 i2c_i801
ehci_hcd               30216  0
usbhid                 26624  0
uhci_hcd               31184  0
intel_agp              20508  1
agpgart                29448  2 intel_agp
usbcore               108540  4 ehci_hcd,usbhid,uhci_hcd
reiser4               451944  2
zlib_deflate           22616  1 reiser4
zlib_inflate           17536  1 reiser4



[Ref 2][IASL]
# ./iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20050902 [Sep 30 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dsdt.dsl   851:                 If (LEqual (And (PDC0, 0x0A), 0x0A))
Error    1061 -               Object does not exist ^  (PDC0)

dsdt.dsl   856:                 If (LEqual (And (PDC1, 0x0A), 0x0A))
Error    1065 -                                     ^ Object not accessible 
from this scope (PDC1)

dsdt.dsl  1097:                         If (LNot (LEqual (And (PDC1, 0x0A), 
0x0A)))
Error    1065 -             Object not accessible from this scope ^  (PDC1)

dsdt.dsl  1390:             Name (_WDG, Buffer (0x28)
Warning  2097 -                      ^ Unknown reserved name (_WDG)

dsdt.dsl  1440:             Method (_WED, 1, NotSerialized)
Warning  2097 -  Unknown reserved name ^  (_WED)

dsdt.dsl  1461:             Name (_WDG, Buffer (0xC8)
Warning  2097 -                      ^ Unknown reserved name (_WDG)

dsdt.dsl  2373:             Method (WMAB, 3, NotSerialized)
Warning  2085 -                        ^ Not all control paths return a value 
(WMAB)

dsdt.dsl  2441:             Method (_WED, 1, NotSerialized)
Warning  2097 -  Unknown reserved name ^  (_WED)

dsdt.dsl  2844:             Name (_WDG, Buffer (0x3C)
Warning  2097 -                      ^ Unknown reserved name (_WDG)

ASL Input:  dsdt.dsl - 8129 lines, 279514 bytes, 3640 keywords
Compilation complete. 3 Errors, 6 Warnings, 0 Remarks, 7 Optimizations



[Ref 3][IASL]
--- dsdt.dsl    2005-10-01 12:53:34.485646248 +0300
+++ fixed/LGLS70-DSDT-ORIG.dsl  2005-10-01 09:10:48.000000000 +0300
@@ -2,7 +2,7 @@
  * Intel ACPI Component Architecture
  * AML Disassembler version 20050902
  *
- * Disassembly of dsdt.dat, Sat Oct  1 12:53:34 2005
+ * Disassembly of LGLS70-DSDT-ORIG.dat, Sat Oct  1 09:03:06 2005
  */
 DefinitionBlock ("DSDT.aml", "DSDT", 1, "LGE   ", "HUNTER  ", 100925440)
 {
@@ -848,12 +848,12 @@
             Notify (\_SB.AC, 0x80)
             If (HTTE)
             {
-                If (LEqual (And (PDC0, 0x0A), 0x0A))
+                If (LEqual (And (\_SB.PCI0.RP01.PDC0, 0x0A), 0x0A))
                 {
                     Notify (\_PR.CPU0, 0x80)
                 }

-                If (LEqual (And (PDC1, 0x0A), 0x0A))
+                If (LEqual (And (\_SB.PCI0.RP01.PDC1, 0x0A), 0x0A))
                 {
                     Notify (\_PR.CPU1, 0x80)
                 }
@@ -1094,7 +1094,7 @@
                     Release (MTHM)
                     If (LAnd (LAnd (LEqual (OSYS, 0x07D1), GPIC), LAnd (HTTE, 
PSVT)))
                     {
-                        If (LNot (LEqual (And (PDC1, 0x0A), 0x0A)))
+                        If (LNot (LEqual (And (\_SB.PCI0.RP01.PDC1, 0x0A), 
0x0A)))
                         {
                             If (LGreater (Local0, PSVT))
                             {
@@ -4077,7 +4077,7 @@
                 {
                     Offset (0x1A),
                     ABP1,   1,
-                        ,   2,
+                    PDC0,   2,
                     PDC1,   1,
                         ,   2,
                     PDS1,   1,


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
