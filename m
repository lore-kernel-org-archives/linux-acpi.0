From: Michael Frank <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Fwd: [Swsusp-devel] TWEAK/PATCH for 2.4.22: Fixing yenta with ToPIC95 on resume from swsusp
Date: Sat, 27 Sep 2003 02:30:37 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309270230.37064.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

PCMCIA in a Toshiba libretto L2 failed to work on resume from swsusp/S4. 
Modules were unloaded on suspend and reloaded on resume.

Firstly, the controller ends up being disabled and secondly shared interrupts break.

This is an applicable chipset.

00:12.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory window 0: 10400000-107ff000
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
        16-bit legacy interface ports at 0001

To reenable the controller on resume:
# pcitweak -w 00:12:0 0x84 -b 0

It also had trouble with shared interrupts on resume.

Applicable chipset:

0:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
        Subsystem: Toshiba America Info Systems: Unknown device 0004
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: ALi Corporation M7101 PMU
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

The patch below fixes that by preventing interrupt sharing 
but may break things, so use it only when it does not work 
and with interrupts being shared.

--- linux-2.4.22-mhf75/drivers/acpi/pci_link.c  2003-09-21 13:32:17.000000000 +0800
+++ linux-2.4.22-mhf76/drivers/acpi/pci_link.c  2003-09-21 22:09:27.000000000 +0800
@@ -517,7 +517,7 @@
                        acpi_device_bid(link->device));
                return_VALUE(-ENODEV);
        } else {
-               acpi_irq_penalty[link->irq.active] += 100;
+               acpi_irq_penalty[link->irq.active] += 1000000;
                printk(PREFIX "%s [%s] enabled at IRQ %d\n",
                        acpi_device_name(link->device),
                        acpi_device_bid(link->device), link->irq.active);

With the tweaks presented, this machine is fully functional on resume from 
swsusp/S4 including PCMCIA, USB and network using swsusp-1.1-rc9 on 2.4.22.

Regards
Michael



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
swsusp-devel mailing list
swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/swsusp-devel



-------------------------------------------------------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
