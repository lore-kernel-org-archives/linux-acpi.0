From: Goetz Bock <bock-zjrZfhH+lcMb1SvskN2V4Q@public.gmane.org>
Subject: ACPI 2.4.25/20040211 on Acer TravelMate C100
Date: Sun, 29 Feb 2004 15:05:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040229140517.GV5481@shell.blacknet.de>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uti2KpX7p8Fi@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dear list,

unfortunately with Linux 2.4.25 (even with the most up to date patches
to 20040211) ACPI stopped working on my Acer TravelMate C100.

It worked fine with 2.4.23 with 20031002, but now all i get is:

---=== cut here ===---
 BIOS-e820: ............... - ................ (ACPI data)
 BIOS-e820: ............... - ................ (ACPI NVS)
.
.
.
ACPI: have wakeup address 0xc9991999
.
.
.
ACPI: RSDP (v000 Acer                     ) @ 0x000ec2d0
  >>> ERROR: Invalid checksum
.
.
.
---=== cut here ===---

up to here it's equivalent to 2.4.23/20031002, but

---=== cut here ===---
.
.
.
ACPI: Subsystem revision 20040211
ACPI: Interpreter disabled.
.
.
.
PCI: ACPI table contains no PCI IRQ routing enteries
.
.
.
---=== cut here ===---

I've traced this to line 2037 of drivers/acpi/bus.c, in acpi_init (void)
but now I'm stuck.

I've tried the commandline parameters acpi=force (with debug) and have

   CONFIG_ACPI_DEBUG=y
   CONFIG_ACPI_RELAXED_AML=y

(and the rest of the ACPI stuff on either 'y' or 'm', actually except
this two options the same config as with 2.4.23)

Can anyone give me a pointer on how to procide?

BTW: Sorry, but I'm not on the list so please CC me.

Thanks,
    Goetz.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
