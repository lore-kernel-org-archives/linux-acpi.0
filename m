From: Frank Fiene <ffiene-MDAluyXF630@public.gmane.org>
Subject: Problems with Thinkpad A31p
Date: Mon, 1 Mar 2004 09:01:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403010901.25316.ffiene@veka.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
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
List-Id: linux-acpi@vger.kernel.org

Hi,

i have problems using my A31p with the docking station since 2.6.2-ac3 of 
the linux kernel.

I am using SuSE 9.0 and had to start with acpi=off, if i load kernel 
2.4.*.

After upgrading to 2.6, i tried some things and i found the DSDT file for 
the A31 on acpi.sf.net. I am quiet happy with this but if i connect my 
Thinkpad to the docking station, USB doesn't work.

dmesg says:

 BIOS-e820: 000000002ff70000 - 000000002ff7e000 (ACPI data)
 BIOS-e820: 000000002ff7e000 - 000000002ff80000 (ACPI NVS)
ACPI: RSDP (v002 IBM                                       ) @ 0x000f7040
ACPI: XSDT (v001 IBM    TP-1N    0x00001030  LTP 0x00000000) @ 0x2ff72e02
ACPI: FADT (v001 IBM    TP-1N    0x00001030 IBM  0x00000001) @ 0x2ff72e4e
ACPI: SSDT (v001 IBM    TP-1N    0x00001030 MSFT 0x0100000d) @ 0x2ff72f02
ACPI: ECDT (v001 IBM    TP-1N    0x00001030 IBM  0x00000001) @ 0x2ff7df54
ACPI: TCPA (v001 IBM    TP-1N    0x00001030 PTL  0x00000001) @ 0x2ff7dfa6
ACPI: BOOT (v001 IBM    TP-1N    0x00001030  LTP 0x00000001) @ 0x2ff7dfd8
ACPI: DSDT (v001 IBM    TP-1N    0x00001030 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Subsystem revision 20040211
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.DOCK._PRT]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
apm: overridden by ACPI.
ACPI: (supports S0 S3 S4 S5)
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (30 C)

Any suggestions?
-- 
uniorg Solutions GmbH - Märkische Strasse 237 - 44141 Dortmund
ffiene-MDAluyXF630@public.gmane.org - Tel:0231-9497-262
--
Ein Unternehmen der uniorg-Gruppe


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
