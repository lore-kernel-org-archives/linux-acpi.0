From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: PCI not restored correctly after suspend to ram
Date: Tue, 23 Mar 2004 21:42:23 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403232142.23874.stefandoesinger@gmx.at>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at> <1079719856.7278.30.camel@dhcppc4>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1079719856.7278.30.camel-D2Zvc0uNKG8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
> Bruno is correct, the PCI config space should be saved and restored by
> the driver's suspend and resume routines.  suspend/resume routines
> typically do other hardware dependent stuff, but your debugging suggests
> that at least for some of these devices, simply saving and restoring pci
> config space (pci_save_state()/pci_restore_state()) may be sufficient.
>
> Time to take a look at the drivers for those devices...

Thank you very much, now the broadcom ethernet card(b44) and the first pcmcia 
bridge resume properly.
I don't need firewire, the ipw2100 driver has no card specific resume code 
right now(the pci part works fine), and the modem only has a closed driver. 
So I'm content with everything except the sound card.

The last remaining problem is the sound card(Intel Corp. 82801DB (ICH4) AC'97 
Audio Controller (rev 03), i810_audio): Any call to pci_enable_device(), 
pci_restore_state() or pci_write_config_X() crashes.

I can revive the card from user mode with setpci. To make pci_enable_device 
succeed, I have to change 3 registers:

#setpci -s 00:1f.5 11.b=0x1c
#setpci -s 00:1f.5 14.b=0xc1
#setpci -s 00:1f.5 15.b=0x18

Calling pci_write_config_byte() from the resume function of the driver caueses 
a lockup. 

What's the function of these registers(11, 14, 15), and why doesn't setpci 
crash?

Thank you very much so far, and I hope you can help me here too.

Cheers,
Stefan

Here's again the pci configuration of the soundcard:

Before suspend:
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio 
Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]
	Region 2: Memory at d0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at d0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c5 24 07 00 90 02 03 00 01 04 00 00 00 00
10: 01 1c 00 00 c1 18 00 00 00 0c 00 d0 00 08 00 d0
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 00 00

After suspend:
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio 
Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 1c00 [disabled] [size=256]
	Region 1: I/O ports at 18c0 [disabled] [size=64]
	Region 2: [virtual] Memory at d0000c00 (32-bit, non-prefetchable) [disabled] 
[size=512]
	Region 3: [virtual] Memory at d0000800 (32-bit, non-prefetchable) [disabled] 
[size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c5 24 00 00 90 02 03 00 01 04 00 00 00 00
10: 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 02 00 00


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
