From: Michael Gruetzner <Michael_Gruetzner-Mmb7MZpHnFY@public.gmane.org>
Subject: Fan and Temperature on my Laptop
Date: Fri, 02 Jan 2004 16:41:23 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FF59123.60607@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080004000906020208080603"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080004000906020208080603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello(and happy new year!),

I reacently bought a new laptop. It's a lifebook E2010 by Fujitsu-Siemens.
I got ACPI work well except the fan and temerature stuff.  I use kernel 
2.6.0
and I have compiled in all the ACPI drivers. When I look at /proc/acpi I 
can
find the fan and thermal_zone directories but they are empty.

During the boot process I get some information about the detected 
devices(Button,
etc. ) but there is nothing about fan or temp. I have attached a file 
with the ACPI
related kernel messages(I hope that is ok).

Does anyone know why there is no information about fan and temp on my 
laptop?

Thanks for any hints in advance.

MfG
Michael

--------------080004000906020208080603
Content-Type: text/plain;
 name="acpi.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi.msg"

 BIOS-e820: 000000000eef0000 - 000000000eeff000 (ACPI data)
 BIOS-e820: 000000000eeff000 - 000000000ef00000 (ACPI NVS)
ACPI: RSDP (v000 FUJ                                       ) @ 0x000f68f0
ACPI: RSDT (v001 FUJ    ROSETTA  0x01210000 FUJ  0x00001000) @ 0x0eefa046
ACPI: FADT (v001 FUJ    ROSETTA  0x01210000 FUJ  0x00001000) @ 0x0eefecc6
ACPI: SSDT (v001 FUJ    ROSETTA  0x01210000 MSFT 0x0100000e) @ 0x0eefed3a
ACPI: BOOT (v001 FUJ    ROSETTA  0x01210000 FUJ  0x00001000) @ 0x0eefefd8
ACPI: DSDT (v001 FUJ    ROSETTA  0x01210000 MSFT 0x0100000e) @ 0x00000000
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: No IRQ known for interrupt pin A of device 0000:00:0f.0
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [CMB1] (battery present)
ACPI: Battery Slot [CMB2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: No IRQ known for interrupt pin A of device 0000:00:0f.0
cpufreq: No CPUs supporting ACPI performance management found.
ACPI: (supports S0 S3 S4 S5)

--------------080004000906020208080603--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
