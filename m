From: "Polevoy, IgorX" <igorx.polevoy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: sleep/suspend and reboot events
Date: Mon, 14 Apr 2003 12:57:32 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <DFDDBBFBAF6C634BAE34B5F175A29F021F0B62@hasmsx403.iil.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
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

Hi,
I've got acpi installed on RH with vanilla kernel 2.4.20 and patch 20021212.
Also, I installed acpid v. 1.0.1 and event/action files to catch all the
events.
In the meantime I'm getting only Power Button Event.

However, I'm interested in getting Suspend/Standby events as well.
Why I do not receive them? 

Another question: Is it possible to get Reset Button Event? Reboot event
notification with ACPI?

Thanks,
Igor.

dmesg for ACPI following:

8000000 (ACPI NVS)
ACPI: have wakeup address 0xc0002000
ACPI: RSDP (v000 ASUS                       ) @ 0x000f8010
ACPI: RSDT (v001 ASUS   P2B-N    22616.11825) @ 0x07ffd000
ACPI: FADT (v001 ASUS   P2B-N    22616.11825) @ 0x07ffd080
ACPI: BOOT (v001 ASUS   P2B-N    22616.11825) @ 0x07ffd040
ACPI: DSDT (v001   ASUS P2B-N    00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: auto BOOT_IMAGE=linux-2.4.20 ro root=302
BOOT_FILE=/boot/vmlinuz-2.4.20 apm=off acpi=on
ACPI: Subsystem revision 20021212
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
ACPI Namespace successfully loaded at root c041525c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode
successful
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
