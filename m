From: Barry Dunn <lists-2N9sBa0oe+EDXYZnReoRVg@public.gmane.org>
Subject: acpi kills boot from usb flash media - 2.6.7 kernel
Date: Mon, 12 Jul 2004 22:49:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040712224931.7196f3dd@gen.aqui>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__12_Jul_2004_22_49_31_+0100_m9JmNVWU3ORHU.od"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

This is a multi-part message in MIME format.

--Multipart=_Mon__12_Jul_2004_22_49_31_+0100_m9JmNVWU3ORHU.od
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I'm trying to boot from a usb flash memory stick on my laptop (so I can
encrypt the whole drive), it works fine in all the usb ports with
acpi=off in the boot parameters, but with acpi enabled it usually hangs
at the line "ACPI: Subsystem revision 20040326". I say usually because
that's the case in 4 of the 5 usb ports, but curiously it tends to
stutter on a bit further in the remaining port, and twice (out of dozens
of attempts with different parameters etc) it has successfully booted
from that port with acpi enabled. It's random however, and I couldn't
reproduce either success.

With acpi debug enabled, in the 'good' port it hangs either at
"Executing all Device _STA and_INI methods:" or "Completing
Region/Field/Buffer/Package initialization:", in the other ports it
hangs at "ACPI Namespace successfully loaded at root c0495a3c".

The second time it worked, I'd noticed a small pause not normally
there (less than 5 seconds) after the line "Uncompressing Linux... Ok,
booting the kernel", which makes me suspect the speed of the flash drive
(from which an initrd is loaded) is the problem, and that perhaps that
early delay was what enabled it to boot. Doubly so because booting from
a (obviously faster) usb hard drive enclosure works fine with acpi in
all usb ports.

(Speed doesn't explain why one usb port does better though, hdparm -t
shows no difference between them.)

Could anyone give me pointers on how to introduce a delay in acpi
initialization, or suitably early in the boot process, to see if that'll
do the trick? If anyone's come across a similar problem and has other
suggestions, all the better. The laptop is a rebadge of a Uniwill
system, called an "EI System 4405". The dsdt does have some compile
errors which I managed to get rid of, but there's no difference between
using the modified or original dsdt. (From looking into the errors, the
dsdt seems similar to some Fujitsu-Siemens and Asus models). I've tried
all acpi related options listed in kernel-parameters.txt, removing
io-apic and local apic from the kernel, and combinations thereof, but no
joy. Basically I'm a bit stuck. :)

I've attached the dmesg, output of lspci -vv and cat /proc/interrupts
are below, any suggestions are appreciated.

Cheers,

Barry


cat /proc/interrupts

           CPU0       
  0:     115836    IO-APIC-edge  timer
  1:        309    IO-APIC-edge  i8042
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:       1955    IO-APIC-edge  i8042
 14:       5608    IO-APIC-edge  ide0
 15:         19    IO-APIC-edge  ide1
 16:          0   IO-APIC-level  uhci_hcd
 17:          8   IO-APIC-level  Intel 82801DB-ICH4, eth0
 18:          0   IO-APIC-level  uhci_hcd
 19:          0   IO-APIC-level  uhci_hcd
 23:        123   IO-APIC-level  ehci_hcd
NMI:          0 
LOC:     115786 
ERR:          0
MIS:          0

lspci -vv

0000:00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM
Controller/Host-Hub Interface (rev 03)	Subsystem: Uniwill Computer
Corp: Unknown device 9000	Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-	Status: Cap+ 66Mhz- UDF-
FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-	Latency:
0	Region 0: Memory at c0000000 (32-bit, prefetchable)
	Capabilities: [e4] #09 [1105]

0000:00:02.0 VGA compatible controller: Intel Corp.
82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)
(prog-if 00 [VGA])	Subsystem: Uniwill Computer Corp: Unknown device 9000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d0000000 (32-bit, prefetchable)
	Region 1: Memory at dff80000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)		Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev
02) (prog-if 00 [UHCI])	Subsystem: Uniwill Computer Corp: Unknown device
9011	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at df20 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev
02) (prog-if 00 [UHCI])	Subsystem: Uniwill Computer Corp: Unknown device
9011	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at df40 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev
02) (prog-if 00 [UHCI])	Subsystem: Uniwill Computer Corp: Unknown device
9011	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at df80 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI
Controller (rev 02) (prog-if 20 [EHCI])	Subsystem: Uniwill Computer
Corp: Unknown device 9110	Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-	Status: Cap+ 66Mhz- UDF-
FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 0	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at dff7bc00 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)		Status: D0 PME-Enable- DSel=0 DScale=0
PME-	Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface
to PCI Bridge (rev 82) (prog-if 00 [Normal decode])	Control: I/O+ Mem+
BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR+	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: dfd00000-dfdfffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801DB (ICH4) LPC Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DB (ICH4) Ultra ATA 100
Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])	Subsystem:
Uniwill Computer Corp: Unknown device 9011	Control: I/O+ Mem+ BusMaster+
SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-	Status: Cap-
66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev
02)	Subsystem: Uniwill Computer Corp: Unknown device 9011
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Interrupt: pin B
routed to IRQ 17	Region 4: I/O ports at 0540 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4)
AC'97 Audio Controller (rev 02)	Subsystem: Uniwill Computer Corp:
Unknown device 9011	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-	Status: Cap+ 66Mhz- UDF-
FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 0	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at e000
	Region 1: I/O ports at e100 [size=64]
	Region 2: Memory at 10000400 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at 10000600 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)		Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller
(rev 02) (prog-if 00 [Generic])	Subsystem: Uniwill Computer Corp: Unknown device
4007	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at e200
	Region 1: I/O ports at e300 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)		Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:01:0c.0 Ethernet controller: National Semiconductor Corporation
DP83815 (MacPhyter) Ethernet Controller	Subsystem: Uniwill Computer Corp:
Unknown device 9011	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR+ FastB2B-	Status: Cap+ 66Mhz- UDF-
FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 64 (2750ns min, 13000ns max)	Interrupt: pin A routed to IRQ
17	Region 0: I/O ports at c800 [size=dfde0000]
	Region 1: Memory at dfdff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 00010000 [disabled]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)		Status: D0 PME-Enable- DSel=0 DScale=0
PME+


--Multipart=_Mon__12_Jul_2004_22_49_31_+0100_m9JmNVWU3ORHU.od
Content-Type: application/octet-stream;
 name="dmesg.ei4405"
Content-Disposition: attachment;
 filename="dmesg.ei4405"
Content-Transfer-Encoding: base64

TGludXggdmVyc2lvbiAyLjYuNy1nZW50b28tcjktMDEgKHJvb3RAdGluKSAoZ2NjIHZlcnNpb24g
My4zLjMgMjAwNDA0MTIgKEdlbnRvbyBMaW51eCAzLjMuMy1yNiwgc3NwLTMuMy4yLTIsIHBpZS04
LjcuNikpICMxIFNhdCBKdWwgMTAgMDg6NTc6MTkgQlNUIDIwMDQKQklPUy1wcm92aWRlZCBwaHlz
aWNhbCBSQU0gbWFwOgogQklPUy1lODIwOiAwMDAwMDAwMDAwMDAwMDAwIC0gMDAwMDAwMDAwMDA5
ZmMwMCAodXNhYmxlKQogQklPUy1lODIwOiAwMDAwMDAwMDAwMDlmYzAwIC0gMDAwMDAwMDAwMDBh
MDAwMCAocmVzZXJ2ZWQpCiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwZTAwMDAgLSAwMDAwMDAwMDAw
MTAwMDAwIChyZXNlcnZlZCkKIEJJT1MtZTgyMDogMDAwMDAwMDAwMDEwMDAwMCAtIDAwMDAwMDAw
MGY3ZDAwMDAgKHVzYWJsZSkKIEJJT1MtZTgyMDogMDAwMDAwMDAwZjdkMDAwMCAtIDAwMDAwMDAw
MGY3ZGYwMDAgKEFDUEkgZGF0YSkKIEJJT1MtZTgyMDogMDAwMDAwMDAwZjdkZjAwMCAtIDAwMDAw
MDAwMGY4MDAwMDAgKEFDUEkgTlZTKQogQklPUy1lODIwOiAwMDAwMDAwMGZmZjgwMDAwIC0gMDAw
MDAwMDEwMDAwMDAwMCAocmVzZXJ2ZWQpCjI0N01CIExPV01FTSBhdmFpbGFibGUuCmZvdW5kIFNN
UCBNUC10YWJsZSBhdCAwMDBmZjc4MApPbiBub2RlIDAgdG90YWxwYWdlczogNjM0NDAKICBETUEg
em9uZTogNDA5NiBwYWdlcywgTElGTyBiYXRjaDoxCiAgTm9ybWFsIHpvbmU6IDU5MzQ0IHBhZ2Vz
LCBMSUZPIGJhdGNoOjE0CiAgSGlnaE1lbSB6b25lOiAwIHBhZ2VzLCBMSUZPIGJhdGNoOjEKRE1J
IDIuMyBwcmVzZW50LgpBQ1BJOiBSU0RQICh2MDAwIEFDUElBTSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICkgQCAweDAwMGY1NTIwCkFDUEk6IFJTRFQgKHYwMDEgQSBNIEkgIE9F
TVJTRFQgIDB4MDgwMDAzMDUgTVNGVCAweDAwMDAwMDk3KSBAIDB4MGY3ZDAwMDAKQUNQSTogRkFE
VCAodjAwMiBBIE0gSSAgT0VNRkFDUCAgMHgwODAwMDMwNSBNU0ZUIDB4MDAwMDAwOTcpIEAgMHgw
ZjdkMDIwMApBQ1BJOiBNQURUICh2MDAxIEEgTSBJICBPRU1BUElDICAweDA4MDAwMzA1IE1TRlQg
MHgwMDAwMDA5NykgQCAweDBmN2QwMzkwCkFDUEk6IE9FTUIgKHYwMDEgQSBNIEkgIEFNSV9PRU0g
IDB4MDgwMDAzMDUgTVNGVCAweDAwMDAwMDk3KSBAIDB4MGY3ZGYwNDAKQUNQSTogRFNEVCAodjAw
MSAgMUFCSEkgMUFCSEkwMTYgMHgwMDAwMDAxNiBJTlRMIDB4MDIwMDIwMjYpIEAgMHgwMDAwMDAw
MApBQ1BJOiBMb2NhbCBBUElDIGFkZHJlc3MgMHhmZWUwMDAwMApBQ1BJOiBMQVBJQyAoYWNwaV9p
ZFsweDAxXSBsYXBpY19pZFsweDAwXSBlbmFibGVkKQpQcm9jZXNzb3IgIzAgMTU6MiBBUElDIHZl
cnNpb24gMjAKQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwMl0gbGFwaWNfaWRbMHg4MV0gZGlzYWJs
ZWQpCkFDUEk6IElPQVBJQyAoaWRbMHgwMV0gYWRkcmVzc1sweGZlYzAwMDAwXSBnbG9iYWxfaXJx
X2Jhc2VbMHgwXSkKSU9BUElDWzBdOiBBc3NpZ25lZCBhcGljX2lkIDEKSU9BUElDWzBdOiBhcGlj
X2lkIDEsIHZlcnNpb24gMzIsIGFkZHJlc3MgMHhmZWMwMDAwMCwgR1NJIDAtMjMKQUNQSTogSU5U
X1NSQ19PVlIgKGJ1cyAwIGJ1c19pcnEgMCBnbG9iYWxfaXJxIDIgZGZsIGRmbCkKQUNQSTogSU5U
X1NSQ19PVlIgKGJ1cyAwIGJ1c19pcnEgOSBnbG9iYWxfaXJxIDkgaGlnaCBsZXZlbCkKRW5hYmxp
bmcgQVBJQyBtb2RlOiAgRmxhdC4gIFVzaW5nIDEgSS9PIEFQSUNzClVzaW5nIEFDUEkgKE1BRFQp
IGZvciBTTVAgY29uZmlndXJhdGlvbiBpbmZvcm1hdGlvbgpCdWlsdCAxIHpvbmVsaXN0cwpLZXJu
ZWwgY29tbWFuZCBsaW5lOiByb290PS9kZXYvcmFtMCBydyBpbml0PS9saW51eHJjCkluaXRpYWxp
emluZyBDUFUjMApQSUQgaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDI0IChvcmRlciAxMDogODE5MiBi
eXRlcykKRGV0ZWN0ZWQgMjQwMC44MDkgTUh6IHByb2Nlc3Nvci4KVXNpbmcgdHNjIGZvciBoaWdo
LXJlcyB0aW1lc291cmNlCkNvbnNvbGU6IGNvbG91ciBWR0ErIDgweDI1Ck1lbW9yeTogMjQzMjI4
ay8yNTM3NjBrIGF2YWlsYWJsZSAoMjM1Nmsga2VybmVsIGNvZGUsIDk4MjBrIHJlc2VydmVkLCA4
OTlrIGRhdGEsIDE1NmsgaW5pdCwgMGsgaGlnaG1lbSkKQ2hlY2tpbmcgaWYgdGhpcyBwcm9jZXNz
b3IgaG9ub3VycyB0aGUgV1AgYml0IGV2ZW4gaW4gc3VwZXJ2aXNvciBtb2RlLi4uIE9rLgpDYWxp
YnJhdGluZyBkZWxheSBsb29wLi4uIDQ3MzQuOTcgQm9nb01JUFMKRGVudHJ5IGNhY2hlIGhhc2gg
dGFibGUgZW50cmllczogMzI3NjggKG9yZGVyOiA1LCAxMzEwNzIgYnl0ZXMpCklub2RlLWNhY2hl
IGhhc2ggdGFibGUgZW50cmllczogMTYzODQgKG9yZGVyOiA0LCA2NTUzNiBieXRlcykKTW91bnQt
Y2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIgKG9yZGVyOiAwLCA0MDk2IGJ5dGVzKQpDUFU6
ICAgICBBZnRlciBnZW5lcmljIGlkZW50aWZ5LCBjYXBzOiBiZmViZmJmZiAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMApDUFU6ICAgICBBZnRlciB2ZW5kb3IgaWRlbnRpZnksIGNhcHM6IGJmZWJm
YmZmIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwCkNQVTogVHJhY2UgY2FjaGU6IDEySyB1b3Bz
LCBMMSBEIGNhY2hlOiA4SwpDUFU6IEwyIGNhY2hlOiAxMjhLCkNQVTogICAgIEFmdGVyIGFsbCBp
bml0cywgY2FwczogYmZlYmZiZmYgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwODAKSW50ZWwgbWFj
aGluZSBjaGVjayBhcmNoaXRlY3R1cmUgc3VwcG9ydGVkLgpJbnRlbCBtYWNoaW5lIGNoZWNrIHJl
cG9ydGluZyBlbmFibGVkIG9uIENQVSMwLgpDUFUwOiBJbnRlbCBQNC9YZW9uIEV4dGVuZGVkIE1D
RSBNU1JzICgxMikgYXZhaWxhYmxlCkNQVTA6IFRoZXJtYWwgbW9uaXRvcmluZyBlbmFibGVkCkNQ
VTogSW50ZWwoUikgQ2VsZXJvbihSKSBDUFUgMi40MEdIeiBzdGVwcGluZyAwOQpFbmFibGluZyBm
YXN0IEZQVSBzYXZlIGFuZCByZXN0b3JlLi4uIGRvbmUuCkVuYWJsaW5nIHVubWFza2VkIFNJTUQg
RlBVIGV4Y2VwdGlvbiBzdXBwb3J0Li4uIGRvbmUuCkNoZWNraW5nICdobHQnIGluc3RydWN0aW9u
Li4uIE9LLgplbmFibGVkIEV4dElOVCBvbiBDUFUjMApFU1IgdmFsdWUgYmVmb3JlIGVuYWJsaW5n
IHZlY3RvcjogMDAwMDAwMDAKRVNSIHZhbHVlIGFmdGVyIGVuYWJsaW5nIHZlY3RvcjogMDAwMDAw
MDAKRU5BQkxJTkcgSU8tQVBJQyBJUlFzCmluaXQgSU9fQVBJQyBJUlFzCiBJTy1BUElDIChhcGlj
aWQtcGluKSAxLTAsIDEtMTYsIDEtMTcsIDEtMTgsIDEtMTksIDEtMjAsIDEtMjEsIDEtMjIsIDEt
MjMgbm90IGNvbm5lY3RlZC4KLi5USU1FUjogdmVjdG9yPTB4MzEgcGluMT0yIHBpbjI9LTEKVXNp
bmcgbG9jYWwgQVBJQyB0aW1lciBpbnRlcnJ1cHRzLgpjYWxpYnJhdGluZyBBUElDIHRpbWVyIC4u
LgouLi4uLiBDUFUgY2xvY2sgc3BlZWQgaXMgMjM5OS4wNzA4IE1Iei4KLi4uLi4gaG9zdCBidXMg
Y2xvY2sgc3BlZWQgaXMgOTkuMDk4NyBNSHouCmNoZWNraW5nIGlmIGltYWdlIGlzIGluaXRyYW1m
cy4uLml0IGlzbid0ICh1bmd6aXAgZmFpbGVkKTsgbG9va3MgbGlrZSBhbiBpbml0cmQKRnJlZWlu
ZyBpbml0cmQgbWVtb3J5OiA0MDk2ayBmcmVlZApORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFt
aWx5IDE2ClBDSTogUENJIEJJT1MgcmV2aXNpb24gMi4xMCBlbnRyeSBhdCAweGYwMDMxLCBsYXN0
IGJ1cz0xClBDSTogVXNpbmcgY29uZmlndXJhdGlvbiB0eXBlIDEKbXRycjogdjIuMCAoMjAwMjA1
MTkpCkFDUEk6IFN1YnN5c3RlbSByZXZpc2lvbiAyMDA0MDMyNgpBQ1BJOiBJbnRlcnByZXRlciBl
bmFibGVkCkFDUEk6IFVzaW5nIElPQVBJQyBmb3IgaW50ZXJydXB0IHJvdXRpbmcKQUNQSTogUENJ
IFJvb3QgQnJpZGdlIFtQQ0kwXSAoMDA6MDApClBDSTogUHJvYmluZyBQQ0kgaGFyZHdhcmUgKGJ1
cyAwMCkKUENJOiBJZ25vcmluZyBCQVIwLTMgb2YgSURFIGNvbnRyb2xsZXIgMDAwMDowMDoxZi4x
ClBDSTogVHJhbnNwYXJlbnQgYnJpZGdlIC0gMDAwMDowMDoxZS4wCkFDUEk6IFBDSSBJbnRlcnJ1
cHQgUm91dGluZyBUYWJsZSBbXF9TQl8uUENJMC5fUFJUXQpBQ1BJOiBQQ0kgSW50ZXJydXB0IFJv
dXRpbmcgVGFibGUgW1xfU0JfLlBDSTAuUDBQMi5fUFJUXQpBQ1BJOiBQb3dlciBSZXNvdXJjZSBb
VVJQMV0gKG9mZikKQUNQSTogUG93ZXIgUmVzb3VyY2UgW1VSUDJdIChvZmYpCkFDUEk6IFBvd2Vy
IFJlc291cmNlIFtGRERQXSAob2ZmKQpBQ1BJOiBQb3dlciBSZXNvdXJjZSBbTFBUUF0gKG9mZikK
QUNQSTogRW1iZWRkZWQgQ29udHJvbGxlciBbRUMwXSAoZ3BlIDI4KQpBQ1BJOiBQQ0kgSW50ZXJy
dXB0IExpbmsgW0xOS0FdIChJUlFzIDMgNCA1IDYgNyA5IDEwICoxMSAxMiAxNCAxNSkKQUNQSTog
UENJIEludGVycnVwdCBMaW5rIFtMTktCXSAoSVJRcyAqMyA0IDUgNiA3IDkgMTAgMTEgMTIgMTQg
MTUpCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LQ10gKElSUXMgMyA0IDUgNiA3ICo5IDEw
IDExIDEyIDE0IDE1KQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0RdIChJUlFzIDMgNCAq
NSA2IDcgOSAxMCAxMSAxMiAxNCAxNSkKQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktFXSAo
SVJRcyAzIDQgNSA2IDcgOSAxMCAxMSAxMiAxNCAxNSkgKjAsIGRpc2FibGVkLgpBQ1BJOiBQQ0kg
SW50ZXJydXB0IExpbmsgW0xOS0ZdIChJUlFzIDMgNCA1IDYgNyA5IDEwIDExIDEyIDE0IDE1KSAq
MCwgZGlzYWJsZWQuCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LR10gKElSUXMgMyA0IDUg
NiA3IDkgMTAgMTEgMTIgMTQgMTUpICowLCBkaXNhYmxlZC4KQUNQSTogUENJIEludGVycnVwdCBM
aW5rIFtMTktIXSAoSVJRcyAzIDQgNSA2IDcgOSAqMTAgMTEgMTIgMTQgMTUpClNDU0kgc3Vic3lz
dGVtIGluaXRpYWxpemVkCnVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGRyaXZlciB1c2Jmcwp1c2Jj
b3JlOiByZWdpc3RlcmVkIG5ldyBkcml2ZXIgaHViCjAwOjAwOjAxW0FdIC0+IDEtMTYgLT4gSVJR
IDE2IGxldmVsIGxvdwowMDowMDowMVtCXSAtPiAxLTE3IC0+IElSUSAxNyBsZXZlbCBsb3cKMDA6
MDA6MWZbQV0gLT4gMS0xOCAtPiBJUlEgMTggbGV2ZWwgbG93CjAwOjAwOjFkW0JdIC0+IDEtMTkg
LT4gSVJRIDE5IGxldmVsIGxvdwowMDowMDoxZFtEXSAtPiAxLTIzIC0+IElSUSAyMyBsZXZlbCBs
b3cKbnVtYmVyIG9mIE1QIElSUSBzb3VyY2VzOiAxNS4KbnVtYmVyIG9mIElPLUFQSUMgIzEgcmVn
aXN0ZXJzOiAyNC4KdGVzdGluZyB0aGUgSU8gQVBJQy4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uCklP
IEFQSUMgIzEuLi4uLi4KLi4uLiByZWdpc3RlciAjMDA6IDAxMDAwMDAwCi4uLi4uLi4gICAgOiBw
aHlzaWNhbCBBUElDIGlkOiAwMQouLi4uLi4uICAgIDogRGVsaXZlcnkgVHlwZTogMAouLi4uLi4u
ICAgIDogTFRTICAgICAgICAgIDogMAouLi4uIHJlZ2lzdGVyICMwMTogMDAxNzgwMjAKLi4uLi4u
LiAgICAgOiBtYXggcmVkaXJlY3Rpb24gZW50cmllczogMDAxNwouLi4uLi4uICAgICA6IFBSUSBp
bXBsZW1lbnRlZDogMQouLi4uLi4uICAgICA6IElPIEFQSUMgdmVyc2lvbjogMDAyMAouLi4uIHJl
Z2lzdGVyICMwMjogMDEwMDAwMDAKLi4uLi4uLiAgICAgOiBhcmJpdHJhdGlvbjogMDEKLi4uLiBy
ZWdpc3RlciAjMDM6IDAwMDAwMDAxCi4uLi4uLi4gICAgIDogQm9vdCBEVCAgICA6IDEKLi4uLiBJ
UlEgcmVkaXJlY3Rpb24gdGFibGU6CiBOUiBMb2cgUGh5IE1hc2sgVHJpZyBJUlIgUG9sIFN0YXQg
RGVzdCBEZWxpIFZlY3Q6ICAgCiAwMCAwMDAgMDAgIDEgICAgMCAgICAwICAgMCAgIDAgICAgMCAg
ICAwICAgIDAwCiAwMSAwMDEgMDEgIDEgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIDM5
CiAwMiAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIDMxCiAwMyAwMDEg
MDEgIDAgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIDQxCiAwNCAwMDEgMDEgIDAgICAg
MCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIDQ5CiAwNSAwMDEgMDEgIDAgICAgMCAgICAwICAg
MCAgIDAgICAgMSAgICAxICAgIDUxCiAwNiAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAgICAg
MSAgICAxICAgIDU5CiAwNyAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAg
IDYxCiAwOCAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIDY5CiAwOSAw
MDEgMDEgIDAgICAgMSAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIDcxCiAwYSAwMDEgMDEgIDAg
ICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIDc5CiAwYiAwMDEgMDEgIDAgICAgMCAgICAw
ICAgMCAgIDAgICAgMSAgICAxICAgIDgxCiAwYyAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAg
ICAgMSAgICAxICAgIDg5CiAwZCAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAx
ICAgIDkxCiAwZSAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIDk5CiAw
ZiAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIEExCiAxMCAwMDEgMDEg
IDEgICAgMSAgICAwICAgMSAgIDAgICAgMSAgICAxICAgIEE5CiAxMSAwMDEgMDEgIDEgICAgMSAg
ICAwICAgMSAgIDAgICAgMSAgICAxICAgIEIxCiAxMiAwMDEgMDEgIDEgICAgMSAgICAwICAgMSAg
IDAgICAgMSAgICAxICAgIEI5CiAxMyAwMDEgMDEgIDEgICAgMSAgICAwICAgMSAgIDAgICAgMSAg
ICAxICAgIEMxCiAxNCAwMDAgMDAgIDEgICAgMCAgICAwICAgMCAgIDAgICAgMCAgICAwICAgIDAw
CiAxNSAwMDAgMDAgIDEgICAgMCAgICAwICAgMCAgIDAgICAgMCAgICAwICAgIDAwCiAxNiAwMDAg
MDAgIDEgICAgMCAgICAwICAgMCAgIDAgICAgMCAgICAwICAgIDAwCiAxNyAwMDEgMDEgIDEgICAg
MSAgICAwICAgMSAgIDAgICAgMSAgICAxICAgIEM5CklSUSB0byBwaW4gbWFwcGluZ3M6CklSUTAg
LT4gMDoyCklSUTEgLT4gMDoxCklSUTMgLT4gMDozCklSUTQgLT4gMDo0CklSUTUgLT4gMDo1CklS
UTYgLT4gMDo2CklSUTcgLT4gMDo3CklSUTggLT4gMDo4CklSUTkgLT4gMDo5CklSUTEwIC0+IDA6
MTAKSVJRMTEgLT4gMDoxMQpJUlExMiAtPiAwOjEyCklSUTEzIC0+IDA6MTMKSVJRMTQgLT4gMDox
NApJUlExNSAtPiAwOjE1CklSUTE2IC0+IDA6MTYKSVJRMTcgLT4gMDoxNwpJUlExOCAtPiAwOjE4
CklSUTE5IC0+IDA6MTkKSVJRMjMgLT4gMDoyMwouLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4gZG9uZS4KUENJOiBVc2luZyBBQ1BJIGZvciBJUlEgcm91dGluZwp2ZXNhZmI6IHBy
b2JlIG9mIHZlc2FmYjAgZmFpbGVkIHdpdGggZXJyb3IgLTYKTWFjaGluZSBjaGVjayBleGNlcHRp
b24gcG9sbGluZyB0aW1lciBzdGFydGVkLgp1ZGY6IHJlZ2lzdGVyaW5nIGZpbGVzeXN0ZW0KSW5p
dGlhbGl6aW5nIENyeXB0b2dyYXBoaWMgQVBJCkFDUEk6IEFDIEFkYXB0ZXIgW0FDMF0gKG9uLWxp
bmUpCkFDUEk6IEJhdHRlcnkgU2xvdCBbQkFUMF0gKGJhdHRlcnkgcHJlc2VudCkKQUNQSTogUG93
ZXIgQnV0dG9uIChGRikgW1BXUkZdCkFDUEk6IExpZCBTd2l0Y2ggW0xJRF0KQUNQSTogU2xlZXAg
QnV0dG9uIChDTSkgW1NMUEJdCkFDUEk6IFByb2Nlc3NvciBbQ1BVMV0gKHN1cHBvcnRzIEMxKQpB
Q1BJOiBUaGVybWFsIFpvbmUgW1RIUk1dICg3NSBDKQptaWNlOiBQUy8yIG1vdXNlIGRldmljZSBj
b21tb24gZm9yIGFsbCBtaWNlCmk4MDQyLmM6IERldGVjdGVkIGFjdGl2ZSBtdWx0aXBsZXhpbmcg
Y29udHJvbGxlciwgcmV2IDEuMC4Kc2VyaW86IGk4MDQyIEFVWDAgcG9ydCBhdCAweDYwLDB4NjQg
aXJxIDEyCnNlcmlvOiBpODA0MiBBVVgxIHBvcnQgYXQgMHg2MCwweDY0IGlycSAxMgpTeW5hcHRp
Y3MgVG91Y2hwYWQsIG1vZGVsOiAxCiBGaXJtd2FyZTogNC4xCiBTZW5zb3I6IDgKIG5ldyBhYnNv
bHV0ZSBwYWNrZXQgZm9ybWF0CmlucHV0OiBTeW5QUy8yIFN5bmFwdGljcyBUb3VjaFBhZCBvbiBp
c2EwMDYwL3NlcmlvMgpzZXJpbzogaTgwNDIgQVVYMiBwb3J0IGF0IDB4NjAsMHg2NCBpcnEgMTIK
c2VyaW86IGk4MDQyIEFVWDMgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEyCnNlcmlvOiBpODA0MiBL
QkQgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEKaW5wdXQ6IEFUIFRyYW5zbGF0ZWQgU2V0IDIga2V5
Ym9hcmQgb24gaXNhMDA2MC9zZXJpbzAKUmVhbCBUaW1lIENsb2NrIERyaXZlciB2MS4xMgpod19y
YW5kb20gaGFyZHdhcmUgZHJpdmVyIDEuMC4wIGxvYWRlZApMaW51eCBhZ3BnYXJ0IGludGVyZmFj
ZSB2MC4xMDAgKGMpIERhdmUgSm9uZXMKYWdwZ2FydDogRGV0ZWN0ZWQgYW4gSW50ZWwgODQ1RyBD
aGlwc2V0LgphZ3BnYXJ0OiBNYXhpbXVtIG1haW4gbWVtb3J5IHRvIHVzZSBmb3IgYWdwIG1lbW9y
eTogMTk2TQphZ3BnYXJ0OiBEZXRlY3RlZCA4MDYwSyBzdG9sZW4gbWVtb3J5LgphZ3BnYXJ0OiBB
R1AgYXBlcnR1cmUgaXMgMTI4TSBAIDB4ZDAwMDAwMDAKW2RybV0gSW5pdGlhbGl6ZWQgaTgzMCAx
LjMuMiAyMDAyMTEwOCBvbiBtaW5vciAwOiBJbnRlbCBDb3JwLiA4Mjg0NUcvR0xbQnJvb2tkYWxl
LUddL0dFIENoaXBzZXQgSW50ZWdyYXRlZCBHcmFwaGljcyBEZXZpY2UKUkFNRElTSyBkcml2ZXIg
aW5pdGlhbGl6ZWQ6IDE2IFJBTSBkaXNrcyBvZiAzMjc2OEsgc2l6ZSAxMDI0IGJsb2Nrc2l6ZQpV
bmlmb3JtIE11bHRpLVBsYXRmb3JtIEUtSURFIGRyaXZlciBSZXZpc2lvbjogNy4wMGFscGhhMgpp
ZGU6IEFzc3VtaW5nIDMzTUh6IHN5c3RlbSBidXMgc3BlZWQgZm9yIFBJTyBtb2Rlczsgb3ZlcnJp
ZGUgd2l0aCBpZGVidXM9eHgKSUNINDogSURFIGNvbnRyb2xsZXIgYXQgUENJIHNsb3QgMDAwMDow
MDoxZi4xClBDSTogRW5hYmxpbmcgZGV2aWNlIDAwMDA6MDA6MWYuMSAoMDAwNSAtPiAwMDA3KQpJ
Q0g0OiBjaGlwc2V0IHJldmlzaW9uIDIKSUNINDogbm90IDEwMCUgbmF0aXZlIG1vZGU6IHdpbGwg
cHJvYmUgaXJxcyBsYXRlcgogICAgaWRlMDogQk0tRE1BIGF0IDB4ZmZhMC0weGZmYTcsIEJJT1Mg
c2V0dGluZ3M6IGhkYTpETUEsIGhkYjpwaW8KICAgIGlkZTE6IEJNLURNQSBhdCAweGZmYTgtMHhm
ZmFmLCBCSU9TIHNldHRpbmdzOiBoZGM6RE1BLCBoZGQ6cGlvCmhkYTogSUMyNU4wMzBBVE1SMDQt
MCwgQVRBIERJU0sgZHJpdmUKVXNpbmcgYW50aWNpcGF0b3J5IGlvIHNjaGVkdWxlcgppZGUwIGF0
IDB4MWYwLTB4MWY3LDB4M2Y2IG9uIGlycSAxNApoZGM6IFNBTVNVTkcgQ0RSVy9EVkQgU04tMzI0
RiwgQVRBUEkgQ0QvRFZELVJPTSBkcml2ZQppZGUxIGF0IDB4MTcwLTB4MTc3LDB4Mzc2IG9uIGly
cSAxNQpoZGE6IG1heCByZXF1ZXN0IHNpemU6IDEwMjRLaUIKaGRhOiA1ODYwNTEyMCBzZWN0b3Jz
ICgzMDAwNSBNQikgdy8xNzQwS2lCIENhY2hlLCBDSFM9MTYzODMvMjU1LzYzLCBVRE1BKDEwMCkK
IGhkYTogaGRhMSBoZGEyIGhkYTMgaGRhNCA8IGhkYTUgaGRhNiBoZGE3IGhkYTggaGRhOSBoZGEx
MCBoZGExMSA+CmhkYzogQVRBUEkgMjRYIERWRC1ST00gQ0QtUi9SVyBDRC1NUlcgZHJpdmUsIDIw
NDhrQiBDYWNoZSwgVURNQSgzMykKVW5pZm9ybSBDRC1ST00gZHJpdmVyIFJldmlzaW9uOiAzLjIw
CmVoY2lfaGNkIDAwMDA6MDA6MWQuNzogSW50ZWwgQ29ycC4gODI4MDFEQiAoSUNINCkgVVNCMiBF
SENJIENvbnRyb2xsZXIKUENJOiBTZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAwMDA6
MDA6MWQuNyB0byA2NAplaGNpX2hjZCAwMDAwOjAwOjFkLjc6IGlycSAyMywgcGNpIG1lbSBkMDA5
MWMwMAplaGNpX2hjZCAwMDAwOjAwOjFkLjc6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2ln
bmVkIGJ1cyBudW1iZXIgMQpQQ0k6IGNhY2hlIGxpbmUgc2l6ZSBvZiAxMjggaXMgbm90IHN1cHBv
cnRlZCBieSBkZXZpY2UgMDAwMDowMDoxZC43CmVoY2lfaGNkIDAwMDA6MDA6MWQuNzogVVNCIDIu
MCBlbmFibGVkLCBFSENJIDEuMDAsIGRyaXZlciAyMDA0LU1heS0xMApodWIgMS0wOjEuMDogVVNC
IGh1YiBmb3VuZApodWIgMS0wOjEuMDogNiBwb3J0cyBkZXRlY3RlZApVU0IgVW5pdmVyc2FsIEhv
c3QgQ29udHJvbGxlciBJbnRlcmZhY2UgZHJpdmVyIHYyLjIKdWhjaV9oY2QgMDAwMDowMDoxZC4w
OiBJbnRlbCBDb3JwLiA4MjgwMURCIChJQ0g0KSBVU0IgVUhDSSAjMQpQQ0k6IFNldHRpbmcgbGF0
ZW5jeSB0aW1lciBvZiBkZXZpY2UgMDAwMDowMDoxZC4wIHRvIDY0CnVoY2lfaGNkIDAwMDA6MDA6
MWQuMDogaXJxIDE2LCBpbyBiYXNlIDAwMDBkZjIwCnVoY2lfaGNkIDAwMDA6MDA6MWQuMDogbmV3
IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAyCmh1YiAyLTA6MS4wOiBV
U0IgaHViIGZvdW5kCmh1YiAyLTA6MS4wOiAyIHBvcnRzIGRldGVjdGVkCnVoY2lfaGNkIDAwMDA6
MDA6MWQuMTogSW50ZWwgQ29ycC4gODI4MDFEQiAoSUNINCkgVVNCIFVIQ0kgIzIKUENJOiBTZXR0
aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAwMDA6MDA6MWQuMSB0byA2NAp1aGNpX2hjZCAw
MDAwOjAwOjFkLjE6IGlycSAxOSwgaW8gYmFzZSAwMDAwZGY0MAp1aGNpX2hjZCAwMDAwOjAwOjFk
LjE6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMwpodWIgMy0w
OjEuMDogVVNCIGh1YiBmb3VuZApodWIgMy0wOjEuMDogMiBwb3J0cyBkZXRlY3RlZAp1aGNpX2hj
ZCAwMDAwOjAwOjFkLjI6IEludGVsIENvcnAuIDgyODAxREIgKElDSDQpIFVTQiBVSENJICMzClBD
STogU2V0dGluZyBsYXRlbmN5IHRpbWVyIG9mIGRldmljZSAwMDAwOjAwOjFkLjIgdG8gNjQKdWhj
aV9oY2QgMDAwMDowMDoxZC4yOiBpcnEgMTgsIGlvIGJhc2UgMDAwMGRmODAKdWhjaV9oY2QgMDAw
MDowMDoxZC4yOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDQK
aHViIDQtMDoxLjA6IFVTQiBodWIgZm91bmQKaHViIDQtMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQK
SW5pdGlhbGl6aW5nIFVTQiBNYXNzIFN0b3JhZ2UgZHJpdmVyLi4uCnVzYmNvcmU6IHJlZ2lzdGVy
ZWQgbmV3IGRyaXZlciB1c2Itc3RvcmFnZQpVU0IgTWFzcyBTdG9yYWdlIHN1cHBvcnQgcmVnaXN0
ZXJlZC4KZGV2aWNlLW1hcHBlcjogNC4xLjAtaW9jdGwgKDIwMDMtMTItMTApIGluaXRpYWxpc2Vk
OiBkbUB1ay5zaXN0aW5hLmNvbQpBZHZhbmNlZCBMaW51eCBTb3VuZCBBcmNoaXRlY3R1cmUgRHJp
dmVyIFZlcnNpb24gMS4wLjQgKE1vbiBNYXkgMTcgMTQ6MzE6NDQgMjAwNCBVVEMpLgpQQ0k6IEVu
YWJsaW5nIGRldmljZSAwMDAwOjAwOjFmLjUgKDAwMDUgLT4gMDAwNykKUENJOiBTZXR0aW5nIGxh
dGVuY3kgdGltZXIgb2YgZGV2aWNlIDAwMDA6MDA6MWYuNSB0byA2NAp1c2IgMS0xOiBuZXcgaGln
aCBzcGVlZCBVU0IgZGV2aWNlIHVzaW5nIGFkZHJlc3MgMgpzY3NpMCA6IFNDU0kgZW11bGF0aW9u
IGZvciBVU0IgTWFzcyBTdG9yYWdlIGRldmljZXMKICBWZW5kb3I6IE1heHRvciA2ICBNb2RlbDog
WTA4MEwwICAgICAgICAgICAgUmV2OiBZQVI0CiAgVHlwZTogICBEaXJlY3QtQWNjZXNzICAgICAg
ICAgICAgICAgICAgICAgIEFOU0kgU0NTSSByZXZpc2lvbjogMDIKU0NTSSBkZXZpY2Ugc2RhOiAx
NjAwODY1MjkgNTEyLWJ5dGUgaGR3ciBzZWN0b3JzICg4MTk2NCBNQikKc2RhOiBhc3N1bWluZyBk
cml2ZSBjYWNoZTogd3JpdGUgdGhyb3VnaAogc2RhOiBzZGExIHNkYTIKQXR0YWNoZWQgc2NzaSBk
aXNrIHNkYSBhdCBzY3NpMCwgY2hhbm5lbCAwLCBpZCAwLCBsdW4gMApVU0IgTWFzcyBTdG9yYWdl
IGRldmljZSBmb3VuZCBhdCAyCnVzYiAxLTQ6IG5ldyBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNp
bmcgYWRkcmVzcyAzCnNjc2kxIDogU0NTSSBlbXVsYXRpb24gZm9yIFVTQiBNYXNzIFN0b3JhZ2Ug
ZGV2aWNlcwogIFZlbmRvcjogR2VuZXJpYyAgIE1vZGVsOiBVU0IgRmxhc2ggRGlzayAgICBSZXY6
IDIuMDAKICBUeXBlOiAgIERpcmVjdC1BY2Nlc3MgICAgICAgICAgICAgICAgICAgICAgQU5TSSBT
Q1NJIHJldmlzaW9uOiAwMgppbnRlbDh4MF9tZWFzdXJlX2FjOTdfY2xvY2s6IG1lYXN1cmVkIDQ5
Mjk4IHVzZWNzCmludGVsOHgwOiBjbG9ja2luZyB0byA0ODAwMApBTFNBIGRldmljZSBsaXN0Ogog
ICMwOiBJbnRlbCA4MjgwMURCLUlDSDQgYXQgMHgxMDAwMDQwMCwgaXJxIDE3Ck5FVDogUmVnaXN0
ZXJlZCBwcm90b2NvbCBmYW1pbHkgMgpTQ1NJIGRldmljZSBzZGI6IDI1NTQ4OCA1MTItYnl0ZSBo
ZHdyIHNlY3RvcnMgKDEzMSBNQikKc2RiOiBhc3N1bWluZyBXcml0ZSBFbmFibGVkCnNkYjogYXNz
dW1pbmcgZHJpdmUgY2FjaGU6IHdyaXRlIHRocm91Z2gKIHNkYjogc2RiMQpBdHRhY2hlZCBzY3Np
IHJlbW92YWJsZSBkaXNrIHNkYiBhdCBzY3NpMSwgY2hhbm5lbCAwLCBpZCAwLCBsdW4gMApVU0Ig
TWFzcyBTdG9yYWdlIGRldmljZSBmb3VuZCBhdCAzCklQOiByb3V0aW5nIGNhY2hlIGhhc2ggdGFi
bGUgb2YgMjA0OCBidWNrZXRzLCAxNktieXRlcwpUQ1A6IEhhc2ggdGFibGVzIGNvbmZpZ3VyZWQg
KGVzdGFibGlzaGVkIDE2Mzg0IGJpbmQgMzI3NjgpCmlwX2Nvbm50cmFjayB2ZXJzaW9uIDIuMSAo
MTk4MiBidWNrZXRzLCAxNTg1NiBtYXgpIC0gMTYwIGJ5dGVzIHBlciBjb25udHJhY2sKaXBfdGFi
bGVzOiAoQykgMjAwMC0yMDAyIE5ldGZpbHRlciBjb3JlIHRlYW0KTkVUOiBSZWdpc3RlcmVkIHBy
b3RvY29sIGZhbWlseSAxCk5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTcKcDQtY2xv
Y2ttb2Q6IFA0L1hlb24oVE0pIENQVSBPbi1EZW1hbmQgQ2xvY2sgTW9kdWxhdGlvbiBhdmFpbGFi
bGUKQUNQSTogKHN1cHBvcnRzIFMwIFMzIFM0IFM1KQpSQU1ESVNLOiBleHQyIGZpbGVzeXN0ZW0g
Zm91bmQgYXQgYmxvY2sgMApSQU1ESVNLOiBMb2FkaW5nIDQwOTYgYmxvY2tzIFsxIGRpc2tdIGlu
dG8gcmFtIGRpc2suLi4gfAgvCC0IXAh8CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwI
LwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwILwgtCFwIfAgv
CC0IXAh8CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8CC8I
LQhcCHwILwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwILwgt
CFwIfAgvCC0IXAh8CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwILwgtCFwIfAgvCC0I
XAh8CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8CC8ILQhc
CHwILwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwILwgtCFwI
fAgvCC0IXAh8CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8
CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwILwgtCFwIfAgvCC0IXAh8CC8ILQhcCHwI
LwgtCFwIfAgvCC0IXAhkb25lLgpFWFQyLWZzIHdhcm5pbmc6IG1heGltYWwgbW91bnQgY291bnQg
cmVhY2hlZCwgcnVubmluZyBlMmZzY2sgaXMgcmVjb21tZW5kZWQKVkZTOiBNb3VudGVkIHJvb3Qg
KGV4dDIgZmlsZXN5c3RlbSkuCkZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDE1NmsgZnJl
ZWQKbG9vcDogbG9hZGVkIChtYXggOCBkZXZpY2VzKQp1c2IgMS00OiBVU0IgZGlzY29ubmVjdCwg
YWRkcmVzcyAzCkFkZGluZyA1MDYwMDhrIHN3YXAgb24gL2Rldi9tYXBwZXIvc3dhcGZzLiAgUHJp
b3JpdHk6LTEgZXh0ZW50czoxCm5hdHNlbWkgZHA4MzgxeCBkcml2ZXIsIHZlcnNpb24gMS4wNytM
SzEuMC4xNywgU2VwIDI3LCAyMDAyCiAgb3JpZ2luYWxseSBieSBEb25hbGQgQmVja2VyIDxiZWNr
ZXJAc2N5bGQuY29tPgogIGh0dHA6Ly93d3cuc2N5bGQuY29tL25ldHdvcmsvbmF0c2VtaS5odG1s
CiAgMi40Lngga2VybmVsIHBvcnQgYnkgSmVmZiBHYXJ6aWssIFRqZWVyZCBNdWxkZXIKZXRoMDog
TmF0U2VtaSBEUDgzODFbNTZdIGF0IDB4ZDAwYTMwMDAsIDAwOjAzOjBkOjA0OmQ0OmVjLCBJUlEg
MTcuCmV0aDA6IGxpbmsgdXAuCmV0aDA6IFNldHRpbmcgZnVsbC1kdXBsZXggYmFzZWQgb24gbmVn
b3RpYXRlZCBsaW5rIGNhcGFiaWxpdHkuCm10cnI6IGJhc2UoMHhkMDAyMDAwMCkgaXMgbm90IGFs
aWduZWQgb24gYSBzaXplKDB4MTgwMDAwKSBib3VuZGFyeQphdGtiZC5jOiBVbmtub3duIGtleSBw
cmVzc2VkICh0cmFuc2xhdGVkIHNldCAyLCBjb2RlIDB4MCBvbiBpc2EwMDYwL3NlcmlvMCkuCmF0
a2JkLmM6IFVzZSAnc2V0a2V5Y29kZXMgMDAgPGtleWNvZGU+JyB0byBtYWtlIGl0IGtub3duLgpw
c21vdXNlLmM6IFRvdWNoUGFkIGF0IGlzYTAwNjAvc2VyaW8yL2lucHV0MCBsb3N0IHN5bmNocm9u
aXphdGlvbiwgdGhyb3dpbmcgMSBieXRlcyBhd2F5Lgpwc21vdXNlLmM6IFRvdWNoUGFkIGF0IGlz
YTAwNjAvc2VyaW8yL2lucHV0MCBsb3N0IHN5bmMgYXQgYnl0ZSAxCnBzbW91c2UuYzogVG91Y2hQ
YWQgYXQgaXNhMDA2MC9zZXJpbzIvaW5wdXQwIGxvc3Qgc3luYyBhdCBieXRlIDEKcHNtb3VzZS5j
OiBUb3VjaFBhZCBhdCBpc2EwMDYwL3NlcmlvMi9pbnB1dDAgbG9zdCBzeW5jIGF0IGJ5dGUgMQpw
c21vdXNlLmM6IFRvdWNoUGFkIGF0IGlzYTAwNjAvc2VyaW8yL2lucHV0MCBsb3N0IHN5bmMgYXQg
Ynl0ZSAxCnBzbW91c2UuYzogVG91Y2hQYWQgYXQgaXNhMDA2MC9zZXJpbzIvaW5wdXQwIC0gZHJp
dmVyIHJlc3luY2hlZC4KdXNiIDEtNDogbmV3IGhpZ2ggc3BlZWQgVVNCIGRldmljZSB1c2luZyBh
ZGRyZXNzIDQKaHViIDEtNDoxLjA6IFVTQiBodWIgZm91bmQKaHViIDEtNDoxLjA6IDEgcG9ydCBk
ZXRlY3RlZAp1c2IgMS00LjE6IG5ldyBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgYWRkcmVz
cyA1CnNjc2kyIDogU0NTSSBlbXVsYXRpb24gZm9yIFVTQiBNYXNzIFN0b3JhZ2UgZGV2aWNlcwog
IFZlbmRvcjogUHJvbGlmaWMgIE1vZGVsOiBVU0IgRmxhc2ggRGlzayAgICBSZXY6IFAxLjAKICBU
eXBlOiAgIERpcmVjdC1BY2Nlc3MgICAgICAgICAgICAgICAgICAgICAgQU5TSSBTQ1NJIHJldmlz
aW9uOiAwMgpTQ1NJIGRldmljZSBzZGI6IDI1NjAwMCA1MTItYnl0ZSBoZHdyIHNlY3RvcnMgKDEz
MSBNQikKc2RiOiBhc3N1bWluZyBXcml0ZSBFbmFibGVkCnNkYjogYXNzdW1pbmcgZHJpdmUgY2Fj
aGU6IHdyaXRlIHRocm91Z2gKIHNkYjogc2RiMQpBdHRhY2hlZCBzY3NpIHJlbW92YWJsZSBkaXNr
IHNkYiBhdCBzY3NpMiwgY2hhbm5lbCAwLCBpZCAwLCBsdW4gMApVU0IgTWFzcyBTdG9yYWdlIGRl
dmljZSBmb3VuZCBhdCA1CnVzYiAxLTQ6IFVTQiBkaXNjb25uZWN0LCBhZGRyZXNzIDQKdXNiIDEt
NC4xOiBVU0IgZGlzY29ubmVjdCwgYWRkcmVzcyA1Cg==

--Multipart=_Mon__12_Jul_2004_22_49_31_+0100_m9JmNVWU3ORHU.od--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
