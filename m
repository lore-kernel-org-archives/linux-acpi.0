From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: help with Sharp mm20 irq routing
Date: Wed, 17 Nov 2004 16:19:11 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC08C@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: bphinz-Wuw85uim5zDR7s880joybQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

AFAIK, the most recent ACPI CA has include
handling of UNINITIALIZED_LOCAL.=20
Please pull from http://linux-acpi.bkbits.net:8080/linux-acpi-test-mm

Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>bphinz-Wuw85uim5zDR7s880joybQ@public.gmane.org
>Sent: 2004=C4=EA11=D4=C217=C8=D5 12:31
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] help with Sharp mm20 irq routing
>
>Hi,
>
>I'm trying to debug an ACPI IRQ routing problem on my Sharp=20
>mm20 laptop, hopefully someone on this list can offer some=20
>help. I'm using a vanilla 2.6.8.1 kernel with the initrd dsdt=20
>override patch. The problem looks like a bad dsdt, but so far=20
>I've been unable to fix it.=20
>
>Here's the dmesg output prior to the dsdt override:
>...
>dsmthdat-0462 [39] ds_method_data_get_val: Uninitialized=20
>Local[0] at node de61350c
> dswexec-0435 [35] ds_exec_end_op        : [Index]: Could not=20
>resolve operands, AE_AML_UNINITIALIZED_LOCAL
> psparse-1133: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC_.LNKU._CRS] (Node de620928), AE_AML_UNINITIALIZED_LOCAL
>  uteval-0154: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC_.LNKU._CRS] (Node de620928), AE_AML_UNINITIALIZED_LOCAL
>pci_link-0281 [25] acpi_pci_link_get_curr: Error evaluating _CRS
>ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 7 9 10 11) *0, disabled.
>
>LNKU is an ALi USB 2.0 ehci controller. The dumped dsdt=20
>contains the following:
>...
>                    Method (_DIS, 0, NotSerialized)
>                    {
>                        Store (0x00, PIRU)
>                    }
>
>                    Method (_CRS, 0, NotSerialized)
>                    {
>                        Name (RTLU, ResourceTemplate ()
>                        {
>                            IRQ (Level, ActiveLow, Shared) {}
>                        })
>                        CreateWordField (RTLU, 0x01, IRQ0)
>                        Store (PIRU, IRQ0)
>                        Store (DerefOf (Index (PIRI, Local0)), Local1)
>                        If (Local1)
>                        {
>                            ShiftLeft (0x01, Local1, IRQ0)
>                        }
>
>                        Return (RTLU)
>                   =20
>...
>So clearly Local0 is uninitialized - I changed it to:
>...
>                    Method (_CRS, 0, NotSerialized)
>                    {
>                        Name (RTLU, ResourceTemplate ()
>                        {
>                            IRQ (Level, ActiveLow, Shared) {}
>                        })
>                        CreateWordField (RTLU, 0x01, IRQ0)
>                        Store (PIRU, Local0)
>                        Store (DerefOf (Index (PIRI, Local0)), Local1)
>                        If (Local1)
>                        {
>                            ShiftLeft (0x01, Local1, IRQ0)
>                        }
>
>                        Return (RTLU)
>                    }
>...
>(which looks just like LNK[A-G]), recompiled the dsdt and upon=20
>rebooting the machine promptly locks hard during acpi irq=20
>assignment. Most devices are getting assigned irq's that ought=20
>to be masked out...  I can boot if I use the "pci=3Dnoacpi" boot=20
>argument, but I get erratic behavior from things like the ac=20
>adapter (locks up the machine if removed...).  I also tried=20
>cat'ing the original /proc/acpi/dsdt into a file and using=20
>that as the override and even that locks up the machine (same=20
>as the *fixed* dsdt)! Shouldn't this be (in theory) identical=20
>to the dsdt stored in the bios?=20
>
>In the process of trying to figure out what the dsdt code is=20
>actually doing, I noticed something that seems strange to me. =20
>The PCI config space register addresses are defined with an=20
>offset of 0x48 for LNK[A-G] and 0x74 for LNKU:
>
>                OperationRegion (PIUC, PCI_Config, 0x74, 0x02)
>                Field (PIUC, AnyAcc, NoLock, Preserve)
>                {
>                    AccessAs (ByteAcc, 0x00),
>                    PIRU,   4,
>                    Offset (0x01),
>                    PIRS,   4,
>                    Offset (0x02)
>                }
>
>                OperationRegion (PIRX, PCI_Config, 0x48, 0x04)
>                Field (PIRX, DWordAcc, NoLock, Preserve)
>                {
>                    AccessAs (ByteAcc, 0x00),
>                    PIRA,   4,
>                    PIRB,   4,
>                    PIRC,   4,
>...
>
>however lspci -vvxxx shows:
>
>root@mountaineer ~/projects/acpi # lspci -vvxxx -s 00:0a
>0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co.,=20
>Ltd. RTL-8139/8139C/8139C+ (rev 10)
>...
>        Interrupt: pin A routed to IRQ 4
>...
>30: 00 00 00 00 50 00 00 00 00 00 00 00 04 01 20 40
>40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
>...
>
>which looks more to me like the offset should be 0x3C.  All of=20
>LNK[A-G] have values at 0x3C and 0x3D which correspond to the=20
>IRQ and interrupt pin and zeros at 0x48.  LNKU has zeros at=20
>0x74 and ff 04 at 0x3C, as if the offset should have been the=20
>same as LKN[A-G].
>
>So what I'd like to figure out is:
>(1) Could it be that the addresses are specified wrong in the=20
>dsdt? Or is there another offset applied somewhere in the ACPI=20
>code (I browsed through the source code and didn't see it)=20
>that is shifting it from 0x48 to 0x3C? I don't understand how=20
>the IRQ's are assigned correctly (for all of the devices=20
>except the USB2 controller) with no dsdt override if this is=20
>the case....
>(2) Is there any danger in testing this by changing the=20
>address to 0x3C (ie: can writing to these registers fubar the=20
>hardware)?
>(3) Any other suggestions?
>
>TIA,
>-brian
>
>FYI:
>root@mountaineer ~/projects/acpi # lspci -vvxxx
>0000:00:00.0 Host bridge: Transmeta Corporation: Unknown device 0060
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-=20
>VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast=20
>>TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Region 0: Memory at ec000000 (32-bit, prefetchable) [disabled]
>        Capabilities: [a0] AGP version 2.0
>                Status: RQ=3D16 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh-=20
>GART64- HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2
>                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64-=20
>64bit- FW- Rate=3Dx1
>        Capabilities: [d8] #08 [2001]
>00: 79 12 60 00 00 01 10 00 00 00 00 06 00 00 80 00
>10: 08 00 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
>40: 00 00 00 00 00 00 00 00 80 00 80 1e 80 01 00 08
>50: 00 0a 00 00 00 00 00 00 3f 10 11 01 00 30 13 11
>60: 00 0e f0 ff 10 00 00 00 f0 ff ff ff ff ff ff ff
>70: 00 00 0a 3f 10 00 ea fe 30 80 58 40 32 87 1a 4b
>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>90: 00 00 00 00 00 08 c0 01 00 00 00 08 00 00 00 00
>a0: 02 d8 20 00 03 02 00 0f 01 03 00 00 00 00 00 00
>b0: 80 00 00 00 30 00 00 00 0f 31 4b 1e 00 00 00 00
>c0: 52 21 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 08 00 01 20 20 00 00 00
>e0: 23 00 05 00 0a 00 00 00 01 2c 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:00:01.0 PCI bridge: Transmeta Corporation: Unknown device=20
>0061 (prog-if 00 [Normal decode])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+=20
>VGASnoop- ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast=20
>>TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Bus: primary=3D00, secondary=3D01, subordinate=3D01, =
sec-latency=3D64
>        I/O behind bridge: 00002000-00002fff
>        Memory behind bridge: e8100000-e81fffff
>        Prefetchable memory behind bridge: f0000000-f7ffffff
>        Expansion ROM at 00002000 [disabled] [size=3D4K]
>        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+
>00: 79 12 61 00 17 00 00 00 00 00 04 06 00 00 01 00
>10: 00 00 00 00 00 00 00 00 00 01 01 40 20 20 a0 22
>20: 10 e8 10 e8 00 f0 f0 f7 00 00 00 00 00 00 00 00
>30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c 00
>40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:00:02.0 PCI bridge: ALi Corporation M5249 HTT to PCI=20
>Bridge (prog-if 00 [Normal decode])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
>VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast=20
>>TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Bus: primary=3D00, secondary=3D02, subordinate=3D02, =
sec-latency=3D64
>        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>        Capabilities: [b0] #08 [0020]
>        Capabilities: [f0] #08 [8000]
>00: b9 10 49 52 07 01 10 00 00 00 04 06 00 00 01 00
>10: 00 00 00 00 00 00 00 00 00 02 02 40 f0 00 00 22
>20: f0 ff 00 00 f0 ff 00 00 00 00 00 00 00 00 00 00
>30: 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 04 00
>40: 55 15 00 78 00 00 00 01 7e 00 00 00 00 00 00 01
>50: ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00
>60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 08 f0 20 00 20 20 00 00 d0 00 00 00 24 00 07 00
>c0: 02 00 00 00 00 00 00 00 00 00 00 00 fc 99 66 77
>d0: 00 bf ff ff ff ff ff ff 00 00 00 00 00 00 00 00
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 08 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:00:03.0 ISA bridge: ALi Corporation M1563 HyperTransport=20
>South Bridge (rev 20)
>        Subsystem: Sharp corporation: Unknown device 103b
>        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV-=20
>VGASnoop- ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-=20
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0 (250ns min, 6000ns max)
>00: b9 10 63 15 0f 00 00 02 20 00 01 06 00 00 80 00
>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 bd 13 3b 10
>30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 18
>40: b5 04 40 10 dd 00 00 00 91 64 39 15 07 90 00 10
>50: 02 00 02 00 0d 09 01 00 00 50 7f d8 81 00 00 00
>60: 00 00 00 30 03 d0 00 00 00 00 00 00 00 00 00 00
>70: 00 02 63 15 03 00 00 00 33 ff ff 87 00 00 00 00
>80: 83 80 00 00 01 00 cc dd 00 00 ee 00 00 00 00 5f
>90: 54 9c df dd 00 12 00 00 7b a4 99 00 01 49 00 38
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 55 9c 01 50 e8 01 73 33 10 00 00 00 00 00 00 00
>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:00:03.1 Bridge: ALi Corporation M7101 Power Management=20
>Controller [PMU]
>        Subsystem: Sharp corporation: Unknown device 103b
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-=20
>VGASnoop- ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-=20
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 80 00
>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 bd 13 3b 10
>30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>40: 00 40 00 00 00 80 21 00 2a 20 00 00 00 00 00 00
>50: 00 07 fe 0f 00 00 00 00 00 5f 01 58 00 00 00 00
>60: 00 00 00 00 a5 00 00 00 00 00 00 aa 01 22 60 0e
>70: 01 01 00 00 00 00 00 68 77 77 90 80 78 fe df 00
>80: 50 a0 00 00 a0 00 02 00 00 00 00 00 20 00 00 00
>90: 00 00 20 00 00 00 00 00 00 00 00 00 01 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: ff 84 00 20 00 ff 01 00 00 fe 00 00 40 a3 00 c0
>c0: 16 00 10 10 00 00 00 00 c0 ff ff 0f 00 00 00 00
>d0: 04 42 04 00 40 00 e0 00 4c 0f 00 00 04 00 00 00
>e0: 00 80 00 00 0e 29 cb 55 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:00:04.0 Multimedia audio controller: ALi Corporation=20
>M5455 PCI AC-Link Controller Audio Device (rev 03)
>        Subsystem: Sharp corporation: Unknown device 103b
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+=20
>VGASnoop- ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-=20
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64 (16000ns min), cache line size 08
>        Interrupt: pin A routed to IRQ 5
>        Region 0: I/O ports at 1000
>        Region 1: Memory at e8002000 (32-bit,=20
>non-prefetchable) [size=3D4K]
>        Capabilities: [40] Power Management version 2
>                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA=20
>PME(D0-,D1-,D2+,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>00: b9 10 55 54 17 00 10 02 03 00 01 04 08 40 00 00
>10: 01 10 00 00 00 20 00 e8 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 bd 13 3b 10
>30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 40 00
>40: 01 00 22 e6 00 00 00 00 00 00 00 00 00 00 00 00
>50: bd 13 3b 10 10 00 c4 00 00 e0 0e 00 00 00 00 00
>60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c0: e4 00 57 54 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:00:06.0 Network controller: Intersil Corporation Intersil=20
>ISL3890 [Prism GT/Prism Duette] (rev 01)
>        Subsystem: AMBIT Microsystem Corp.: Unknown device 0210
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+=20
>VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-=20
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 80 (2500ns min, 7000ns max), cache line size 08
>        Interrupt: pin A routed to IRQ 7
>        Region 0: Memory at e8000000 (32-bit, non-prefetchable)
>        Capabilities: [dc] Power Management version 1
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
>PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>00: 60 12 90 38 16 01 98 02 01 00 80 02 08 50 00 00
>10: 00 00 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 01 08 00 00 68 14 10 02
>30: 00 00 00 00 dc 00 00 00 00 00 00 00 07 01 0a 1c
>40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 fe
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:00:09.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 81)
>        Subsystem: Sharp corporation: Unknown device 103b
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
>VGASnoop- ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-=20
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 168
>        Interrupt: pin A routed to IRQ 11
>        Region 0: Memory at 1e800000 (32-bit, non-prefetchable)
>        Bus: primary=3D00, secondary=3D03, subordinate=3D06, =
sec-latency=3D176
>        Memory window 0: 1ec00000-1efff000 (prefetchable)
>        Memory window 1: 1f000000-1f3ff000
>        I/O window 0: 00004000-000040ff
>        I/O window 1: 00004400-000044ff
>        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset-=20
>16bInt+ PostWrite+
>        16-bit legacy interface ports at 0001
>00: 80 11 75 04 07 00 10 02 81 00 07 06 00 a8 02 00
>10: 00 00 80 1e dc 00 00 02 00 03 06 b0 00 00 c0 1e
>20: 00 f0 ff 1e 00 00 00 1f 00 f0 3f 1f 00 40 00 00
>30: fc 40 00 00 00 44 00 00 fc 44 00 00 ff 01 80 05
>40: bd 13 3b 10 01 00 00 00 00 00 00 00 00 00 00 00
>50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>80: 01 00 a0 00 00 03 00 00 63 04 63 04 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 6d 8b b4 2d 00 00 00 00 00 00 00 00
>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c0: bd 13 3b 10 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 0a fe
>e0: 00 40 c0 24 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co.,=20
>Ltd. RTL-8139/8139C/8139C+ (rev 10)
>        Subsystem: Sharp corporation: Unknown device 103b
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
>VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-=20
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64 (8000ns min, 16000ns max)
>        Interrupt: pin A routed to IRQ 4
>        Region 0: I/O ports at 1400
>        Region 1: Memory at e8005000 (32-bit,=20
>non-prefetchable) [size=3D256]
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA=20
>PME(D0-,D1+,D2+,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>00: ec 10 39 81 07 01 90 02 10 00 00 02 00 40 00 00
>10: 01 14 00 00 00 50 00 e8 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 bd 13 3b 10
>30: 00 00 00 00 50 00 00 00 00 00 00 00 04 01 20 40
>40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
>60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:00:0e.0 IDE interface: ALi Corporation M5229 IDE (rev c5)=20
>(prog-if 8a [Master SecP PriP])
>        Subsystem: Sharp corporation: Unknown device 103b
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-=20
>VGASnoop- ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-=20
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64
>        Interrupt: pin A routed to IRQ 255
>        Region 0: I/O ports at <ignored>
>        Region 1: I/O ports at <ignored>
>        Region 2: I/O ports at <ignored>
>        Region 3: I/O ports at <ignored>
>        Region 4: I/O ports at 1800 [size=3D16]
>00: b9 10 29 52 05 00 80 02 c5 8a 01 01 00 40 00 00
>10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
>20: 01 18 00 00 00 00 00 00 00 00 00 00 bd 13 3b 10
>30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00
>40: 00 00 00 7a 00 00 00 00 00 00 6c c9 00 00 ba 1a
>50: 00 00 00 81 05 00 0f 00 01 31 31 00 00 00 00 00
>60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
>70: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:00:0f.0 USB Controller: ALi Corporation USB 1.1=20
>Controller (rev 03) (prog-if 10 [OHCI])
>        Subsystem: Sharp corporation: Unknown device 103b
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+=20
>VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-=20
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64 (20000ns max), cache line size 08
>        Interrupt: pin A routed to IRQ 11
>        Region 0: Memory at e8003000 (32-bit, non-prefetchable)
>        Capabilities: [60] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
>PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>00: b9 10 37 52 17 01 b0 02 03 10 03 0c 08 40 80 00
>10: 00 30 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 bd 13 3b 10
>30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 50
>40: 00 00 1f 00 e8 02 00 00 00 00 00 00 00 00 00 00
>50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>60: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:00:0f.1 USB Controller: ALi Corporation USB 1.1=20
>Controller (rev 03) (prog-if 10 [OHCI])
>        Subsystem: Sharp corporation: Unknown device 103b
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+=20
>VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-=20
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64 (20000ns max), cache line size 08
>        Interrupt: pin B routed to IRQ 10
>        Region 0: Memory at e8004000 (32-bit, non-prefetchable)
>        Capabilities: [60] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
>PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME+
>00: b9 10 37 52 17 01 b0 02 03 10 03 0c 08 40 80 00
>10: 00 40 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 bd 13 3b 10
>30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 02 00 50
>40: 00 00 1f 00 e8 02 00 00 00 00 00 00 00 00 00 00
>50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>60: 01 00 02 c8 00 80 00 00 00 00 00 00 00 00 00 00
>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:00:0f.3 USB Controller: ALi Corporation USB 2.0=20
>Controller (rev 01) (prog-if 20 [EHCI])
>        Subsystem: Sharp corporation: Unknown device 103b
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+=20
>VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-=20
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64 (20000ns max), cache line size 08
>        Interrupt: pin D routed to IRQ 255
>        Region 0: Memory at e8005400 (32-bit, non-prefetchable)
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
>PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>        Capabilities: [58] #0a [2090]
>00: b9 10 39 52 16 01 b0 02 01 20 03 0c 08 40 80 00
>10: 00 54 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 bd 13 3b 10
>30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 04 00 50
>40: 81 00 00 00 8b 04 30 c4 00 00 00 00 00 00 00 00
>50: 01 58 02 c8 00 00 00 00 0a 00 90 20 00 00 00 00
>60: 20 20 7f 00 00 00 00 00 00 00 00 00 00 00 00 00
>70: 01 00 00 00 00 00 00 c0 00 00 00 00 00 00 00 00
>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>0000:01:00.0 VGA compatible controller: ATI Technologies Inc=20
>Radeon Mobility M6 LY (prog-if 00 [VGA])
>        Subsystem: Sharp corporation: Unknown device 103b
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
>VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
>        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-=20
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 66 (2000ns min), cache line size 08
>        Interrupt: pin A routed to IRQ 9
>        Region 0: Memory at f0000000 (32-bit, prefetchable)
>        Region 1: I/O ports at 2000 [size=3D256]
>        Region 2: Memory at e8100000 (32-bit,=20
>non-prefetchable) [size=3D64K]
>        Capabilities: [58] AGP version 2.0
>                Status: RQ=3D48 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh-=20
>GART64- HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2
>                Command: RQ=3D16 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64-=20
>64bit- FW- Rate=3Dx1
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
>PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>00: 02 10 59 4c 87 03 b0 02 00 00 00 03 08 42 00 00
>10: 08 00 00 f0 01 20 00 00 00 00 10 e8 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 bd 13 3b 10
>30: 00 00 00 00 58 00 00 00 00 00 00 00 09 01 08 00
>40: 00 00 00 00 00 00 00 00 00 00 00 00 bd 13 3b 10
>50: 01 00 02 06 00 00 00 00 02 50 20 00 03 02 00 2f
>60: 01 03 00 0f 00 00 00 00 00 00 00 00 00 00 00 00
>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>root@mountaineer ~/projects/acpi # perl dump_pirq
>Interrupt routing table found at address 0xfdf10:
>  Version 1.0, size 0x00d0
>  Interrupt router is device 00:03.0
>  PCI exclusive interrupt mask: 0x0000 []
>  Compatible router: vendor 0x10b9 device 0x1533
>
>Device 00:00.0 (slot 0):
>
>Device 00:01.0 (slot 0):
>  INTA: link 0x01, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>  INTB: link 0x02, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>
>Device 01:00.0 (slot 0):
>  INTA: link 0x01, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>  INTB: link 0x02, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>
>Device 00:02.0 (slot 0):
>  INTA: link 0x01, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>  INTB: link 0x02, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>  INTC: link 0x03, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>  INTD: link 0x04, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>
>Device 00:03.0 (slot 0):
>
>Device 00:04.0 (slot 0):
>  INTA: link 0x07, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>
>Device 00:0e.0 (slot 0):
>
>Device 00:0f.0 (slot 0):
>  INTA: link 0x05, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>  INTB: link 0x06, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>
>Device 00:06.0 (slot 1):
>  INTA: link 0x04, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>
>Device 00:09.0 (slot 0):
>  INTA: link 0x02, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>
>Device 00:0a.0 (slot 0):
>  INTA: link 0x03, irq mask 0xceb8 [3,4,5,7,9,10,11,14,15]
>
>Interrupt router at 00:03.0: AcerLabs Aladdin M1533 PCI-to-ISA bridge
>  INT1 (link 1): irq 9
>  INT2 (link 2): irq 11
>  INT3 (link 3): irq 4
>  INT4 (link 4): irq 7
>  INT5 (link 5): irq 11
>  INT6 (link 6): irq 10
>  INT7 (link 7): irq 5
>  INT8 (link 8): irq 9
>  Serial IRQ: [disabled] [quiet] [frame=3D17] [pulse=3D4]
>
>root@mountaineer ~/projects/acpi # demsg
>-bash: demsg: command not found
>root@mountaineer ~/projects/acpi # dmesg
> Objects with 43 Devices 350 Methods 17 Regions
>Parsing all Control Methods:
>Table [SSDT](id F003) - 1 Objects with 0 Devices 0 Methods 0 Regions
>Parsing all Control Methods:
>Table [SSDT](id F004) - 3 Objects with 0 Devices 0 Methods 0 Regions
>ACPI Namespace successfully loaded at root c05acf7c
>ACPI: IRQ9 SCI: Level Trigger.
>evxfevnt-0093 [04] acpi_enable           : Transition to ACPI=20
>mode successful
>evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 63 [_GPE]=20
>8 regs at 0000000000008018 on int 9
>evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake,=20
>Enabled 4 Runtime GPEs in this block
>Completing Region/Field/Buffer/Package=20
>initialization:................................................
>.................
>Initialized 17/17 Regions 0/0 Fields 11/11 Buffers 37/37=20
>Packages (662 nodes)
>Executing all Device _STA and_INI=20
>methods:.............................................
>45 Devices found containing: 45 _STA, 1 _INI methods
>ACPI: Interpreter enabled
>ACPI: Using PIC for interrupt routing
>nsxfeval-0243 [07] acpi_evaluate_object  : Handle is NULL and=20
>Pathname is relative
>nsxfeval-0243 [07] acpi_evaluate_object  : Handle is NULL and=20
>Pathname is relative
>nsxfeval-0243 [07] acpi_evaluate_object  : Handle is NULL and=20
>Pathname is relative
>nsxfeval-0243 [07] acpi_evaluate_object  : Handle is NULL and=20
>Pathname is relative
>ACPI: PCI Root Bridge [PCI0] (00:00)
>PCI: Probing PCI hardware (bus 00)
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11)
>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11) *0, disabled.
>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 *4 5 7 9 10 11)
>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *7 9 10 11)
>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11)
>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11)
>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 7 9 10 11)
>dsmthdat-0462 [39] ds_method_data_get_val: Uninitialized=20
>Local[0] at node de61350c
> dswexec-0435 [35] ds_exec_end_op        : [Index]: Could not=20
>resolve operands, AE_AML_UNINITIALIZED_LOCAL
> psparse-1133: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC_.LNKU._CRS] (Node de620928), AE_AML_UNINITIALIZED_LOCAL
>  uteval-0154: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC_.LNKU._CRS] (Node de620928), AE_AML_UNINITIALIZED_LOCAL
>pci_link-0281 [25] acpi_pci_link_get_curr: Error evaluating _CRS
>ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 7 9 10 11) *0, disabled.
>ACPI: Embedded Controller [M_EC] (gpe 30)
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
>SCSI subsystem initialized
>Linux Kernel Card Services
>  options:  [pci] [cardbus] [pm]
>usbcore: registered new driver usbfs
>usbcore: registered new driver hub
>PCI: Using ACPI for IRQ routing
>ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
>ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 5 (level, low) -> IRQ 5
>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 7
>ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 7 (level, low) -> IRQ 7
>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
>ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 11 (level, low) -> IRQ 11
>ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
>ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 4 (level, low) -> IRQ 4
> pci_irq-0314 [27] acpi_pci_irq_derive   : Unable to derive=20
>IRQ for device 0000:00:0e.0
>ACPI: PCI interrupt 0000:00:0e.0[A]: no GSI
>ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
>ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 (level, low) -> IRQ 11
>ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
>ACPI: PCI interrupt 0000:00:0f.1[B] -> GSI 10 (level, low) -> IRQ 10
>dsmthdat-0462 [47] ds_method_data_get_val: Uninitialized=20
>Local[0] at node de61350c
> dswexec-0435 [43] ds_exec_end_op        : [Index]: Could not=20
>resolve operands, AE_AML_UNINITIALIZED_LOCAL
> psparse-1133: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC_.LNKU._CRS] (Node de620928), AE_AML_UNINITIALIZED_LOCAL
>  uteval-0154: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC_.LNKU._CRS] (Node de620928), AE_AML_UNINITIALIZED_LOCAL
>pci_link-0281 [33] acpi_pci_link_get_curr: Error evaluating _CRS
>ACPI: Unable to set IRQ for PCI Interrupt Link [LNKU] (likely=20
>buggy ACPI BIOS).
>Try pci=3Dnoacpi or acpi=3Doff
> pci_irq-0258 [29] acpi_pci_irq_lookup   : Invalid IRQ link=20
>routing entry
> pci_irq-0314 [29] acpi_pci_irq_derive   : Unable to derive=20
>IRQ for device 0000:00:0f.3
>ACPI: PCI interrupt 0000:00:0f.3[D]: no GSI
>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
>ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 9 (level, low) -> IRQ 9
>ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 9 (level, low) -> IRQ 9
>radeonfb: Retreived PLL infos from BIOS
>radeonfb: Reference=3D27.00 MHz (RefDiv=3D60) Memory=3D143.75 Mhz,=20
>System=3D143.75 MHz
>i2c_adapter i2c-0: registered as adapter #0
>i2c_adapter i2c-1: registered as adapter #1
>i2c_adapter i2c-2: registered as adapter #2
>i2c_adapter i2c-3: registered as adapter #3
>i2c_adapter i2c-1: master_xfer: with 2 msgs.
>i2c_adapter i2c-1: master_xfer: with 2 msgs.
>i2c_adapter i2c-1: master_xfer: with 2 msgs.
>i2c_adapter i2c-3: master_xfer: with 2 msgs.
>i2c_adapter i2c-3: master_xfer: with 2 msgs.
>i2c_adapter i2c-3: master_xfer: with 2 msgs.
>Non-DDC laptop panel detected
>i2c_adapter i2c-2: master_xfer: with 2 msgs.
>i2c_adapter i2c-2: master_xfer: with 2 msgs.
>i2c_adapter i2c-2: master_xfer: with 2 msgs.
>i2c_adapter i2c-3: master_xfer: with 2 msgs.
>i2c_adapter i2c-3: master_xfer: with 2 msgs.
>i2c_adapter i2c-3: master_xfer: with 2 msgs.
>radeonfb: Monitor 1 type LCD found
>radeonfb: Monitor 2 type no found
>radeonfb: panel ID string: 1024x768
>radeonfb: detected LVDS panel size from BIOS: 1024x768
>radeondb: BIOS provided dividers will be used
>radeonfb: Power Management enabled for Mobility chipsets
>radeonfb: ATI Radeon LY  DDR SGRAM 16 MB
>audit: initializing netlink socket (disabled)
>audit(1100642030.392:0): initialized
>devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
>devfs: boot_options: 0x0
>Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
>udf: registering filesystem
>Initializing Cryptographic API
>pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
>acpiphp_glue: can't get bus number, assuming 0
>ACPI: AC Adapter [AC] (off-line)
>ACPI: Battery Slot [BAT0] (battery present)
>ACPI: Power Button (FF) [PWRF]
>ACPI: Lid Switch [LID0]
>ACPI: Processor [CPU0] (supports C1 C2 C3)
>ACPI: Thermal Zone [THRM] (45 C)
>Console: switching to colour frame buffer device 128x48
>Real Time Clock Driver v1.12
>Linux agpgart interface v0.100 (c) Dave Jones
>agpgart: Detected Transmeta Efficeon TM8000 series chipset
>PCI: Enabling device 0000:00:00.0 (0100 -> 0102)
>agpgart: Maximum main memory to use for agp memory: 416M
>agpgart: efficeon_create_gatt_table(16384)
>agpgart: efficeon_configure()
>agpgart: AGP aperture is 64M @ 0xec000000
>[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI=20
>Technologies Inc Radeon Mobility M6 LY
>Serial: 8250/16550 driver $Revision: 1.90 $ 14 ports, IRQ=20
>sharing disabled
>Using anticipatory io scheduler
>floppy0: no floppy controllers found
>RAMDISK driver initialized: 16 RAM disks of 8124K size 1024 blocksize
>loop: loaded (max 8 devices)
>PPP generic driver version 2.4.2
>PPP Deflate Compression module registered
>PPP BSD Compression module registered
>SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=3D256).
>CSLIP: code copyright 1989 Regents of the University of California.
>SLIP linefill/keepalive option.
>8139too Fast Ethernet driver 0.9.27
>ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 4 (level, low) -> IRQ 4
>eth0: RealTek RTL8139 at 0x1400, 08:00:1f:bf:46:8f, IRQ 4
>eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
>Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
>Loaded prism54 driver, version 1.2
>ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 7 (level, low) -> IRQ 7
>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 66MHz system bus speed for PIO modes
>ALI15X3: IDE controller at PCI slot 0000:00:0e.0
> pci_irq-0314 [32] acpi_pci_irq_derive   : Unable to derive=20
>IRQ for device 0000:00:0e.0
>ACPI: PCI interrupt 0000:00:0e.0[A]: no GSI
>ALI15X3: chipset revision 197
>ALI15X3: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
>ALI15X3: simplex device: DMA forced
>    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:DMA, hdd:DMA
>hda: HITACHI_DK14FA-20, ATA DISK drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>hda: max request size: 128KiB
>hda: 39070080 sectors (20003 MB) w/2048KiB Cache,=20
>CHS=3D38760/16/63, UDMA(100)
> /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
>ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 11 (level, low) -> IRQ 11
>Yenta: CardBus bridge found at 0000:00:09.0 [13bd:103b]
>Yenta: ISA IRQ mask 0x0008, PCI irq 11
>Socket status: 30000006
>dsmthdat-0462 [50] ds_method_data_get_val: Uninitialized=20
>Local[0] at node de61350c
> dswexec-0435 [46] ds_exec_end_op        : [Index]: Could not=20
>resolve operands, AE_AML_UNINITIALIZED_LOCAL
> psparse-1133: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC_.LNKU._CRS] (Node de620928), AE_AML_UNINITIALIZED_LOCAL
>  uteval-0154: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC_.LNKU._CRS] (Node de620928), AE_AML_UNINITIALIZED_LOCAL
>pci_link-0281 [36] acpi_pci_link_get_curr: Error evaluating _CRS
>ACPI: Unable to set IRQ for PCI Interrupt Link [LNKU] (likely=20
>buggy ACPI BIOS).
>Try pci=3Dnoacpi or acpi=3Doff
> pci_irq-0258 [32] acpi_pci_irq_lookup   : Invalid IRQ link=20
>routing entry
> pci_irq-0314 [32] acpi_pci_irq_derive   : Unable to derive=20
>IRQ for device 0000:00:0f.3
>ACPI: PCI interrupt 0000:00:0f.3[D]: no GSI
>ehci_hcd 0000:00:0f.3: ALi Corporation USB 2.0 Controller
>ehci_hcd 0000:00:0f.3: request interrupt 255 failed
>ehci_hcd 0000:00:0f.3: init 0000:00:0f.3 fail, -22
>ehci_hcd: probe of 0000:00:0f.3 failed with error -22
>ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI)=20
>Driver (PCI)
>ohci_hcd: block sizes: ed 64 td 64
>ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 (level, low) -> IRQ 11
>ohci_hcd 0000:00:0f.0: ALi Corporation USB 1.1 Controller
>ohci_hcd 0000:00:0f.0: irq 11, pci mem e0020000
>ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 1
>hub 1-0:1.0: USB hub found
>hub 1-0:1.0: 2 ports detected
>ACPI: PCI interrupt 0000:00:0f.1[B] -> GSI 10 (level, low) -> IRQ 10
>ohci_hcd 0000:00:0f.1: ALi Corporation USB 1.1 Controller (#2)
>ohci_hcd 0000:00:0f.1: irq 10, pci mem e0022000
>ohci_hcd 0000:00:0f.1: new USB bus registered, assigned bus number 2
>...
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: InterSystems CACHE
>FREE OODBMS DOWNLOAD - A multidimensional database that combines
>robust object and relational technologies, making it a perfect match
>for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
