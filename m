From: Jacek Kawa <jfk-am85oNWwv3KkuDHyt5Lh4DtUAC2U4X/S@public.gmane.org>
Subject: 2.6/2.4, ACPI, Compaq Armada 110, freeze while booting
Date: Sun, 18 Apr 2004 03:00:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040418005959.GA15475@finwe.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

(I'm not subscribed to acpi-devel@ so CC me)

I've got problem with making Linux with ACPI enabled 
work with Compaq Armada 110. 

o 2.6.6-rc1 log (written down):
-------------------------------
ACPI: Subsystem revision 20040326
 tbxface-0117 [03] acpi_load_tables	: ACPI Tables successfully acquired
 Parsing all Control Methods:.................................................... ...
 Table [DSDT](id F004) - 398 Objects with 38 Devices 122 Methods 13 Regions
 ACPI Namespace successfully loaded at root c03851bc
 ACPI: IRQ10 SCI: Edge set to Level Trigger.
 evxfevnt-0093 [04] acpi_enable		: Transition to ACPI mode successful
 evgpeblk-0867 [06] ev_create_gpe_block	: GPE 00 to 15 [_GPE] 2 regs at 0000000000008020 on int 10
 evgpeblk-0925 [06] ev_create_gpe_block	: Found 0 Wake, Enabled 5 Runtime GPEs in this block
 Completing Region/Field/Buffer/Package initialization:................................ ...
 Initialized 13/13 Regions 1/1 Fields 22/22 Buffers 19/19 Packages (407 nodes)
 Executing all Device _STA and_INI methods: ..........[ACPI Debug] String: Length 0x30, "--------- VIA SOFTWARE SMI PMIO 2Fh ------------"
 
And then OS freezes. pci=noacpi or/and noacpi are not enough and only 
acpi=off 'solves' problem.

o tested versions
-----------------
I tested 2.6.6-rc1, 2.6.5-mm6, 2.6.4, 2.6.1 and symptoms are similar 
(when debug is disabled last visible line is 'ACPI: IRQ10 SCI: Edge set 
to Level Trigger') With 2.4.24 and 2.4.25 and ACPI enabled I got blank 
screen instead of text, but I guess it's the same problem (without ACPI
2.4.2[45] boot fine).

Custom DSDT does not help. I patched osl.c and according to logs new table
(found here: http://acpi.sourceforge.net/dsdt/view.php?id=77) was loaded 
correctly, but system froze after 'Executing all Device _STA and_INI methods' 
as before.

o references
------------
I found one similar description of problem, with Compaq Presario 2158 EA,
but no solution 
(http://linux.derkeiler.com/Newsgroups/comp.os.linux.portable/2003-09/0017.html).

It's bit strange to me, and maybe I should test some older ACPI versions,
as there are many pages with information, that ACPI with modified DSDT is 
almost fully functional... 

o system details
----------------

2.6.6-rc1 config: 
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/config-2.6.6-rc1
2.4.25 config:
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/config-2.4.25

acpidmp output:
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/acpidmp

cpuinfo:
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/cpuinfo
lspci:
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/lspci
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/lspci-v
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/lspci-v-v
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/lspci-v-v-v
/proc/dma:
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/dma
/proc/interrupts:
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/interrupts

(all collected with acpi=off)

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.35
jfsutils               1.1.4
xfsprogs               2.6.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91

Suggestions are welcome.

bye!

-- 
Jacek Kawa


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
