From: trooper ryan <trooper_ryan-QPf0Bz723pkjHdulDSg1yw@public.gmane.org>
Subject: IRQ routing problem - more info
Date: Sat, 24 Apr 2004 22:41:56 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <408AED34.5020503@dmtsystems.net>
References: <408AD99C.6030501@dmtsystems.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <408AD99C.6030501-QPf0Bz723pkjHdulDSg1yw@public.gmane.org>
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

Here's some more info, I really hope someone can offer me a solution.

Manually changing IRQs in the BIOS doesn't help.
With BIOS IRQ set to AUTO, dmesg output:

ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6a50
ACPI: RSDT (v001 ASUS   CUSI-M   0x30303031 MSFT 0x31313031) @ 0x1bffd000
ACPI: FADT (v001 ASUS   CUSI-M   0x30303031 MSFT 0x31313031) @ 0x1bffd080
ACPI: BOOT (v001 ASUS   CUSI-M   0x30303031 MSFT 0x31313031) @ 0x1bffd040
ACPI: DSDT (v001   ASUS CUSI-M   0x00001000 MSFT 0x0100000b) @ 0x00000000
Built 1 zonelists
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS18 that hid as a SIS503 (compatible=0)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbc80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbcb0, dseg 0xf0000
pnp: match found with the PnP device '00:08' and the driver 'system'
pnp: match found with the PnP device '00:11' and the driver 'system'
pnp: 00:11: ioport range 0x290-0x297 has been reserved
pnp: 00:11: ioport range 0xe400-0xe47f has been reserved
pnp: 00:11: ioport range 0xe480-0xe4ff has been reserved
pnp: 00:11: ioport range 0x480-0x48f has been reserved
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at I pci_irq-0316 [16] 
acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:00:0d.1
ACPI: No IRQ known for interrupt pin ? of device 0000:00:0d.1
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'RQ 11

Here's lspci -vvv output

0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 21)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32
         Region 0: Memory at ec000000 (32-bit, non-prefetchable)
         Capabilities: [c0] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x4

0000:00:0d.0 Multimedia video controller: Brooktree Corporation: Unknown 
device 0346 (rev 11)
         Subsystem: LeadTek Research Inc.: Unknown device 6606
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR+
         Latency: 32 (4000ns min, 10000ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at <ignored> (32-bit, prefetchable)
         Capabilities: [44] <chain broken>

0000:00:0d.1 Multimedia controller: Brooktree Corporation: Unknown 
device 0850 (rev 11)
         Subsystem: LeadTek Research Inc.: Unknown device 6606
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR+
         Latency: 0 (1000ns min, 63750ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at <ignored> (32-bit, prefetchable)
         Capabilities: [44] <chain broken>

0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
630/730 PCI/AGP VGA Display Adapter (rev 21) (prog-if 00 [VGA])
         Subsystem: Asustek Computer, Inc.: Unknown device 80e1
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 11
         BIST result: 00
         Region 0: Memory at f0000000 (32-bit, prefetchable)
         Region 1: Memory at e9800000 (32-bit, non-prefetchable) [size=128K]
         Region 2: I/O ports at a800 [size=128]
         Capabilities: [40] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] AGP version 2.0
                 Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=16 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x4





trooper ryan wrote:
> Further to my last email where I was getting "PCI: Cannot allocate 
> resource region 0 of device 0000:00:0d.0" errors, I disabled PnP in my 
> BIOS.
> 
> Now I'm getting:
> 
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 4
>  pci_irq-0316 [16] acpi_pci_irq_derive   : Unable to derive IRQ for 
> device 0000:00:0d.1
> ACPI: No IRQ known for interrupt pin ? of device 0000:00:0d.1
> PCI: Using ACPI for IRQ routing
> 
> 
> Any ideas?
> 



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
