From: Alfonso =?ISO-8859-1?Q?Mu=F1oz-Pomer?= Fuentes <etinarcadiaego-pCzzcW6XgXY@public.gmane.org>
Subject: Bug: Processor support interfering with /dev/eth0
Date: 05 Jun 2003 00:31:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1054765900.452.24.camel@roamer>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-VZDPX4RF+5WCskc6qWQS"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


--=-VZDPX4RF+5WCskc6qWQS
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I'm forwarding this message that I sent to acpi-sppt because I believe
it's a bug. Feedback greatly appreciated.

TIA.

--=20
Alfonso Mu=F1oz-Pomer Fuentes <etinarcadiaego-pCzzcW6XgXY@public.gmane.org>

--=-VZDPX4RF+5WCskc6qWQS
Content-Disposition: inline
Content-Description: Forwarded message - Processor support interfering with
	/dev/eth0
Content-Type: message/rfc822

Subject: Processor support interfering with /dev/eth0
From: Alfonso =?ISO-8859-1?Q?Mu=F1oz-Pomer?= Fuentes <etinarcadiaego-pCzzcW6XgXY@public.gmane.org>
To: acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Content-Type: multipart/mixed; boundary="=-7zLwB/dcBkcVQRmS37m3"
Organization: 
Message-Id: <1054408235.25797.29.camel@roamer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 May 2003 21:10:36 +0200


--=-7zLwB/dcBkcVQRmS37m3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi, I'm not sure if this has been noticed by any users or not. I don't
think so because I did a lot of Googling some months ago and I've been
also searching thoroughly through the mailing list archives to no avail.

I have a Toshiba DynaBook V4/493PMHW laptop (lspci -vvxxx output
attached) and when I compile ACPI with 'Processor support' (either with
or without 'Thermal zone'), when my computer serves data through my
ethernet card (a Realtek 8139) I get the following error (extracted from
/var/log/syslog):

May 31 01:35:33 roamer kernel: NETDEV WATCHDOG: eth0: transmit timed out
May 31 01:35:33 roamer kernel: eth0: Tx queue start entry 48  dirty
entry 44.
May 31 01:35:33 roamer kernel: eth0:  Tx descriptor 0 is 00002000.
(queue head)
May 31 01:35:33 roamer kernel: eth0:  Tx descriptor 1 is 00002000.
May 31 01:35:33 roamer kernel: eth0:  Tx descriptor 2 is 00002000.
May 31 01:35:33 roamer kernel: eth0:  Tx descriptor 3 is 00002000.
May 31 01:35:33 roamer kernel: eth0: Setting half-duplex based on
auto-negotiated partner ability 0000.

This doesn't happen with outbound connections, only when I act as a
server. I guess it occurs when I have to send a lot of data. But just
doing a ssh to my computer from another one and leaving a key pressed
for a couple of lines will cause this. The communication is interrupted
for maybe 10 seconds until /dev/eth0 comes up again (last line of the
log). When I act as an ftp/scp server after some 5-10MB of data (maybe
less) it comes to a stall.

The second line can vary with dirty entries in the 80s or 100s, but
always the first one is 4 numbers greater than the previous one, e.g.:
May 31 01:35:33 roamer kernel: eth0: Tx queue start entry 86  dirty
entry 82.

When I disable 'Processor support' under ACPI this doesn't happen at
all. I had this problem with 2.4.19 and now again with 2.4.20 so I
suppose it went unnoticed. Is this a bug? Should I send it to the devel
list?

Any help greatly appreciated. TIA.

--=20
Alfonso Mu=F1oz-Pomer Fuentes <etinarcadiaego-pCzzcW6XgXY@public.gmane.org>

--=-7zLwB/dcBkcVQRmS37m3
Content-Disposition: attachment; filename=lspci_output
Content-Type: text/plain; name=lspci_output; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1644 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [b0] AGP version 2.0
		Status: RQ=27 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [a4] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 44 16 07 00 10 a2 01 00 00 06 00 00 00 00
10: 08 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00
40: 1c 2f 0d 00 3b 10 04 09 00 20 2c 45 00 20 20 00
50: 00 00 00 00 3b 10 04 2f 00 30 00 00 00 20 20 ff
60: 82 cc 00 00 00 00 00 00 6f 80 02 91 40 04 19 05
70: 8c 8c 00 00 00 00 80 00 40 a2 96 17 00 10 03 03
80: 00 00 53 b7 31 88 8f f0 20 02 c0 08 80 00 78 00
90: 15 00 f5 49 00 00 00 00 08 00 00 00 f8 fe 00 00
a0: 5c ef 01 00 01 00 01 00 00 00 00 00 00 00 00 00
b0: 02 a4 20 00 07 02 00 1b 00 00 00 00 08 00 f2 0e
c0: 00 00 13 10 00 00 00 f0 c0 68 00 c0 00 00 00 00
d0: ff d0 65 bd 00 70 5b 1e 00 00 00 80 81 81 83 00
e0: 00 60 20 00 00 00 b8 40 00 00 08 00 00 00 28 31
f0: 00 80 00 2d 80 07 80 07 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: f7f00000-fdffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
00: b9 10 47 52 07 00 00 04 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 a2
20: f0 f7 f0 fd f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f7eff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 07 00 90 02 03 10 03 0c 08 40 00 00
10: 00 f0 ef f7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 04 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 50
40: 00 00 1f 04 02 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 c0 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) (prog-if f0)
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at eff0 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 29 52 05 00 90 02 c3 f0 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: f1 ef 00 00 00 00 00 00 00 00 00 00 79 11 04 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 ff 01 02 04
40: 06 00 00 7f 00 00 00 00 00 02 23 c9 00 80 ba 1a
50: 03 00 00 89 05 01 0a 0a 01 31 31 00 01 31 31 00
60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI South Bridge Audio (rev 01)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 51 54 07 00 90 c2 01 00 01 04 00 40 00 00
10: 01 10 00 00 00 00 00 10 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 01 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 ff 01 02 18
40: 00 00 00 00 00 00 0a e2 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 e6
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 04 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 01 12 0b c0 1d 00 00 07 39 67 00 90 00 00 ed 03
50: 00 00 00 00 70 00 02 00 7c 00 00 00 00 00 00 00
60: 78 01 00 80 00 00 00 00 00 00 00 00 00 64 00 00
70: 91 00 2f 00 05 9f 81 40 aa 42 81 20 31 00 00 11
80: 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 80 72 e1 06 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 01 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 40 08 00 00 00 25 01 0c 80 08 00 00 00 00 13
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 08 13 77 10 f0 bf 06 10 00
80: 36 82 1a 13 00 00 00 00 0c 02 02 00 00 00 00 44
90: 00 aa 00 00 00 00 00 cf f0 ff 08 08 08 00 00 00
a0: 00 00 00 00 00 00 00 28 00 00 b2 00 00 00 5c ef
b0: 00 8c 00 1c 00 cf 63 00 68 04 00 00 00 00 00 80
c0: 1a 10 7f 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 46 40 00 00 00 02 00 00 00 00 00 0c 00 00 00
e0: 00 ee 00 ef 01 00 01 00 00 00 00 00 00 00 00 00
f0: 01 00 20 7e 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at ed00 [size=256]
	Region 1: Memory at f7efef00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 40 00 00
10: 01 ed 00 00 00 ef ef f7 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 01 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 07 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8023 (prog-if 10 [OHCI])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [disabled] [size=2K]
	Region 1: Memory at 10004000 (32-bit, non-prefetchable) [disabled] [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D3 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 23 80 00 00 10 02 00 10 00 0c 08 40 00 00
10: 00 10 00 10 00 40 00 10 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 01 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 01 02 04
40: 00 00 00 00 01 00 42 fe 03 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00
f0: 10 80 00 00 82 00 00 00 79 11 01 00 00 00 00 00

00:10.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Lucent Technologies: Unknown device ab01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 6
	Region 0: Memory at 10002000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 50 ac 07 00 10 02 01 00 07 06 08 a8 02 00
10: 00 20 00 10 a0 00 00 02 00 02 02 b0 00 00 40 10
20: 00 f0 7f 10 00 00 80 10 00 f0 bf 10 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 ff 01 c0 05
40: a3 12 01 ab 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 90 44 00 00 00 00 00 00 00 00 00 02 00 00 01
90: c0 00 60 61 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 0e 08 00 00 1b 00 00 00
b0: 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 33)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10003000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 79 11 17 06 07 00 90 04 33 00 07 06 00 a8 02 00
10: 00 30 00 10 80 00 80 04 00 03 03 00 00 00 c0 10
20: 00 f0 ff 10 00 00 00 11 00 f0 3f 11 00 48 00 00
30: fc 48 00 00 00 4c 00 00 fc 4c 00 00 ff 01 80 05
40: 79 11 01 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 11 fe 00 00 80 00 00 00 00 00 00 00 00 01
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: d0 10 00 86 00 00 00 0c 00 00 00 00 00 d1 00 00
b0: cf 3f 3f 3f 20 10 08 0a 00 01 01 14 00 3f 42 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00

00:12.0 System peripheral: Toshiba America Info Systems: Unknown device 0805 (rev 05)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10001800 (32-bit, non-prefetchable) [disabled] [size=512]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D3 PME-Enable- DSel=0 DScale=0 PME-
00: 79 11 05 08 00 00 10 02 05 00 80 08 00 00 00 00
10: 00 18 00 10 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 01 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 01 00 00
40: 00 00 00 00 7f 77 00 00 00 00 00 00 02 00 00 00
50: 01 00 00 00 00 00 00 00 02 03 00 00 00 00 00 00
60: 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 fe 03 00 00 00 02 02 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 ff 00 00 00 01 00 00 00 00 00 00

01:00.0 VGA compatible controller: Trident Microsystems: Unknown device 8820 (rev 82) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8
	Interrupt: pin A routed to IRQ 6
	Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at fbc00000 (32-bit, non-prefetchable) [size=4M]
	Region 2: Memory at f8000000 (32-bit, non-prefetchable) [size=32M]
	Region 3: Memory at f7ff8000 (32-bit, non-prefetchable) [size=32K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [80] AGP version 2.0
		Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [90] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 23 10 20 88 07 00 30 02 82 00 00 03 00 08 00 00
10: 00 00 00 fc 00 00 c0 fb 00 00 00 f8 00 80 ff f7
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 01 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 06 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 02 90 20 00 07 02 00 20 00 00 00 00 00 00 00 00
90: 01 00 22 06 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--=-7zLwB/dcBkcVQRmS37m3--


--=-VZDPX4RF+5WCskc6qWQS--



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
