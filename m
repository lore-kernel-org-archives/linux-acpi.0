From: noth <sa100-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: ACPI produces 100% system load
Date: Thu, 13 Mar 2003 17:43:56 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303131743.56123.sa100@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

This is on a Toshiba Satellite 5205. I have settled on the options of AC 
Adapter, Battery, Processor, Thermal Zone, and the Toshiba extras. After 
having the same results from every other possible configuration. I went 
through the message boards and found a mention of the Fan, and Toshiba extras 
conflicting. Not having the Fan selected at least "seems" to lessen the 
problem (system usage is still 100% but it seems I can steal back almost 80% 
(In spikes only!)  of the processor with out the fan option. 30% or so with 
it.). This is a legacy free system (no accessible bios) so I kind of need 
ACPI to work. Not sure what is causing it au, top, etc... do not report any 
thing useful. I am using the latest Gentoo-sources kernel, as I get the same 
results from it as I do from the Lost-logic and Vanilla sources. I have not
attached the acpidmp (too large for mailing list).

System uses an Intel 82845, 82801 chipset and Pentium4-m.

dmesg info : 
	ACPI: Subsystem revision 20021122
    ACPI-0511: *** Info: GPE Block0 defined as GPE0 to GPE15
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 *4 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs *5)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
VFS: Diskquotas version dquot_6.4.0 initialized
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2 C3, 2 performance states)
ACPI: Thermal Zone [THRM] (45 C)
Toshiba Laptop ACPI Extras version 0.13
Intel(R) PRO/100 Network Driver - version 2.1.24-k1
PPP generic driver version 2.4.2
klips_info:ipsec_init: KLIPS startup, FreeS/WAN IPSec version: 
super-freeswan-1.99_kb3
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
lm75.o version 2.7.0 (20021208)
eeprom.o version 2.7.0 (20021208)
ltc1710.o version 2.7.0 (20021208)
smbus-arp.o version 2.7.0 (20021208)
ip_conntrack version 2.1 (4094 buckets, 32752 max) - 312 bytes per conntrack

NOTE : The battery report is correct.








-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
