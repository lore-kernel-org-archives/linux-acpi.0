From: Sanjiv Sinha <sanjiv.sinha-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ACPI 1133 Error: Method Execution Failed on T42
Date: Thu, 12 Aug 2004 09:55:10 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <fc5533cb0408120955cc93f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

This is the one line summary of the problem.

On a Thinkpad T42 running kernel 2.6.7 with the acpi-20040715 patch
and a custom DSDT, 'echo -n "standby/mem" > /sys/power/state' starts
to standby and then aborts with 'ACPI-1133: *** Error: Method
execution failed' and similar statements.

More Details.

1. I made a few minor corrections to the original DSDT such that there
are no errors or warnings on compiling with iasl. I can send this
later if required.

2. I see lots of "Method Execution Failed" in the boot messages as
well. This is also given below.
 
3. AFAIK, most of the /proc/acpi entries are OK e.g. adapter, battery
are correct. No entries under fan and thermal_zone though.
/proc/acpi/embedded_controller/EC/info shows....
gpe bit:                 0x1c
ports:                   0x66, 0x62
use global lock:         no


4. Possibly unrelated but these are some of the other things I am
running: Swsusp2 + bootsplash + speedstep-centrino. In my kernel
config, APIC and REGPARM are off. ACPI is compiled into the kernel (no
modules) and APM is not.

On searching, I found that all this may be related to a buggy ECDT.
But most of the pages on this are old and refer to kernel 2.4. Also, I
would like to first find whether it is broken before trying to mend it
:)  Any help more than welcome. Thanks.

Sanjiv.
----------------------
Attached logs:

================================================
1. Syslog on doing ' echo -n "mem" > /sys/power/state" 
================================================
Aug 12 09:05:38 localhost kernel: PM: Preparing system for suspend
Aug 12 09:05:43 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\SMI_] (Node ef8e77c8), AE_AML_REGION_LIMIT
Aug 12 09:05:43 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\VVPD] (Node ef8e7608), AE_AML_REGION_LIMIT
Aug 12 09:05:43 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_PTS] (Node efbb8648), AE_AML_REGION_LIMIT
Aug 12 09:05:43 localhost kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Aug 12 09:05:43 localhost kernel: Could not suspend device
0000:00:1d.7: error -5
Aug 12 09:05:43 localhost kernel: PCI: Enabling device 0000:00:1f.5
(0000 -> 0003)
Aug 12 09:05:43 localhost kernel: i810_audio: Primary codec has ID 0
Aug 12 09:05:43 localhost kernel: ac97_codec: AC97 Audio codec, id:
ADS116 (Unknown)
Aug 12 09:05:43 localhost kernel: PCI: Setting latency timer of device
0000:00:1f.6 to 64
Aug 12 09:05:43 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_WAK] (Node efbb8608), AE_AML_REGION_LIMIT
Aug 12 09:05:43 localhost kernel:     ACPI-0553: *** Error: Method
_WAK failed, AE_AML_REGION_LIMIT
Aug 12 09:05:45 localhost kernel: e1000: eth0: e1000_watchdog: NIC
Link is Up 100 Mbps Full Duplex

===================================================
2. Boot messages (ACPI relevant portions only)
===================================================

Aug 12 08:56:10 localhost syslogd 1.4.1#15: restart.
Aug 12 08:56:10 localhost kernel: klogd 1.4.1#15, log source =
/proc/kmsg started.
Aug 12 08:56:10 localhost kernel: Inspecting /boot/System.map-2.6.7-sinha-v4
Aug 12 08:56:11 localhost kernel: Loaded 30603 symbols from
/boot/System.map-2.6.7-sinha-v4.
Aug 12 08:56:11 localhost kernel: Symbols match kernel version 2.6.7.
Aug 12 08:56:11 localhost kernel: No module symbols loaded - kernel
modules not enabled.
Aug 12 08:56:11 localhost kernel: ng 'hlt' instruction... OK.
Aug 12 08:56:11 localhost kernel: checking if image is initramfs...it
isn't (ungzip failed); looks like an initrd
Aug 12 08:56:11 localhost kernel: Freeing initrd memory: 3685k freed
Aug 12 08:56:11 localhost kernel: NET: Registered protocol family 16
Aug 12 08:56:11 localhost kernel: EISA bus registered
Aug 12 08:56:11 localhost kernel: PCI: PCI BIOS revision 2.10 entry at
0xfd8d6, last bus=8
Aug 12 08:56:11 localhost kernel: PCI: Using configuration type 1
Aug 12 08:56:11 localhost kernel: mtrr: v2.0 (20020519)
Aug 12 08:56:11 localhost kernel: ACPI: Subsystem revision 20040715
Aug 12 08:56:11 localhost kernel:     ACPI-0291: *** Info: Table
[DSDT] replaced by host OS
Aug 12 08:56:11 localhost kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Aug 12 08:56:11 localhost kernel: ACPI: Found ECDT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_PR_.CPU_._INI] (Node eff5e628),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_._INI] (Node efb863e8), AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.FDC_._STA] (Node efbbf188),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-0158: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.FDC_._STA] (Node efbbf188),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.LPT_._STA] (Node efbbfd08),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-0158: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.LPT_._STA] (Node efbbfd08),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.ECP_._STA] (Node efbbfb68),
AE_AML_NO_RETURN_VALUE
Aug 12 08:56:11 localhost kernel:     ACPI-0158: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.ECP_._STA] (Node efbbfb68),
AE_AML_NO_RETURN_VALUE
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\SMI_] (Node ef8e77c8), AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\BLTH] (Node ef8e7488), AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.EC__.HKEY.BTIN] (Node efbb9948),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.EC__._INI] (Node efbbe9a8),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\SMI_] (Node ef8e77c8), AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\VUPS] (Node ef8e7668), AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.AGP_.VID_._INI] (Node efbbc3a8),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel: ACPI: Interpreter enabled
Aug 12 08:56:11 localhost kernel: ACPI: Using PIC for interrupt routing
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKA]
(IRQs 3 4 5 6 7 9 10 *11)
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKB]
(IRQs 3 4 5 6 7 9 10 *11)
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKC]
(IRQs 3 4 5 6 7 9 10 *11)
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKD]
(IRQs 3 4 5 6 7 9 10 *11)
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKE]
(IRQs 3 4 5 6 7 9 10 11) *0, disabled.
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKF]
(IRQs 3 4 5 6 7 9 10 11) *0, disabled.
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKG]
(IRQs 3 4 5 6 7 9 10 11) *0, disabled.
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKH]
(IRQs 3 4 5 6 7 9 10 *11)
Aug 12 08:56:11 localhost kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 12 08:56:11 localhost kernel: PCI: Probing PCI hardware (bus 00)
Aug 12 08:56:11 localhost kernel: PCI: Ignoring BAR0-3 of IDE
controller 0000:00:1f.1
Aug 12 08:56:11 localhost kernel: PCI: Transparent bridge - 0000:00:1e.0
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.FDC_._STA] (Node efbbf188),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.LPT_._STA] (Node efbbfd08),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.ECP_._STA] (Node efbbfb68),
AE_AML_NO_RETURN_VALUE
Aug 12 08:56:11 localhost kernel: ACPI: Embedded Controller [EC] (gpe 28)
Aug 12 08:56:11 localhost kernel: ACPI: Power Resource [PUBS] (on)
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKA]
enabled at IRQ 11
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKD]
enabled at IRQ 11
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKC]
enabled at IRQ 11
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKH]
enabled at IRQ 11
Aug 12 08:56:11 localhost kernel: ACPI: PCI Interrupt Link [LNKB]
enabled at IRQ 11
Aug 12 08:56:11 localhost kernel: PCI: Using ACPI for IRQ routing
Aug 12 08:56:11 localhost kernel: ACPI: AC Adapter [AC] (on-line)
Aug 12 08:56:11 localhost kernel: ACPI: Battery Slot [BAT0] (battery present)
Aug 12 08:56:11 localhost kernel: ACPI: Power Button (FF) [PWRF]
Aug 12 08:56:11 localhost kernel: ACPI: Lid Switch [LID]
Aug 12 08:56:11 localhost kernel: ACPI: Sleep Button (CM) [SLPB]
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_PR_.CPU_._PPC] (Node efb864a8),
AE_AML_NO_RETURN_VALUE
Aug 12 08:56:11 localhost kernel: ACPI: Processor [CPU] (supports C1
C2 C3, 8 throttling states)
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_TZ_.THM0._CRT] (Node efbb8568),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_PR_.CPU_.PINI] (Node eff5e728),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_PR_.CPU_._PDC] (Node eff5e568),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel: speedstep-centrino: found "Intel(R)
Pentium(R) M processor 1.70GHz": max frequency: 1700000kHz
Aug 12 08:56:11 localhost kernel: Software Suspend text mode support loading.
Aug 12 08:56:11 localhost kernel: Software Suspend LZF Compression
Driver registering.
Aug 12 08:56:11 localhost kernel: Software Suspend Swap Writer registering.
Aug 12 08:56:11 localhost kernel: Software Suspend 2.0.0.103:
Suspending enabled.
Aug 12 08:56:11 localhost kernel: ACPI: (supports S0 S3 S4 S5)
Aug 12 08:56:11 localhost kernel: ACPI wakeup devices: 
Aug 12 08:56:11 localhost kernel:  LID SLPB PCI0 UART PCI1 USB0 USB1 USB2 AC9M 
Aug 12 08:56:11 localhost kernel: Linux agpgart interface v0.100 (c) Dave Jones
Aug 12 08:56:11 localhost kernel: agpgart: Detected an Intel 855PM Chipset.
Aug 12 08:56:11 localhost kernel: agpgart: Maximum main memory to use
for agp memory: 690M
Aug 12 08:56:11 localhost kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Aug 12 08:56:11 localhost kernel: cpci_hotplug: CompactPCI Hot Plug
Core version: 0.2
Aug 12 08:56:11 localhost kernel: pci_hotplug: PCI Hot Plug PCI Core
version: 0.5
Aug 12 08:56:11 localhost kernel: pciehp: acpi_pciehprm:   Slot sun(1)
at s:b:d:f=0x00:02:00:00
Aug 12 08:56:11 localhost kernel: pciehp: acpi_pciehprm:   Slot sun(2)
at s:b:d:f=0x00:02:00:01
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.FDC_._STA] (Node efbbf188),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-0158: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.FDC_._STA] (Node efbbf188),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.LPT_._STA] (Node efbbfd08),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-0158: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.LPT_._STA] (Node efbbfd08),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.ECP_._STA] (Node efbbfb68),
AE_AML_NO_RETURN_VALUE
Aug 12 08:56:11 localhost kernel:     ACPI-0158: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.ECP_._STA] (Node efbbfb68),
AE_AML_NO_RETURN_VALUE
Aug 12 08:56:11 localhost kernel: pciehp: PCI Express Hot Plug
Controller Driver version: 0.4
Aug 12 08:56:11 localhost kernel: shpchp: acpi_shpchprm:   Slot sun(1)
at s:b:d:f=0x00:02:00:00
Aug 12 08:56:11 localhost kernel: shpchp: acpi_shpchprm:   Slot sun(2)
at s:b:d:f=0x00:02:00:01
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.FDC_._STA] (Node efbbf188),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-0158: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.FDC_._STA] (Node efbbf188),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.LPT_._STA] (Node efbbfd08),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-0158: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.LPT_._STA] (Node efbbfd08),
AE_AML_REGION_LIMIT
Aug 12 08:56:11 localhost kernel:     ACPI-1133: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.ECP_._STA] (Node efbbfb68),
AE_AML_NO_RETURN_VALUE
Aug 12 08:56:11 localhost kernel:     ACPI-0158: *** Error: Method
execution failed [\_SB_.PCI0.LPC_.ECP_._STA] (Node efbbfb68),
AE_AML_NO_RETURN_VALUE


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
