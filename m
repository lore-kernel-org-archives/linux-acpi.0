From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Wed, 16 Feb 2005 20:26:53 +0100
Message-ID: <200502162026.54992.stefandoesinger@gmx.at>
References: <20050214211105.GA12808@elf.ucw.cz> <200502160948.43005.stefandoesinger@gmx.at> <42136158.5000906@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <42136158.5000906-hi6Y0CQ0nG0@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Mittwoch, 16. Februar 2005 16:06 schrieb Carl-Daniel Hailfinger:
> Stefan D=F6singer schrieb:
> >>The problems with this patch are:
> >>- you need to press a key to come back from the "resume-console" after
> >>resume. - DRI in X does not work (at least for me with intel-agp, others
> >>reportet it works)
> >>I just disabloed it by not loading intel-agp (hotplug-blacklist)
> >
> > You can force the radeon X driver to use pci mode by setting Option
> > "ForcePciMode" to "true" or something simmilar in you X config file. Th=
is
> > way you can get dri without intel-agp. This is much slower, but enought
> > to play tuxracer ;-)
>
> How do I enable DRI with my card to test that crash? I have the
> following in my XF86Config:
>
> Section "DRI"
>     Group      "video"
>     Mode       0660
> EndSection
>
> but nothing else about DRI. So do I have to change something in
> my configuration?
>
> Oh, and could you please include run "lspci -vv" and include the
> part about VGA compatible controller in your mail? I have some
> hypothesis about the settings there having to do with resume.
You can set
Option "BusType" "PCI" in your cards driver section in xorg.conf / XF86Conf=
ig.=20
With this setting you should get DRI without having intel-agp loaded(if the=
=20
rest is set up correctly)

My lspci output is:=20
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (=
rev=20
03)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Capabilities: [e4] #09 [f104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=
 HTrans-=20
64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit- =
=46W+=20
Rate=3Dx4

0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (r=
ev=20
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d0100000-d01fffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        Expansion ROM at 00003000 [disabled] [size=3D4K]
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-=
M)=20
USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at 1800 [size=3D32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-=
M)=20
USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1820 [size=3D32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-=
M)=20
USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at 1840 [size=3D32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB2 EHC=
I=20
Controller (rev 03) (prog-if 20 [EHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 10
        Region 0: Memory at d0000000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 Mobile PCI Bridge (rev 83) (prog=
=2Dif=20
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D=
64
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: d0200000-d05fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM (ICH4-M) LPC Interface Bridge=
=20
(rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4-M) IDE Controller (r=
ev=20
03) (prog-if 8a [Master SecP PriP])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 1860 [size=3D16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=3D1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus=
=20
Controller (rev 03)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1880 [size=3D32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM=20
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 1c00
        Region 1: I/O ports at 18c0 [size=3D64]
        Region 2: Memory at d0000c00 (32-bit, non-prefetchable) [size=3D512]
        Region 3: Memory at d0000800 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97=
=20
Modem Controller (rev 03) (prog-if 00 [Generic])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 2400
        Region 1: I/O ports at 2000 [size=3D128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf=
=20
[FireGL 9000] (rev 01) (prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping+ SERR+ FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d8000000 (32-bit, prefetchable)
        Region 1: I/O ports at 3000 [size=3D256]
        Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=3D64K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=3D48 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=
 HTrans-=20
64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit-=
 FW+=20
Rate=3Dx4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (r=
ev=20
01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d0204000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:02:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini =
PCI=20
Adapter (rev 04)
        Subsystem: Intel Corp. MIM2000/Centrino
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 8500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0206000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-

0000:02:06.0 CardBus bridge: O2 Micro, Inc. OZ711M1 SmartCardBus MultiMedia=
Bay=20
Controller (rev 20)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping+ SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 255
        Region 0: Memory at d0207000 (32-bit, non-prefetchable)
        Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D=
176
        Memory window 0: d0400000-d04ff000 (prefetchable)
        Memory window 1: d0300000-d03ff000 (prefetchable)
        I/O window 0: 00004400-000044ff
        I/O window 1: 00004000-000040ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrit=
e-
        16-bit legacy interface ports at 0001

0000:02:06.1 CardBus bridge: O2 Micro, Inc. OZ711M1 SmartCardBus MultiMedia=
Bay=20
Controller (rev 20)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 20001000 (32-bit, non-prefetchable) [disabled]
        Bus: primary=3D02, secondary=3D07, subordinate=3D0a, sec-latency=3D=
176
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrit=
e-
        16-bit legacy interface ports at 0001

0000:02:06.2 System peripheral: O2 Micro, Inc. OZ711Mx MultiMediaBay=20
Accelerator
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d0208000 (32-bit, non-prefetchable)
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2=
000=20
Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d0209000 (32-bit, non-prefetchable)
        Region 1: Memory at d0200000 (32-bit, non-prefetchable) [size=3D16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

The device entry in xorg.conf:
Section "Device"
    # vendor=3D1002, device=3D4c66
        Identifier  "Card0"
        Driver      "radeon"
        Option      "AGPMode"         "4"
        #Option      "EnablePageFlip"  "1"
        #Option      "DynamicClocks"   "1"
        Option       "dpms"            "1"
        BusID       "PCI:1:0:0"
EndSection

S3 is working fine for me with dri and agp.

Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
