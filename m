From: "Edmund Rhudy" <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>
Subject: Changing temperature trip points
Date: Sat, 2 Nov 2002 00:35:56 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000001c28231$b7cae110$c200a8c0@pikachu>
References: <E187ipj-0001ss-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E187ipj-0001ss-00-HKCwXBn57GynvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org>
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

On my laptop, a Gateway Solo 1400 with one of those super-integrated VIA
Apollo Pro133A chipsets that has basically every system function
integrated into it (video, sound, modem, networking, and so forth), I
note that the temperature trip points are excruciatingly high; so high,
in fact, that the processor (a Celeron 900) would be close to thermal
death by the time the fan would purportedly turn itself on.

cat /proc/acpi/thermal_zone/TZN0/trip_points returns the following
output:

critical (S5):		105 C
passive:			90 C: tc1=4 tc2=3 tsp=100
devices=0xc129f620
active[0]:			65 C: devices=0xc12a9fe0

As it stands, I can currently turn the fan on manually with echo on >
/proc/acpi/fan/FAN0/state (though not turn it off with echo off, for
whatever reason), but I can't be constantly monitoring the temperature,
and I'd like the fan to just turn itself on and off only when necessary,
as it's rather loud.

This is with the latest version of ACPI (20021101) on 2.4.20-rc1 under
Red Hat 8.0.  If you require any further information, let me know and
I'll dig it out for you.  For the record, here's everything that dmesg
returned with regard to ACPI (any lines I skipped are indicated with
ellipses):

ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 61424
zone(0): 4096 pages.
zone(1): 57328 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 OID_00                     ) @ 0x000e5010
ACPI: RSDT (v001 GATEWA SOLO1400 08193.04647) @ 0x0efffbc0
ACPI: FADT (v001 GATEWA SOLO1400 08193.04647) @ 0x0efffac0
ACPI: BOOT (v001 GATEWA SOLO1400 08193.04647) @ 0x0efffb50
ACPI: DBGP (v001 GATEWA SOLO1400 08193.04647) @ 0x0efffb80
ACPI: DSDT (v001 GATEWA SOLO1400 08193.04647) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Subsystem revision 20021101
PCI: PCI BIOS revision 2.10 entry at 0xe8a24, last bus=1
PCI: Using configuration type 1
    ACPI-0508: *** Info: GPE Block0 defined as GPE0 to GPE15
    ACPI-0508: *** Info: GPE Block1 defined as GPE16 to GPE31
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *7 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 10 *11)
ACPI: Power Resource [PFAN] (off)
...
ACPI: AC Adapter [ADP0] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [TZN0] (39 C)

If you need anything else, let me know and I'll do my best to provide
it.  I apologise in advance for the length of this post and any
irrelevant information I may have included.




-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
