From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: ASUS M6800N: battery0 not present
Date: Tue, 17 Feb 2004 18:28:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40324F44.60006@pca.it>
Reply-To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080809020205070409080405"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Andre Messerschmidt <a.messerschmidt-hi6Y0CQ0nG0@public.gmane.org>, Markus Gaugusch <dsdt-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080809020205070409080405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I included a mail from the 'acpi4asus-user' mailing-list, as the problem
is already know and Andre Messerschmidt found a solution (at least to
see the battery IIRC).

- -------- Start Original Message --------
Subject: Re: [Acpi4asus-user] ASUS M6000N - Battery0 not present
Date: Thu, 5 Feb 2004 13:37:01 +0100
From: Andre Messerschmidt <a.messerschmidt-hi6Y0CQ0nG0@public.gmane.org>
To: acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
CC: Ben B. <ben.forum-cmBhpYW9OiY@public.gmane.org>
References: <40221902.6040606-cmBhpYW9OiY@public.gmane.org>

Am Donnerstag, 5. Februar 2004 11:20 schrieb Ben B.:
Hi.

> But I've a big problem to use my laptop without AC-adaptator.
> In fact, the battery0 (physically present) is not show in /proc (or
> elsewhere) just the battery1 (no physically present) is show with "no
> present" tag (it's right).
I had the same problem on my M6800N. After changing the DSDT table I now
have
BAT0 and BAT1 but both are always absent, no matter what I do.
You can download my DSDT table from here
http://www.isis.de/members/~messersch/asus-m6800n.html
Maybe it helps.

> Please can you tell me if it's a bug of ACPI or other think ?
I am not sure if this is a problem of the DSDT table or a bug in ACPI
itself.

best regards
Andre
- -------- End Original Message --------

As I wanted to use Andre's DSDT, I patched my 2.6.2 kernel with the
'ACPI DSDT in initrd' patch from http://gaugusch.at/kernel.shtml. The
latest patch available is against 2.6.1 and it applies with an hunk over
kernel 2.6.2 + ACPI 20040211 (no matter if I patch with the latest ACPI
before or after the 'ACPI DSDT in initrd' patch):
> gismo:/usr/src/linux-2.6.2# patch -p1 <
../kernel/v2.6/03_acpi-dsdt-initrd-patch-v0.4-2.6.1.diff
> patching file drivers/acpi/Kconfig
> patching file drivers/acpi/osl.c
> patching file drivers/acpi/tables/tbget.c
> Hunk #2 succeeded at 287 (offset -1 lines).
> patching file include/linux/initrd.h
> patching file init/initramfs.c

Then, I compiled Andre's DSDT with the latest 'iasl' from Intel:
> gismo:/usr/src/kernel/dsdt/iasl-linux-20030918# ./iasl
messerschmidt_asus_m6800n_dsdt_test.dsl
>
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18 2003]
> Copyright (C) 2000 - 2003 Intel Corporation
> Supports ACPI Specification Revision 2.0b
>
> messerschmidt_asus_m6800n_dsdt_test.dsl  3180:                 Scope
(\_SB.PCI0)Warning  2031 -
Internal compiler error ^  (Not using optimized name - did not find node)
>
> ASL Input:  messerschmidt_asus_m6800n_dsdt_test.dsl - 5580 lines,
181689 bytes, 2576 keywords
> AML Output: DSDT.aml - 22419 bytes 772 named objects 1804 executable
opcodes
>
> Compilation complete. 0 Errors, 1 Warnings, 0 Remarks, 740 Optimizations
> gismo:/usr/src/kernel/dsdt/iasl-linux-20030918#

I compiled kernel 2.6.2 with the 'ACPI DSDT in initrd' patch and I
prepared my LiLo tu use it: as I don't use any initrd, I copied Andre's
compiled DSDT in /boot/ and I added these lines to /etc/lilo.conf:
> 	image=/boot/vmlinuz-2.6.2-acpi-dsdt-initrd
> 	        label=262-dsdt
> 	        read-only
> 	        initrd=/boot/dsdt-m6842nwh_20040216.01.aml

At reboot, anyway, I can't see any line 'Looking for DSDT in intird',
but, strange, if now I grab my DSDT, this is Andre's one, not mine (as
if the DSDT was read from initrd). On the contrary, battery0 is still no
present (I attached my kern.log_20040217).

On the other hand, as from the syslog_20040216 I attached, during
various tests I made yesterday, just one time I could see the famous
'Looking for DSDT in initrd' in 'syslog', so IMHO now every boot the
kernel takes my customized DSDT. In fact, the latest kern.log_20040217
lacks some line which are present in syslog_20040216:
> Feb 16 16:42:40 localhost kernel: Linux version 2.6.2-acpi-dsdt-initrd
(root-HSB4nKSusd8@public.gmane.org) (gcc version 3.3.3 20040214 (prerelease) (Debian)) #1 Mon
Feb 16 16:36:47 CET 2004
> Feb 16 16:42:40 localhost kernel: BIOS-provided physical RAM map:
> Feb 16 16:42:40 localhost kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
> Feb 16 16:42:40 localhost kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
> Feb 16 16:42:40 localhost kernel:  BIOS-e820: 00000000000e0000 -
0000000000100000 (reserved)
> Feb 16 16:42:40 localhost kernel:  BIOS-e820: 0000000000100000 -
000000001ff40000 (usable)
> Feb 16 16:42:40 localhost kernel:  BIOS-e820: 000000001ff40000 -
000000001ff50000 (ACPI data)
> Feb 16 16:42:40 localhost kernel:  BIOS-e820: 000000001ff50000 -
0000000020000000 (ACPI NVS)
> Feb 16 16:42:40 localhost kernel: 511MB LOWMEM available.
> Feb 16 16:42:40 localhost kernel: On node 0 totalpages: 130880
> Feb 16 16:42:40 localhost kernel:   DMA zone: 4096 pages, LIFO batch:1
> Feb 16 16:42:40 localhost kernel:   Normal zone: 126784 pages, LIFO
batch:16
> Feb 16 16:42:40 localhost kernel:   HighMem zone: 0 pages, LIFO batch:1
> Feb 16 16:42:40 localhost kernel: DMI 2.3 present.
> Feb 16 16:42:40 localhost kernel: ACPI: RSDP (v000 ACPIAM
                       ) @ 0x000f5db0
> Feb 16 16:42:40 localhost kernel: ACPI: RSDT (v001 A M I  OEMRSDT
0x02000406 MSFT 0x00000097) @ 0x1ff40000
> Feb 16 16:42:40 localhost kernel: ACPI: FADT (v001 A M I  OEMFACP
0x02000406 MSFT 0x00000097) @ 0x1ff40200
> Feb 16 16:42:40 localhost kernel: ACPI: OEMB (v001 A M I  OEMBIOS
0x02000406 MSFT 0x00000097) @ 0x1ff50040
> Feb 16 16:42:40 localhost kernel: ACPI: DSDT (v001  1ABSP 1ABSP001
0x00000001 MSFT 0x0100000d) @ 0x00000000
> Feb 16 16:42:40 localhost kernel: Building zonelist for node : 0
> Feb 16 16:42:40 localhost kernel: Kernel command line:
BOOT_IMAGE=262-dsdt ro root=303
> Feb 16 16:42:40 localhost kernel: Found and enabled local APIC!
> Feb 16 16:42:40 localhost kernel: Initializing CPU#0
> Feb 16 16:42:40 localhost kernel: PID hash table entries: 2048 (order
11: 16384 bytes)
> Feb 16 16:42:40 localhost kernel: Detected 1601.014 MHz processor.
> Feb 16 16:42:40 localhost kernel: Using tsc for high-res timesource
> Feb 16 16:42:40 localhost kernel: Console: colour dummy device 80x25
> Feb 16 16:42:40 localhost kernel: Memory: 513580k/523520k available
(2461k kernel code, 9184k reserved, 1061k data, 164k init, 0k highmem)
> Feb 16 16:42:40 localhost kernel: Checking if this processor honours
the WP bit even in supervisor mode... Ok.
> Feb 16 16:42:40 localhost kernel: Calibrating delay loop... 3162.11
BogoMIPS
> Feb 16 16:42:40 localhost kernel: Dentry cache hash table entries:
65536 (order: 6, 262144 bytes)
> Feb 16 16:42:40 localhost kernel: Inode-cache hash table entries:
32768 (order: 5, 131072 bytes)
> Feb 16 16:42:40 localhost kernel: Mount-cache hash table entries: 512
(order: 0, 4096 bytes)
> Feb 16 16:42:40 localhost kernel: checking if image is initramfs...it
isn't (ungzip failed); looks like an initrd
> Feb 16 16:42:40 localhost kernel: ACPI: Looking for DSDT in initrd ...
found customized DSDT with 22420 bytes!
> Feb 16 16:42:40 localhost kernel: Freeing initrd memory: 21k freed
> Feb 16 16:42:40 localhost kernel: CPU:     After generic identify,
caps: a7e9fbbf 00000000 00000000 00000000
> Feb 16 16:42:40 localhost kernel: CPU:     After vendor identify,
caps: a7e9fbbf 00000000 00000000 00000000
> Feb 16 16:42:40 localhost kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
> Feb 16 16:42:40 localhost kernel: CPU: L2 cache: 1024K
> Feb 16 16:42:40 localhost kernel: CPU:     After all inits, caps:
a7e9fbbf 00000000 00000000 00000040
> Feb 16 16:42:40 localhost kernel: Intel machine check architecture
supported.
> Feb 16 16:42:40 localhost kernel: Intel machine check reporting
enabled on CPU#0.
> Feb 16 16:42:40 localhost kernel: CPU: Intel(R) Pentium(R) M processor
1600MHz stepping 05
> Feb 16 16:42:40 localhost kernel: Enabling fast FPU save and
restore... done.
> Feb 16 16:42:40 localhost kernel: Enabling unmasked SIMD FPU exception
support... done.
> Feb 16 16:42:40 localhost kernel: Checking 'hlt' instruction... OK.
> Feb 16 16:42:40 localhost kernel: POSIX conformance testing by UNIFIX
> Feb 16 16:42:40 localhost kernel: enabled ExtINT on CPU#0
> Feb 16 16:42:40 localhost kernel: ESR value before enabling vector:
00000000
> Feb 16 16:42:40 localhost kernel: ESR value after enabling vector:
00000000
> Feb 16 16:42:40 localhost kernel: Using local APIC timer interrupts.
> Feb 16 16:42:40 localhost kernel: calibrating APIC timer ...
> Feb 16 16:42:40 localhost kernel: ..... CPU clock speed is 1599.0846 MHz.
> Feb 16 16:42:40 localhost kernel: ..... host bus clock speed is
99.0990 MHz.
> Feb 16 16:42:40 localhost kernel: NET: Registered protocol family 16
> Feb 16 16:42:40 localhost kernel: PCI: PCI BIOS revision 2.10 entry at
0xf0031, last bus=2
> Feb 16 16:42:40 localhost kernel: PCI: Using configuration type 1
> Feb 16 16:42:40 localhost kernel: mtrr: v2.0 (20020519)
> Feb 16 16:42:40 localhost kernel: ACPI: Subsystem revision 20040211
> Feb 16 16:42:40 localhost kernel: ACPI: Using customized DSDT
> Feb 16 16:42:40 localhost kernel:    tbget-0299: *** Info: Table
[DSDT] replaced by host OS
> Feb 16 16:42:40 localhost kernel:  tbxface-0117 [03] acpi_load_tables
     : ACPI Tables successfully acquired
> Feb 16 16:42:40 localhost kernel: Parsing all Control
Methods:.............................................................................................................................................................................................................................................................................
> Feb 16 16:42:40 localhost kernel: Table [DSDT](id F004) - 967 Objects
with 58 Devices 269 Methods 29 Regions
> Feb 16 16:42:40 localhost kernel: ACPI Namespace successfully loaded
at root c04bf1dc
> Feb 16 16:42:40 localhost kernel: ACPI: IRQ9 SCI: Level Trigger.
> Feb 16 16:42:40 localhost kernel: evxfevnt-0093 [04] acpi_enable
     : Transition to ACPI mode successful
> Feb 16 16:42:40 localhost kernel: evgpeblk-0747 [06]
ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 0000000000000428
on int 9
> Feb 16 16:42:40 localhost kernel: Completing
Region/Field/Buffer/Package
initialization:.................................................................................................................................
> Feb 16 16:42:40 localhost kernel: Initialized 28/29 Regions 34/35
Fields 39/39 Buffers 28/28 Packages (975 nodes)
> Feb 16 16:42:40 localhost kernel: Executing all Device _STA and_INI
methods:..............................................  psargs-0352: ***
Error: Looking up [ECFL] in namespace, AE_NOT_FOUND
> Feb 16 16:42:40 localhost kernel: search_node c155a528 start_node
c155a528 return_node 00000000
> Feb 16 16:42:40 localhost kernel:  psparse-1120: *** Error: Method
execution failed [\_SB_.ECAV] (Node c155a528), AE_NOT_FOUND
> Feb 16 16:42:40 localhost kernel:  psparse-1120: *** Error: Method
execution failed [\_SB_.ACS_] (Node c155a4a8), AE_NOT_FOUND
> Feb 16 16:42:40 localhost kernel:  psparse-1120: *** Error: Method
execution failed [\_SB_.AC__._INI] (Node c1559728), AE_NOT_FOUND
> Feb 16 16:42:40 localhost kernel: .  psargs-0352: *** Error: Looking
up [ECFL] in namespace, AE_NOT_FOUND
> Feb 16 16:42:40 localhost kernel: search_node c155a528 start_node
c155a528 return_node 00000000
> Feb 16 16:42:40 localhost kernel:  psparse-1120: *** Error: Method
execution failed [\_SB_.ECAV] (Node c155a528), AE_NOT_FOUND
> Feb 16 16:42:40 localhost kernel:  psparse-1120: *** Error: Method
execution failed [\_SB_.BATS] (Node c155a428), AE_NOT_FOUND
> Feb 16 16:42:40 localhost kernel:  psparse-1120: *** Error: Method
execution failed [\_SB_.BAT0._STA] (Node c1558e28), AE_NOT_FOUND
> Feb 16 16:42:40 localhost kernel: .............
> Feb 16 16:42:40 localhost kernel: 60 Devices found containing: 60
_STA, 3 _INI methods

Now, the real problem is in these lines:
> Feb 16 16:42:40 localhost kernel: ACPI: Looking for DSDT in initrd ...
found customized DSDT with 22420 bytes!
<cut>
> Feb 16 16:42:40 localhost kernel: ACPI: Subsystem revision 20040211
> Feb 16 16:42:40 localhost kernel: ACPI: Using customized DSDT
> Feb 16 16:42:40 localhost kernel:    tbget-0299: *** Info: Table
[DSDT] replaced by host OS
> Feb 16 16:42:40 localhost kernel:  tbxface-0117 [03] acpi_load_tables
     : ACPI Tables successfully acquired

/et-voilà/: the kernel reads my customized DSDT, but after it doesn't
used it (the 'replaced by host OS' message), so I've the corrected DSDT
in /proc/acpi/dsdt, but not used. Am I right? In fact, I get all the
errors I've with the original DSDT (which I'd like to correct, but after
having booted with the new DSDT).

Any ideas?

Thx, bye,
Gismo / Luca

PS to Andre Messerschmidt: I don't know if you're subscribed to
'acpi-devel', so I cc you.

PPS to Markus Gaugusch: I think your patch (version for 2.6.1 vanilla)
is applicable even on 2.6.2, while there's just an hunk.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAMk9DVAp7Xm10JmkRAqP0AKCMGpV3Rn0/DjaSIdg/IHRJ+SO1PwCgiCqZ
rSdPF7HnT0mZ7pRQULsUym0=
=ItC9
-----END PGP SIGNATURE-----

--------------080809020205070409080405
Content-Type: application/x-gzip;
 name="syslog-2.6.2-acpi-dsdt-initrd.20040216.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="syslog-2.6.2-acpi-dsdt-initrd.20040216.gz"

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
i5cYxeMl/wDoQwfRXXMAAA==
--------------080809020205070409080405
Content-Type: application/x-gzip;
 name="kern.log-2.6.2-acpi-dsdt-initrd.20040217.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="kern.log-2.6.2-acpi-dsdt-initrd.20040217.gz"

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
--------------080809020205070409080405--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
