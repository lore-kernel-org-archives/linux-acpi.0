From: "Keshavamurthy, Anil S" <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi kills boot from usb flash media - 2.6.7 kernel
Date: Tue, 13 Jul 2004 00:31:35 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <44BDAFB888F59F408FAE3CC35AB470417CCC34@orsmsx409>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C468AB.6E095AF8"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Barry Dunn <lists-2N9sBa0oe+EDXYZnReoRVg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C468AB.6E095AF8
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi Barry,
	Can you please see if this attached patch helps.

Thanks,
Anil=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Barry Dunn
>Sent: Monday, July 12, 2004 2:50 PM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] acpi kills boot from usb flash media - 2.6.7 kernel
>
>I'm trying to boot from a usb flash memory stick on my laptop=20
>(so I can encrypt the whole drive), it works fine in all the=20
>usb ports with acpi=3Doff in the boot parameters, but with acpi=20
>enabled it usually hangs at the line "ACPI: Subsystem revision=20
>20040326". I say usually because that's the case in 4 of the 5=20
>usb ports, but curiously it tends to stutter on a bit further=20
>in the remaining port, and twice (out of dozens of attempts=20
>with different parameters etc) it has successfully booted from=20
>that port with acpi enabled. It's random however, and I=20
>couldn't reproduce either success.
>
>With acpi debug enabled, in the 'good' port it hangs either at=20
>"Executing all Device _STA and_INI methods:" or "Completing=20
>Region/Field/Buffer/Package initialization:", in the other=20
>ports it hangs at "ACPI Namespace successfully loaded at root=20
>c0495a3c".
>
>The second time it worked, I'd noticed a small pause not=20
>normally there (less than 5 seconds) after the line=20
>"Uncompressing Linux... Ok, booting the kernel", which makes=20
>me suspect the speed of the flash drive (from which an initrd=20
>is loaded) is the problem, and that perhaps that early delay=20
>was what enabled it to boot. Doubly so because booting from a=20
>(obviously faster) usb hard drive enclosure works fine with=20
>acpi in all usb ports.
>
>(Speed doesn't explain why one usb port does better though,=20
>hdparm -t shows no difference between them.)
>
>Could anyone give me pointers on how to introduce a delay in=20
>acpi initialization, or suitably early in the boot process, to=20
>see if that'll do the trick? If anyone's come across a similar=20
>problem and has other suggestions, all the better. The laptop=20
>is a rebadge of a Uniwill system, called an "EI System 4405".=20
>The dsdt does have some compile errors which I managed to get=20
>rid of, but there's no difference between using the modified=20
>or original dsdt. (From looking into the errors, the dsdt=20
>seems similar to some Fujitsu-Siemens and Asus models). I've=20
>tried all acpi related options listed in=20
>kernel-parameters.txt, removing io-apic and local apic from=20
>the kernel, and combinations thereof, but no joy. Basically=20
>I'm a bit stuck. :)
>
>I've attached the dmesg, output of lspci -vv and cat=20
>/proc/interrupts are below, any suggestions are appreciated.
>
>Cheers,
>
>Barry
>
>
>cat /proc/interrupts
>
>           CPU0      =20
>  0:     115836    IO-APIC-edge  timer
>  1:        309    IO-APIC-edge  i8042
>  8:          2    IO-APIC-edge  rtc
>  9:          0   IO-APIC-level  acpi
> 12:       1955    IO-APIC-edge  i8042
> 14:       5608    IO-APIC-edge  ide0
> 15:         19    IO-APIC-edge  ide1
> 16:          0   IO-APIC-level  uhci_hcd
> 17:          8   IO-APIC-level  Intel 82801DB-ICH4, eth0
> 18:          0   IO-APIC-level  uhci_hcd
> 19:          0   IO-APIC-level  uhci_hcd
> 23:        123   IO-APIC-level  ehci_hcd
>NMI:          0=20
>LOC:     115786=20
>ERR:          0
>MIS:          0
>
>lspci -vv
>
>0000:00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM
>Controller/Host-Hub Interface (rev 03)	Subsystem: Uniwill Computer
>Corp: Unknown device 9000	Control: I/O- Mem+ BusMaster+ SpecCycle-
>MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-	Status:=20
>Cap+ 66Mhz- UDF-
>FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort+ >SERR-=20
><PERR-	Latency:
>0	Region 0: Memory at c0000000 (32-bit, prefetchable)
>	Capabilities: [e4] #09 [1105]
>
>0000:00:02.0 VGA compatible controller: Intel Corp.
>82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)
>(prog-if 00 [VGA])	Subsystem: Uniwill Computer Corp:=20
>Unknown device 9000
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
>VGASnoop- ParErr-
>Stepping- SERR- FastB2B-	Status: Cap+ 66Mhz- UDF-=20
>FastB2B+ ParErr-
>DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0
>	Interrupt: pin A routed to IRQ 16
>	Region 0: Memory at d0000000 (32-bit, prefetchable)
>	Region 1: Memory at dff80000 (32-bit, non-prefetchable)=20
>[size=3D512K]
>	Capabilities: [d0] Power Management version 1
>		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
>PME(D0-,D1-,D2-,D3hot-,D3cold-)		Status: D0=20
>PME-Enable- DSel=3D0 DScale=3D0
>PME-
>
>0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB=20
>UHCI #1 (rev
>02) (prog-if 00 [UHCI])	Subsystem: Uniwill Computer=20
>Corp: Unknown device
>9011	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-=20
>VGASnoop- ParErr-
>Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF-=20
>FastB2B+ ParErr-
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0
>	Interrupt: pin A routed to IRQ 16
>	Region 4: I/O ports at df20 [size=3D32]
>
>0000:00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB=20
>UHCI #2 (rev
>02) (prog-if 00 [UHCI])	Subsystem: Uniwill Computer=20
>Corp: Unknown device
>9011	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-=20
>VGASnoop- ParErr-
>Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF-=20
>FastB2B+ ParErr-
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0
>	Interrupt: pin B routed to IRQ 19
>	Region 4: I/O ports at df40 [size=3D32]
>
>0000:00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB=20
>UHCI #3 (rev
>02) (prog-if 00 [UHCI])	Subsystem: Uniwill Computer=20
>Corp: Unknown device
>9011	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-=20
>VGASnoop- ParErr-
>Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF-=20
>FastB2B+ ParErr-
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0
>	Interrupt: pin C routed to IRQ 18
>	Region 4: I/O ports at df80 [size=3D32]
>
>0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI
>Controller (rev 02) (prog-if 20 [EHCI])	Subsystem:=20
>Uniwill Computer
>Corp: Unknown device 9110	Control: I/O- Mem+ BusMaster+ SpecCycle-
>MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-	Status:=20
>Cap+ 66Mhz- UDF-
>FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- =
<PERR-
>Latency: 0	Interrupt: pin D routed to IRQ 23
>	Region 0: Memory at dff7bc00 (32-bit, non-prefetchable)
>	Capabilities: [50] Power Management version 2
>		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
>PME(D0+,D1-,D2-,D3hot+,D3cold+)		Status: D0=20
>PME-Enable- DSel=3D0 DScale=3D0
>PME-	Capabilities: [58] #0a [2080]
>
>0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface
>to PCI Bridge (rev 82) (prog-if 00 [Normal decode])=09
>Control: I/O+ Mem+
>BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
>FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-=20
>DEVSEL=3Dfast >TAbort-
><TAbort- <MAbort- >SERR- <PERR+	Latency: 0
>	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
>	I/O behind bridge: 0000c000-0000cfff
>	Memory behind bridge: dfd00000-dfdfffff
>	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
>
>0000:00:1f.0 ISA bridge: Intel Corp. 82801DB (ICH4) LPC Bridge (rev 02)
>	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV-=20
>VGASnoop- ParErr-
>Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF-=20
>FastB2B+ ParErr-
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0
>
>0000:00:1f.1 IDE interface: Intel Corp. 82801DB (ICH4) Ultra ATA 100
>Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])=09
>Subsystem:
>Uniwill Computer Corp: Unknown device 9011	Control: I/O+=20
>Mem+ BusMaster+
>SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-=09
>Status: Cap-
>66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort-
>>SERR- <PERR-
>	Latency: 0
>	Interrupt: pin A routed to IRQ 18
>	Region 0: I/O ports at <unassigned>
>	Region 1: I/O ports at <unassigned>
>	Region 2: I/O ports at <unassigned>
>	Region 3: I/O ports at <unassigned>
>	Region 4: I/O ports at ffa0 [size=3D16]
>	Region 5: Memory at 10000000 (32-bit, non-prefetchable)=20
>[size=3D1K]
>
>0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus=20
>Controller (rev
>02)	Subsystem: Uniwill Computer Corp: Unknown device 9011
>	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV-=20
>VGASnoop- ParErr-
>Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF-=20
>FastB2B+ ParErr-
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Interrupt: pin =
B
>routed to IRQ 17	Region 4: I/O ports at 0540 [size=3D32]
>
>0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4)
>AC'97 Audio Controller (rev 02)	Subsystem: Uniwill=20
>Computer Corp:
>Unknown device 9011	Control: I/O+ Mem+ BusMaster+=20
>SpecCycle- MemWINV-
>VGASnoop- ParErr- Stepping- SERR- FastB2B-	Status: Cap+ 66Mhz- UDF-
>FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- =
<PERR-
>Latency: 0	Interrupt: pin B routed to IRQ 17
>	Region 0: I/O ports at e000
>	Region 1: I/O ports at e100 [size=3D64]
>	Region 2: Memory at 10000400 (32-bit, non-prefetchable)=20
>[size=3D512]
>	Region 3: Memory at 10000600 (32-bit, non-prefetchable)=20
>[size=3D256]
>	Capabilities: [50] Power Management version 2
>		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
>PME(D0+,D1-,D2-,D3hot+,D3cold+)		Status: D0=20
>PME-Enable- DSel=3D0 DScale=3D0
>PME-
>
>0000:00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller
>(rev 02) (prog-if 00 [Generic])	Subsystem: Uniwill=20
>Computer Corp: Unknown device
>4007	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-=20
>VGASnoop- ParErr-
>Stepping- SERR- FastB2B-	Status: Cap+ 66Mhz- UDF-=20
>FastB2B+ ParErr-
>DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0
>	Interrupt: pin B routed to IRQ 17
>	Region 0: I/O ports at e200
>	Region 1: I/O ports at e300 [size=3D128]
>	Capabilities: [50] Power Management version 2
>		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
>PME(D0+,D1-,D2-,D3hot+,D3cold+)		Status: D0=20
>PME-Enable- DSel=3D0 DScale=3D0
>PME-
>
>0000:01:0c.0 Ethernet controller: National Semiconductor Corporation
>DP83815 (MacPhyter) Ethernet Controller	Subsystem:=20
>Uniwill Computer Corp:
>Unknown device 9011	Control: I/O+ Mem+ BusMaster+=20
>SpecCycle- MemWINV-
>VGASnoop- ParErr- Stepping- SERR+ FastB2B-	Status: Cap+ 66Mhz- UDF-
>FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- =
<PERR-
>Latency: 64 (2750ns min, 13000ns max)	Interrupt: pin A routed to IRQ
>17	Region 0: I/O ports at c800 [size=3Ddfde0000]
>	Region 1: Memory at dfdff000 (32-bit, non-prefetchable)=20
>[size=3D4K]
>	Expansion ROM at 00010000 [disabled]
>	Capabilities: [40] Power Management version 2
>		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D320mA
>PME(D0+,D1+,D2+,D3hot+,D3cold+)		Status: D0=20
>PME-Enable- DSel=3D0 DScale=3D0
>PME+
>
>
>

------_=_NextPart_001_01C468AB.6E095AF8
Content-Type: application/octet-stream;
	name="kacpid.patch"
Content-Transfer-Encoding: base64
Content-Description: kacpid.patch
Content-Disposition: attachment;
	filename="kacpid.patch"

LS0tCgogbGludXgtMi42LjctcmMzLW1tMS1yb290L2RyaXZlcnMvYWNwaS9vc2wuYyB8ICAgMTAg
KysrKysrKystLQogMSBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCgpkaWZmIC1wdU4gZHJpdmVycy9hY3BpL29zbC5jfmthY3BpZCBkcml2ZXJzL2FjcGkvb3Ns
LmMKLS0tIGxpbnV4LTIuNi43LXJjMy1tbTEvZHJpdmVycy9hY3BpL29zbC5jfmthY3BpZAkyMDA0
LTA3LTEzIDA3OjM2OjAzLjU2MjIwNDk1NCAtMDcwMAorKysgbGludXgtMi42LjctcmMzLW1tMS1y
b290L2RyaXZlcnMvYWNwaS9vc2wuYwkyMDA0LTA3LTEzIDA3OjQ1OjI3LjQ2Nzc2NzExMSAtMDcw
MApAQCAtODQsOCArODQsNiBAQCBhY3BpX29zX2luaXRpYWxpemUodm9pZCkKIAkJcmV0dXJuIEFF
X05VTExfRU5UUlk7CiAJfQogI2VuZGlmCi0Ja2FjcGlkX3dxID0gY3JlYXRlX3NpbmdsZXRocmVh
ZF93b3JrcXVldWUoImthY3BpZCIpOwotCUJVR19PTigha2FjcGlkX3dxKTsKIAogCXJldHVybiBB
RV9PSzsKIH0KQEAgLTEwODUsMyArMTA4MywxMSBAQCBhY3BpX2xlYXZlX2dwZXNfZGlzYWJsZWRf
c2V0dXAoY2hhciAqc3RyCiAKIF9fc2V0dXAoImFjcGlfbGVhdmVfZ3Blc19kaXNhYmxlZCIsIGFj
cGlfbGVhdmVfZ3Blc19kaXNhYmxlZF9zZXR1cCk7CiAKK3N0YXRpYyBfX2luaXQgaW50IGthY3Bp
ZF9pbml0KHZvaWQpCit7CisJa2FjcGlkX3dxID0gY3JlYXRlX3NpbmdsZXRocmVhZF93b3JrcXVl
dWUoImthY3BpZCIpOworCUJVR19PTigha2FjcGlkX3dxKTsKKwlyZXR1cm4gMDsKK30KK2NvcmVf
aW5pdGNhbGwoa2FjcGlkX2luaXQpOworCgpfCg==

------_=_NextPart_001_01C468AB.6E095AF8--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
