From: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Subject: Re: shutting down individual devices
Date: Mon, 26 Jul 2004 16:42:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040726144253.GA4428@rap.rap.dk>
References: <20040720135143.GA16058@rap.rap.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040720135143.GA16058-EittdKFJ/bZ/SzgSGea1oA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I tried to shut down other devices and it worked (eth0).

So I think the reason why nothing seemed to work for me with the
devices shown below, is that no actions are defined in the DSDT for
these devices on the machine.

My idea is then if I can write my own DSDT for this, compile it and load
it, and then hope for the hardware to work for me. Is that possible?

            Device (AC97)
            {
                Name (_ADR, 0x001F0006)
                Name (_PRW, Package (0x02)
                {
                    0x05,
                    0x03
                })
            }

            Device (AC05)
            {
                Name (_ADR, 0x00090000)
            }
=20


Could I throw in some methods to power down the sound device, ala
what is done for the USB? here is an entry for one of the USB
interfaces. Or could I damage the hardware by trying out a new DSDT?
 =20
            Device (USB1)
            {
                Name (_ADR, 0x001D0000)
                OperationRegion (USBO, PCI_Config, 0xC4, 0x04)
                Field (USBO, DWordAcc, Lock, Preserve)
                {
                    RSEN,   2
                }
=20
                Name (_PRW, Package (0x02)
                {
                    0x03,
                    0x00
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, RSEN)
                    }
                    Else
                    {
                        Store (0x00, RSEN)
                    }
                }
=20
                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }
=20
                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }



Best regards
keld

> Tue, Jul 20, 2004 at 03:51:43PM +0200, Keld J=F8rn Simonsen wrote:
> Hi
>=20
> I would like to shut down a few devices individually.
> The devices I try to shut down are:
>=20
> The modem=20
> The sound system
>=20
> I think I can save about 2 W in this way, as lspci -vvx
> reports an AuxCurrent of 375 mA - I think this is at 3,3 V
> on my Acer TM233 laptop, so that would be about 1 W each, giving me
> about 30 minutes extra of battery life.
>=20
> I do this by echo -n 3 >/sys/devices/pci*/*/power/state
> and then I verified that the state was changed to 3.
>=20
> But lspci -vvx (reproduced below) says that the devices are still in D0=
.
> Is this an error? Do I need to shut down drivers before I shut down the
> drivers in this way, or would the kernel do that automatically for me?
>=20
> kernel 2.6.7=20
>=20
> best regards
> keld
>=20
> lspci -vvx:
>=20
> 00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host
> Bridge (rev 03)
>         Subsystem: Unknown device 17c0:2056
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
-
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D256=
M]
>         Capabilities: [e4] #09 [1105]
> 00: 86 80 60 25 06 01 90 20 03 00 00 06 00 00 00 00
> 10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 56 20
> 30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00
> =20
> 00:02.0 VGA compatible controller: Intel Corp. 82845G/GL [Brookdale-G]
> Chipset Integrated Graphics Device (rev 03) (prog-if 00 [VGA])
>         Subsystem: Unknown device 17c0:2056
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 10
>         Region 0: Memory at d8000000 (32-bit, prefetchable) [size=3D128=
M]
>         Region 1: Memory at d0000000 (32-bit, non-prefetchable)
> [size=3D512K]
>         Capabilities: [d0] Power Management version 1
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 00: 86 80 62 25 07 00 90 00 03 00 00 03 00 00 00 00
> 10: 08 00 00 d8 00 00 00 d0 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 56 20
> 30: 00 00 00 00 d0 00 00 00 00 00 00 00 0a 01 00 00
> =20
> 00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
> (prog-if 00 [UHCI])
>         Subsystem: Unknown device 17c0:4002
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 10
>         Region 4: I/O ports at 1800 [size=3D32]
> 00: 86 80 c2 24 05 00 80 02 02 00 03 0c 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 01 18 00 00 00 00 00 00 00 00 00 00 c0 17 02 40
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00
> =20
> 00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
> (prog-if 00 [UHCI])
>         Subsystem: Unknown device 17c0:4002
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 11
>         Region 4: I/O ports at 1820 [size=3D32]
> 00: 86 80 c4 24 05 00 80 02 02 00 03 0c 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 21 18 00 00 00 00 00 00 00 00 00 00 c0 17 02 40
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00
> =20
> 00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
> (prog-if 00 [UHCI])
>         Subsystem: Unknown device 17c0:4002
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin C routed to IRQ 11
>         Region 4: I/O ports at 1840 [size=3D32]
> 00: 86 80 c7 24 05 00 80 02 02 00 03 0c 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 41 18 00 00 00 00 00 00 00 00 00 00 c0 17 02 40
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 00
> =20
> 00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 02) (prog-if 20
> [EHCI])
>         Subsystem: Unknown device 17c0:1071
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin D routed to IRQ 11
>         Region 0: Memory at d0080000 (32-bit, non-prefetchable)
> [size=3D1K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>         Capabilities: [58] #0a [2080]
> 00: 86 80 cd 24 06 01 90 02 02 20 03 0c 00 00 00 00
> 10: 00 00 08 d0 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 71 10
> 30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 04 00 00
> =20
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 82)
> (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
-
> <TAbort- <MAbort- >SERR- <PERR+
>         Latency: 0
>         Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latenc=
y=3D32
>         I/O behind bridge: 00003000-00003fff
>         Memory behind bridge: d0100000-d01fffff
>         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 00: 86 80 4e 24 07 01 80 80 82 00 04 06 00 00 01 00
> 10: 00 00 00 00 00 00 00 00 00 02 02 20 30 30 80 22
> 20: 10 d0 10 d0 f0 ff 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00
> =20
> 00:1f.0 ISA bridge: Intel Corp. 82801DB LPC Interface Controller (rev
> 02)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
> 00: 86 80 c0 24 0f 00 80 02 02 00 01 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =20
> 00:1f.1 IDE interface: Intel Corp. 82801DB Ultra ATA Storage Controller
> (rev 02) (prog-if 8a [Master SecP PriP])
>         Subsystem: Unknown device 17c0:4002
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at <ignored>
>         Region 1: I/O ports at <ignored>
>         Region 2: I/O ports at <ignored>
>         Region 3: I/O ports at <ignored>
>         Region 4: I/O ports at 1860 [size=3D16]
>         Region 5: Memory at 10000000 (32-bit, non-prefetchable)
> [size=3D1K]
> 00: 86 80 cb 24 07 00 80 02 02 8a 01 01 00 00 00 00
> 10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
> 20: 61 18 00 00 00 00 00 10 00 00 00 00 c0 17 02 40
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00
> =20
> 00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 02)
>         Subsystem: Unknown device 17c0:4002
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin B routed to IRQ 10
>         Region 4: I/O ports at 1880 [size=3D32]
> 00: 86 80 c3 24 01 00 80 02 02 00 05 0c 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 81 18 00 00 00 00 00 00 00 00 00 00 c0 17 02 40
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00
> =20
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio
> Controller (rev 02)
>         Subsystem: Unknown device 17c0:2005
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 10
>         Region 0: I/O ports at 1c00 [size=3D256]
>         Region 1: I/O ports at 18c0 [size=3D64]
>         Region 2: Memory at d0080c00 (32-bit, non-prefetchable)
> [size=3D512]
>         Region 3: Memory at d0080800 (32-bit, non-prefetchable)
> [size=3D256]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 00: 86 80 c5 24 07 00 90 02 02 00 01 04 00 00 00 00
> 10: 01 1c 00 00 c1 18 00 00 00 0c 08 d0 00 08 08 d0
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 05 20
> 30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 02 00 00
> =20
> 00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 02)
> (prog-if 00 [Generic])
>         Subsystem: Unknown device 17c0:1069
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin B routed to IRQ 10
>         Region 0: I/O ports at 2400 [size=3D256]
>         Region 1: I/O ports at 2000 [size=3D128]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 00: 86 80 c6 24 01 00 90 02 02 00 03 07 00 00 00 00
> 10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 69 10
> 30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 02 00 00
> =20
> 02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
>         Subsystem: Unknown device 17c0:1053
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (8000ns min, 16000ns max)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at 3000 [size=3D256]
>         Region 1: Memory at d0100000 (32-bit, non-prefetchable)
> [size=3D256]
>         Expansion ROM at <unassigned> [disabled] [size=3D64K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 00: ec 10 39 81 07 01 90 02 10 00 00 02 00 20 00 00
> 10: 01 30 00 00 00 00 10 d0 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 53 10
> 30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40
> =20
> 02:09.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
>         Subsystem: Unknown device 17c0:3102
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort=
-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 168
>         Interrupt: pin A routed to IRQ 10
>         Region 0: Memory at 10001000 (32-bit, non-prefetchable)
> [size=3D4K]
>         Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latenc=
y=3D176
>         Memory window 0: 10400000-107ff000 (prefetchable)
>         Memory window 1: 10800000-10bff000
>         I/O window 0: 00004000-000040ff
>         I/O window 1: 00004400-000044ff
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
> PostWrite+
>         16-bit legacy interface ports at 0001
> 00: 17 12 72 69 87 00 10 04 00 00 07 06 00 a8 02 00
> 10: 00 10 00 10 a0 00 00 02 02 03 06 b0 00 00 40 10
> 20: 00 f0 7f 10 00 00 80 10 00 f0 bf 10 01 40 00 00
> 30: fd 40 00 00 01 44 00 00 fd 44 00 00 00 01 80 05
> 40: c0 17 02 31 01 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=3D4721&alloc_id=3D10040&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
