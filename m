From: Martin Mokrejs <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
Subject: linux-3.7.10: 'nousb' causes repeated PME# enabled/disabled messages
 when 'pcie_aspm=off' and causes only partial acpiphp hotplug detection
Date: Tue, 12 Mar 2013 12:57:29 +0100
Message-ID: <513F1829.7080101@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020504020802030908070901"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020504020802030908070901
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
  I booted same kernel under same BIOS settings with the only difference that
in the latter case I added 'nousb'. While inspecting the diffs in dmesg outputs
I see that something is happening with my network card and 

+r8169 0000:05:00.0: PME# disabled
+r8169 0000:05:00.0: PME# enabled
+r8169 0000:05:00.0: PME# disabled

but also with SandyBridge PCI Express Root Port 5

+pcieport 0000:00:1c.4: PME# enabled
+pcieport 0000:00:1c.4: PME# disabled
+pcieport 0000:00:1c.4: PME# enabled
+pcieport 0000:00:1c.4: PME# disabled
+pcieport 0000:00:1c.4: PME# enabled
+pcieport 0000:00:1c.4: PME# disabled
+pcieport 0000:00:1c.4: PME# enabled
+pcieport 0000:00:1c.4: PME# disabled
+pcieport 0000:00:1c.4: PME# enabled
+pcieport 0000:00:1c.4: PME# disabled
+pcieport 0000:00:1c.4: PME# enabled
+pcieport 0000:00:1c.4: PME# disabled

The pcieport messages are repeating every second, until forever, funny. This is probably related
to the 'pcie_aspm=off' on kernel commandline, but so far it was necessary to get acpiphp working
on kernels above 3.5.


Could that be related some udev or other userspace tool misbehaving when
there is no USB available? Or is that a purely kernel driver issue?



00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 5 (rev b5) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=0b, subordinate=0c, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f7d00000-f7dfffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
20: d0 f7 d0 f7 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 10 00
40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 05
50: 42 00 12 f0 00 b2 24 00 00 00 40 01 00 00 00 00
60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00
e0: 00 3f 00 00 00 00 00 00 01 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00


Although per dmesg the PME# changes happened every second, I managed to catch the
following difference by lspci only twice or three time sonly. But hope this is what
the dmesg line is about. The funny thing is that this PME# game is ongoing whether
the express slot is occupied by a card or not. Well, it is about the root port, so why
not? ;-)
Initially I cold-booted with a card inserted into the slot but some driver did not
realize the card is ejected. But per lspci I can confirm the device 11.00.0 was
recognized as removed from the slot. But why is the 00.1c.4 being modified I do not
know.

Below is the PME# change bacjk and forth immediately.

--- lspci_loop.23:45:01 2013-03-11 23:45:01.000000000 +0100
+++ lspci_loop.23:45:02 2013-03-11 23:45:02.000000000 +0100
@@ -410,7 +410,7 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
+               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
@@ -422,7 +422,7 @@
 70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00
--- lspci_loop.23:45:02 2013-03-11 23:45:02.000000000 +0100
+++ lspci_loop.23:45:03 2013-03-11 23:45:03.000000000 +0100
@@ -410,7 +410,7 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
+               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
@@ -422,7 +422,7 @@
 70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00


and more than a minute later another example


# diff -u -w lspci_loop.23:46:44 lspci_loop.23:46:45
--- lspci_loop.23:46:44 2013-03-11 23:46:44.000000000 +0100
+++ lspci_loop.23:46:45 2013-03-11 23:46:45.000000000 +0100
@@ -410,7 +410,7 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
+               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
@@ -422,7 +422,7 @@
 70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00
# diff -u -w lspci_loop.23:46:45 lspci_loop.23:46:46
--- lspci_loop.23:46:45 2013-03-11 23:46:45.000000000 +0100
+++ lspci_loop.23:46:46 2013-03-11 23:46:46.000000000 +0100
@@ -410,7 +410,7 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
+               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
@@ -422,7 +422,7 @@
 70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00


The first pair of PME changes happened while the Firewire card was still cold-plugged in
the slot. The latter happened when the card was inserted back into the slot
but that has been only partially noticed by pcihp hotplug (read further below). Under
this BIOS+'nousb' setup the *acpiphp* hotplug does not work with this particular Firewire
OHCI card, or really badly.


Lets abstract away from the above PME# stuff and see how the system behaved during
eject of the cold-plugged card and what a partial detection happened on its later
hotplug insert, eject, insert. I will show intereleaved in the text the slot status
numbers as reported by lspci whenever they changed. The command is:

while true; do echo -n "$(date +%T) SlotStatus "; setpci -s1c.7 0x5a.w; sleep 1; done


23:45:21 SlotStatus 0040
23:45:22 SlotStatus 0040
23:45:23 SlotStatus 0040
23:45:25 SlotStatus 0040
23:45:26 SlotStatus 0040
23:45:27 SlotStatus 0040
23:45:28 SlotStatus 0108
23:45:29 SlotStatus 0100
23:45:30 SlotStatus 0100
23:45:31 SlotStatus 0100
23:45:32 SlotStatus 0100

--- lspci_loop.23:45:27 2013-03-11 23:45:27.000000000 +0100
+++ lspci_loop.23:45:28 2013-03-11 23:45:28.000000000 +0100
@@ -437,7 +437,7 @@
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
@@ -446,18 +446,18 @@
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
-               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
+               DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
-                       Changed: MRL- PresDet- LinkState-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
+                       Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -473,19 +473,19 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
+               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
-10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
+10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
-40: 10 80 42 01 00 80 00 00 00 00 10 00 12 4c 12 08
-50: 00 00 11 70 60 b2 3c 00 00 00 40 00 00 00 00 00
+40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
+50: 00 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
@@ -793,56 +793,3 @@
 e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
-11:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6315 Series Firewire Controller (rev 01) (prog-if 10 [OHCI])
-       Subsystem: VIA Technologies, Inc. VT6315 Series Firewire Controller
-       Physical Slot: 1
-       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
-       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-       Latency: 0, Cache Line Size: 64 bytes
-       Interrupt: pin A routed to IRQ 19
-       Region 0: Memory at f6c00000 (64-bit, non-prefetchable) [size=2K]
-       Region 2: I/O ports at c000 [size=256]
-       Capabilities: [50] Power Management version 3
-               Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
-       Capabilities: [80] MSI: Enable- Count=1/1 Maskable+ 64bit+
-               Address: 0000000000000000  Data: 0000
-               Masking: 00000000  Pending: 00000000
-       Capabilities: [98] Express (v1) Endpoint, MSI 00
-               DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
-                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
-               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
-                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
-                       MaxPayload 128 bytes, MaxReadReq 512 bytes
-               DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
-               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <64us
-                       ClockPM+ Surprise- LLActRep- BwNot-
-               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
-                       ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
-       Capabilities: [100 v1] Advanced Error Reporting
-               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
-               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
-               UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
-               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
-               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
-       Capabilities: [130 v1] Device Serial Number 00-11-06-ff-ff-00-00-03
-       Kernel driver in use: firewire_ohci
-00: 06 11 03 34 07 00 10 00 01 10 00 0c 10 00 00 00
-10: 04 00 c0 f6 00 00 00 00 01 c0 00 00 00 00 00 00
-20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 03 34
-30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00
-40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-50: 01 80 03 e4 00 00 00 00 00 00 00 00 00 00 00 00
-60: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
-70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-80: 05 98 80 01 00 00 00 00 00 00 00 00 00 00 00 00
-90: 00 00 00 00 00 00 00 00 10 00 01 00 00 80 90 05
-a0: 00 20 19 00 11 4c 07 00 00 01 11 00 00 00 00 00
-b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Likely a partially detected hotplug insert of the card:

23:45:50 SlotStatus 0100
23:45:51 SlotStatus 0100
23:45:52 SlotStatus 0100
23:45:53 SlotStatus 0100
23:45:55 SlotStatus 0148
23:45:56 SlotStatus 0140
23:45:57 SlotStatus 0140
23:45:58 SlotStatus 0140


--- lspci_loop.23:45:53 2013-03-11 23:45:55.000000000 +0100
+++ lspci_loop.23:45:56 2013-03-11 23:45:56.000000000 +0100
@@ -410,7 +410,7 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
+               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
@@ -422,7 +422,7 @@
 70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00
@@ -449,14 +449,14 @@
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
-               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
+               LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
@@ -480,7 +480,7 @@
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
-50: 00 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
+50: 03 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
--- lspci_loop.23:45:56 2013-03-11 23:45:56.000000000 +0100
+++ lspci_loop.23:45:57 2013-03-11 23:45:57.000000000 +0100
@@ -410,7 +410,7 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
+               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
@@ -422,7 +422,7 @@
 70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00


Similarly, a partially detected eject of the card:

23:46:13 SlotStatus 0140
23:46:14 SlotStatus 0140
23:46:15 SlotStatus 0140
23:46:16 SlotStatus 0100
23:46:17 SlotStatus 0100
23:46:18 SlotStatus 0100


--- lspci_loop.23:46:15 2013-03-11 23:46:15.000000000 +0100
+++ lspci_loop.23:46:16 2013-03-11 23:46:16.000000000 +0100
@@ -449,14 +449,14 @@
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
-               LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
+               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
@@ -480,7 +480,7 @@
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
-50: 03 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
+50: 02 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Again, a partially detect hotplug insert:

23:46:25 SlotStatus 0100
23:46:26 SlotStatus 0100
23:46:27 SlotStatus 0100
23:46:29 SlotStatus 0148
23:46:31 SlotStatus 0140
23:46:32 SlotStatus 0140
23:46:33 SlotStatus 0140


--- lspci_loop.23:46:27 2013-03-11 23:46:27.000000000 +0100
+++ lspci_loop.23:46:29 2013-03-11 23:46:30.000000000 +0100
@@ -449,15 +449,15 @@
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
-               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
+               LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
-                       Changed: MRL- PresDet- LinkState+
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
+                       Changed: MRL- PresDet+ LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -480,7 +480,7 @@
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
-50: 02 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
+50: 03 00 11 70 60 b2 3c 00 00 00 48 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -488,7 +488,7 @@
 a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
+d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 40
 e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
--- lspci_loop.23:46:29 2013-03-11 23:46:30.000000000 +0100
+++ lspci_loop.23:46:31 2013-03-11 23:46:31.000000000 +0100
@@ -457,7 +457,7 @@
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
-                       Changed: MRL- PresDet+ LinkState+
+                       Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -480,7 +480,7 @@
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
-50: 03 00 11 70 60 b2 3c 00 00 00 48 01 00 00 00 00
+50: 03 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -488,7 +488,7 @@
 a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 40
+d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
 e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00


Finally, the PME# game again:
--- lspci_loop.23:46:44 2013-03-11 23:46:44.000000000 +0100
+++ lspci_loop.23:46:45 2013-03-11 23:46:45.000000000 +0100
@@ -410,7 +410,7 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
+               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
@@ -422,7 +422,7 @@
 70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00
--- lspci_loop.23:46:45 2013-03-11 23:46:45.000000000 +0100
+++ lspci_loop.23:46:46 2013-03-11 23:46:46.000000000 +0100
@@ -410,7 +410,7 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
+               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
@@ -422,7 +422,7 @@
 70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00



Further details can be found by comparing these two directories:

Firewire_coldplug_disabled_Media_card_reader/
Firewire_coldplug_disabled_Media_card_reader_nousb/

Fetch them from http://195.113.57.32/~mmokrejs/tmp/3.7.10_acpiphp_pcie_aspm_off_full.tar.bz2
(1.2MB but covers in additional sub-directories also other cards tested)

--------------020504020802030908070901
Content-Type: text/plain; charset=us-ascii;
 name="dmesg_Firewire_coldplug_disabled_Media_card_reader__usb__vs_nousb.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="dmesg_Firewire_coldplug_disabled_Media_card_reader__usb__vs_";
 filename*1="nousb.txt"

LS0tIC90bXAvZG1lc2dfRmlyZXdpcmVfY29sZHBsdWdfZGlzYWJsZWRfTWVkaWFfY2FyZF9y
ZWFkZXIudHh0CTIwMTMtMDMtMTIgMTE6NDY6MjguMDAwMDAwMDAwICswMTAwCisrKyAvdG1w
L2RtZXNnX0ZpcmV3aXJlX2NvbGRwbHVnX2Rpc2FibGVkX01lZGlhX2NhcmRfcmVhZGVyX25v
dXNiLnR4dAkyMDEzLTAzLTEyIDExOjQ2OjE2LjAwMDAwMDAwMCArMDEwMApAQCAtMSw1ICsx
LDUgQEAKIExpbnV4IHZlcnNpb24gMy43LjEwLWRlZmF1bHQgKHJvb3RAdm9zdHJvKSAoZ2Nj
IHZlcnNpb24gNC42LjMgKEdlbnRvbyA0LjYuMyBwMS44LCBwaWUtMC41LjIpICkgIzIgU01Q
IFR1ZSBNYXIgNSAwOTo1MjoxMiBNRVQgMjAxMwotQ29tbWFuZCBsaW5lOiByb290PS9kZXYv
c2RhNSBwY2llaHAucGNpZWhwX2RlYnVnPTEgc2x1Yl9kZWJ1Zz1BRlBaIHBjaWVfYXNwbT1v
ZmYKK0NvbW1hbmQgbGluZTogcm9vdD0vZGV2L3NkYTUgcGNpZWhwLnBjaWVocF9kZWJ1Zz0x
IHNsdWJfZGVidWc9QUZQWiBwY2llX2FzcG09b2ZmIG5vdXNiCiBlODIwOiBCSU9TLXByb3Zp
ZGVkIHBoeXNpY2FsIFJBTSBtYXA6CiBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMDAw
MDAwLTB4MDAwMDAwMDAwMDA5ZDNmZl0gdXNhYmxlCiBCSU9TLWU4MjA6IFttZW0gMHgwMDAw
MDAwMDAwMDlkNDAwLTB4MDAwMDAwMDAwMDA5ZmZmZl0gcmVzZXJ2ZWQKQEAgLTE1Niw3ICsx
NTYsNyBAQAogcGNwdS1hbGxvYzogWzBdIDAgMSAKIEJ1aWx0IDEgem9uZWxpc3RzIGluIFpv
bmUgb3JkZXIsIG1vYmlsaXR5IGdyb3VwaW5nIG9uLiAgVG90YWwgcGFnZXM6IDQxMDI1MjIK
IFBvbGljeSB6b25lOiBOb3JtYWwKLUtlcm5lbCBjb21tYW5kIGxpbmU6IHJvb3Q9L2Rldi9z
ZGE1IHBjaWVocC5wY2llaHBfZGVidWc9MSBzbHViX2RlYnVnPUFGUFogcGNpZV9hc3BtPW9m
ZgorS2VybmVsIGNvbW1hbmQgbGluZTogcm9vdD0vZGV2L3NkYTUgcGNpZWhwLnBjaWVocF9k
ZWJ1Zz0xIHNsdWJfZGVidWc9QUZQWiBwY2llX2FzcG09b2ZmIG5vdXNiCiBQQ0llIEFTUE0g
aXMgZGlzYWJsZWQKIFBJRCBoYXNoIHRhYmxlIGVudHJpZXM6IDQwOTYgKG9yZGVyOiAzLCAz
Mjc2OCBieXRlcykKIF9fZXhfdGFibGUgYWxyZWFkeSBzb3J0ZWQsIHNraXBwaW5nIHNvcnQK
QEAgLTE4Myw4ICsxODMsOCBAQAogIHBlciB0YXNrLXN0cnVjdCBtZW1vcnkgZm9vdHByaW50
OiAxOTIwIGJ5dGVzCiBocGV0IGNsb2NrZXZlbnQgcmVnaXN0ZXJlZAogdHNjOiBGYXN0IFRT
QyBjYWxpYnJhdGlvbiB1c2luZyBQSVQKLXRzYzogRGV0ZWN0ZWQgMjc5My42NTggTUh6IHBy
b2Nlc3NvcgotQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcCAoc2tpcHBlZCksIHZhbHVlIGNhbGN1
bGF0ZWQgdXNpbmcgdGltZXIgZnJlcXVlbmN5Li4gNTU4Ny4zMSBCb2dvTUlQUyAobHBqPTI3
OTM2NTgwKQordHNjOiBEZXRlY3RlZCAyNzkzLjYzNSBNSHogcHJvY2Vzc29yCitDYWxpYnJh
dGluZyBkZWxheSBsb29wIChza2lwcGVkKSwgdmFsdWUgY2FsY3VsYXRlZCB1c2luZyB0aW1l
ciBmcmVxdWVuY3kuLiA1NTg3LjI3IEJvZ29NSVBTIChscGo9Mjc5MzYzNTApCiBwaWRfbWF4
OiBkZWZhdWx0OiAzMjc2OCBtaW5pbXVtOiAzMDEKIERlbnRyeSBjYWNoZSBoYXNoIHRhYmxl
IGVudHJpZXM6IDIwOTcxNTIgKG9yZGVyOiAxMiwgMTY3NzcyMTYgYnl0ZXMpCiBJbm9kZS1j
YWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDEwNDg1NzYgKG9yZGVyOiAxMSwgODM4ODYwOCBi
eXRlcykKQEAgLTIxNSwxMyArMjE1LDEzIEBACiBTTVAgYWx0ZXJuYXRpdmVzOiBsb2NrZGVw
OiBmaXhpbmcgdXAgYWx0ZXJuYXRpdmVzCiBzbXBib290OiBCb290aW5nIE5vZGUgICAwLCBQ
cm9jZXNzb3JzICAjMSBPSwogQnJvdWdodCB1cCAyIENQVXMKLXNtcGJvb3Q6IFRvdGFsIG9m
IDIgcHJvY2Vzc29ycyBhY3RpdmF0ZWQgKDExMTc0LjYzIEJvZ29NSVBTKQorc21wYm9vdDog
VG90YWwgb2YgMiBwcm9jZXNzb3JzIGFjdGl2YXRlZCAoMTExNzQuNTQgQm9nb01JUFMpCiBO
TUkgd2F0Y2hkb2c6IGVuYWJsZWQgb24gYWxsIENQVXMsIHBlcm1hbmVudGx5IGNvbnN1bWVz
IG9uZSBody1QTVUgY291bnRlci4KIGRldnRtcGZzOiBpbml0aWFsaXplZAogUE06IFJlZ2lz
dGVyaW5nIEFDUEkgTlZTIHJlZ2lvbiBbbWVtIDB4ZGE0ZTUwMDAtMHhkYTUyN2ZmZl0gKDI3
NDQzMiBieXRlcykKIFBNOiBSZWdpc3RlcmluZyBBQ1BJIE5WUyByZWdpb24gW21lbSAweGRh
ZDY4MDAwLTB4ZGFmZTdmZmZdICgyNjIxNDQwIGJ5dGVzKQogeG9yOiBhdXRvbWF0aWNhbGx5
IHVzaW5nIGJlc3QgY2hlY2tzdW1taW5nIGZ1bmN0aW9uOgotICAgYXZ4ICAgICAgIDogMTk1
NTMuNjAwIE1CL3NlYworICAgYXZ4ICAgICAgIDogMTk1NTUuMjAwIE1CL3NlYwogcmVndWxh
dG9yLWR1bW15OiBubyBwYXJhbWV0ZXJzCiBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFt
aWx5IDE2CiBBQ1BJOiBidXMgdHlwZSBwY2kgcmVnaXN0ZXJlZApAQCAtMjMwLDggKzIzMCw4
IEBACiBQQ0k6IE1NQ09ORklHIGF0IFttZW0gMHhmODAwMDAwMC0weGZiZmZmZmZmXSByZXNl
cnZlZCBpbiBFODIwCiBQQ0k6IFVzaW5nIGNvbmZpZ3VyYXRpb24gdHlwZSAxIGZvciBiYXNl
IGFjY2VzcwogYmlvOiBjcmVhdGUgc2xhYiA8YmlvLTA+IGF0IDAKLXJhaWQ2OiBzc2UyeDEg
ICAgNzU2MSBNQi9zCi1yYWlkNjogc3NlMngyICAgIDkzNDYgTUIvcworcmFpZDY6IHNzZTJ4
MSAgICA3NTU5IE1CL3MKK3JhaWQ2OiBzc2UyeDIgICAgOTM0NSBNQi9zCiByYWlkNjogc3Nl
Mng0ICAgMTA3OTYgTUIvcwogcmFpZDY6IHVzaW5nIGFsZ29yaXRobSBzc2UyeDQgKDEwNzk2
IE1CL3MpCiByYWlkNjogdXNpbmcgc3NzZTN4MiByZWNvdmVyeSBhbGdvcml0aG0KQEAgLTQw
OCwxMCArNDA4LDcgQEAKIFNDU0kgc3Vic3lzdGVtIGluaXRpYWxpemVkCiBBQ1BJOiBidXMg
dHlwZSBzY3NpIHJlZ2lzdGVyZWQKIGxpYmF0YSB2ZXJzaW9uIDMuMDAgbG9hZGVkLgotQUNQ
STogYnVzIHR5cGUgdXNiIHJlZ2lzdGVyZWQKLXVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGlu
dGVyZmFjZSBkcml2ZXIgdXNiZnMKLXVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFj
ZSBkcml2ZXIgaHViCi11c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBkZXZpY2UgZHJpdmVyIHVz
YgordXNiY29yZTogVVNCIHN1cHBvcnQgZGlzYWJsZWQKIG1lZGlhOiBMaW51eCBtZWRpYSBp
bnRlcmZhY2U6IHYwLjEwCiBMaW51eCB2aWRlbyBjYXB0dXJlIGludGVyZmFjZTogdjIuMDAK
IHdtaTogTWFwcGVyIGxvYWRlZApAQCAtNjQwLDcgKzYzNyw3IEBACiBtaWNyb2NvZGU6IE1p
Y3JvY29kZSBVcGRhdGUgRHJpdmVyOiB2Mi4wMCA8dGlncmFuQGFpdmF6aWFuLmZzbmV0LmNv
LnVrPiwgUGV0ZXIgT3J1YmEKIHNoYTFfc3NzZTM6IFVzaW5nIEFWWCBvcHRpbWl6ZWQgU0hB
LTEgaW1wbGVtZW50YXRpb24KIGF1ZGl0OiBpbml0aWFsaXppbmcgbmV0bGluayBzb2NrZXQg
KGRpc2FibGVkKQotdHlwZT0yMDAwIGF1ZGl0KDEzNjMwNDQ5MzEuMjAwOjEpOiBpbml0aWFs
aXplZAordHlwZT0yMDAwIGF1ZGl0KDEzNjMwNDUzMTUuMTYwOjEpOiBpbml0aWFsaXplZAog
SHVnZVRMQiByZWdpc3RlcmVkIDIgTUIgcGFnZSBzaXplLCBwcmUtYWxsb2NhdGVkIDAgcGFn
ZXMKIERMTSBpbnN0YWxsZWQKIG1zZ21uaSBoYXMgYmVlbiBzZXQgdG8gMzE4OTIKQEAgLTcx
NCwxNTIgKzcxMSwxMSBAQAogcjgxNjkgMDAwMDowNTowMC4wIGV0aDA6IFJUTDgxNjhlLzgx
MTFlIGF0IDB4ZmZmZmM5MDAwMTg0YTAwMCwgMTg6MDM6NzM6YTA6NmY6NmEsIFhJRCAwYzIw
MDAwMCBJUlEgNDEKIHI4MTY5IDAwMDA6MDU6MDAuMCBldGgwOiBqdW1ibyBmZWF0dXJlcyBb
ZnJhbWVzOiA5MjAwIGJ5dGVzLCB0eCBjaGVja3N1bW1pbmc6IGtvXQogVk13YXJlIHZteG5l
dDMgdmlydHVhbCBOSUMgZHJpdmVyIC0gdmVyc2lvbiAxLjEuMjkuMC1rLU5BUEkKLWVoY2lf
aGNkOiBVU0IgMi4wICdFbmhhbmNlZCcgSG9zdCBDb250cm9sbGVyIChFSENJKSBEcml2ZXIK
LWVoY2lfaGNkOiBibG9jayBzaXplczogcWggMTA0IHF0ZCA5NiBpdGQgMTkyIHNpdGQgOTYK
LWVoY2lfaGNkIDAwMDA6MDA6MWEuMDogZW5hYmxpbmcgYnVzIG1hc3RlcmluZwotZWhjaV9o
Y2QgMDAwMDowMDoxYS4wOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKLWVoY2lfaGNk
IDAwMDA6MDA6MWEuMDogRUhDSSBIb3N0IENvbnRyb2xsZXIKLWVoY2lfaGNkIDAwMDA6MDA6
MWEuMDogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAxCi1l
aGNpX2hjZCAwMDAwOjAwOjFhLjA6IGRlYnVnIHBvcnQgMgotZWhjaV9oY2QgMDAwMDowMDox
YS4wOiByZXNldCBoY3NfcGFyYW1zIDB4MjAwMDAyIGRiZz0yIGNjPTAgcGNjPTAgb3JkZXJl
ZCAhcHBjIHBvcnRzPTIKLWVoY2lfaGNkIDAwMDA6MDA6MWEuMDogcmVzZXQgaGNjX3BhcmFt
cyAzNjg4MSBjYWNoaW5nIGZyYW1lIDEwMjQgNjQgYml0IGFkZHIKLWVoY2lfaGNkIDAwMDA6
MDA6MWEuMDogc3VwcG9ydCBscG0KLWVoY2lfaGNkIDAwMDA6MDA6MWEuMDogcmVzZXQgY29t
bWFuZCAwMDgwMDAyIChwYXJrKT0wIGl0aHJlc2g9OCBwZXJpb2Q9MTAyNCBSZXNldCBIQUxU
Ci1laGNpX2hjZCAwMDAwOjAwOjFhLjA6IGNhY2hlIGxpbmUgc2l6ZSBvZiA2NCBpcyBub3Qg
c3VwcG9ydGVkCi1laGNpX2hjZCAwMDAwOjAwOjFhLjA6IHN1cHBvcnRzIFVTQiByZW1vdGUg
d2FrZXVwCi1laGNpX2hjZCAwMDAwOjAwOjFhLjA6IGlycSAxNiwgaW8gbWVtIDB4ZjdmMDgw
MDAKLWVoY2lfaGNkIDAwMDA6MDA6MWEuMDogaW5pdCBjb21tYW5kIDAwMTAwMDEgKHBhcmsp
PTAgaXRocmVzaD0xIHBlcmlvZD0xMDI0IFJVTgotZWhjaV9oY2QgMDAwMDowMDoxYS4wOiBV
U0IgMi4wIHN0YXJ0ZWQsIEVIQ0kgMS4wMAotdXNiIHVzYjE6IGRlZmF1bHQgbGFuZ3VhZ2Ug
MHgwNDA5Ci11c2IgdXNiMTogdWRldiAxLCBidXNudW0gMSwgbWlub3IgPSAwCi11c2IgdXNi
MTogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTFkNmIsIGlkUHJvZHVjdD0wMDAy
Ci11c2IgdXNiMTogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTMsIFByb2R1Y3Q9Miwg
U2VyaWFsTnVtYmVyPTEKLXVzYiB1c2IxOiBQcm9kdWN0OiBFSENJIEhvc3QgQ29udHJvbGxl
cgotdXNiIHVzYjE6IE1hbnVmYWN0dXJlcjogTGludXggMy43LjEwLWRlZmF1bHQgZWhjaV9o
Y2QKLXVzYiB1c2IxOiBTZXJpYWxOdW1iZXI6IDAwMDA6MDA6MWEuMAotdXNiIHVzYjE6IHVz
Yl9wcm9iZV9kZXZpY2UKLXVzYiB1c2IxOiBjb25maWd1cmF0aW9uICMxIGNob3NlbiBmcm9t
IDEgY2hvaWNlCi11c2IgdXNiMTogYWRkaW5nIDEtMDoxLjAgKGNvbmZpZyAjMSwgaW50ZXJm
YWNlIDApCi1odWIgMS0wOjEuMDogdXNiX3Byb2JlX2ludGVyZmFjZQotaHViIDEtMDoxLjA6
IHVzYl9wcm9iZV9pbnRlcmZhY2UgLSBnb3QgaWQKLWh1YiAxLTA6MS4wOiBVU0IgaHViIGZv
dW5kCi1odWIgMS0wOjEuMDogMiBwb3J0cyBkZXRlY3RlZAotaHViIDEtMDoxLjA6IHN0YW5k
YWxvbmUgaHViCi1odWIgMS0wOjEuMDogbm8gcG93ZXIgc3dpdGNoaW5nICh1c2IgMS4wKQot
aHViIDEtMDoxLjA6IGluZGl2aWR1YWwgcG9ydCBvdmVyLWN1cnJlbnQgcHJvdGVjdGlvbgot
aHViIDEtMDoxLjA6IHBvd2VyIG9uIHRvIHBvd2VyIGdvb2QgdGltZTogMjBtcwotaHViIDEt
MDoxLjA6IGxvY2FsIHBvd2VyIHNvdXJjZSBpcyBnb29kCi1odWIgMS0wOjEuMDogdHJ5aW5n
IHRvIGVuYWJsZSBwb3J0IHBvd2VyIG9uIG5vbi1zd2l0Y2hhYmxlIGh1YgotZWhjaV9oY2Qg
MDAwMDowMDoxZC4wOiBlbmFibGluZyBidXMgbWFzdGVyaW5nCi1laGNpX2hjZCAwMDAwOjAw
OjFkLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NAotZWhjaV9oY2QgMDAwMDowMDox
ZC4wOiBFSENJIEhvc3QgQ29udHJvbGxlcgotZWhjaV9oY2QgMDAwMDowMDoxZC4wOiBuZXcg
VVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDIKLWVoY2lfaGNkIDAw
MDA6MDA6MWQuMDogZGVidWcgcG9ydCAyCi1laGNpX2hjZCAwMDAwOjAwOjFkLjA6IHJlc2V0
IGhjc19wYXJhbXMgMHgyMDAwMDIgZGJnPTIgY2M9MCBwY2M9MCBvcmRlcmVkICFwcGMgcG9y
dHM9MgotZWhjaV9oY2QgMDAwMDowMDoxZC4wOiByZXNldCBoY2NfcGFyYW1zIDM2ODgxIGNh
Y2hpbmcgZnJhbWUgMTAyNCA2NCBiaXQgYWRkcgotZWhjaV9oY2QgMDAwMDowMDoxZC4wOiBz
dXBwb3J0IGxwbQotZWhjaV9oY2QgMDAwMDowMDoxZC4wOiByZXNldCBjb21tYW5kIDAwODAw
MDIgKHBhcmspPTAgaXRocmVzaD04IHBlcmlvZD0xMDI0IFJlc2V0IEhBTFQKLWVoY2lfaGNk
IDAwMDA6MDA6MWQuMDogY2FjaGUgbGluZSBzaXplIG9mIDY0IGlzIG5vdCBzdXBwb3J0ZWQK
LWVoY2lfaGNkIDAwMDA6MDA6MWQuMDogc3VwcG9ydHMgVVNCIHJlbW90ZSB3YWtldXAKLWVo
Y2lfaGNkIDAwMDA6MDA6MWQuMDogaXJxIDIzLCBpbyBtZW0gMHhmN2YwNzAwMAotZWhjaV9o
Y2QgMDAwMDowMDoxZC4wOiBpbml0IGNvbW1hbmQgMDAxMDAwMSAocGFyayk9MCBpdGhyZXNo
PTEgcGVyaW9kPTEwMjQgUlVOCi1laGNpX2hjZCAwMDAwOjAwOjFkLjA6IFVTQiAyLjAgc3Rh
cnRlZCwgRUhDSSAxLjAwCi11c2IgdXNiMjogZGVmYXVsdCBsYW5ndWFnZSAweDA0MDkKLXVz
YiB1c2IyOiB1ZGV2IDEsIGJ1c251bSAyLCBtaW5vciA9IDEyOAotdXNiIHVzYjI6IE5ldyBV
U0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0xZDZiLCBpZFByb2R1Y3Q9MDAwMgotdXNiIHVz
YjI6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0zLCBQcm9kdWN0PTIsIFNlcmlhbE51
bWJlcj0xCi11c2IgdXNiMjogUHJvZHVjdDogRUhDSSBIb3N0IENvbnRyb2xsZXIKLXVzYiB1
c2IyOiBNYW51ZmFjdHVyZXI6IExpbnV4IDMuNy4xMC1kZWZhdWx0IGVoY2lfaGNkCi11c2Ig
dXNiMjogU2VyaWFsTnVtYmVyOiAwMDAwOjAwOjFkLjAKLXVzYiB1c2IyOiB1c2JfcHJvYmVf
ZGV2aWNlCi11c2IgdXNiMjogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2lj
ZQotdXNiIHVzYjI6IGFkZGluZyAyLTA6MS4wIChjb25maWcgIzEsIGludGVyZmFjZSAwKQot
aHViIDItMDoxLjA6IHVzYl9wcm9iZV9pbnRlcmZhY2UKLWh1YiAyLTA6MS4wOiB1c2JfcHJv
YmVfaW50ZXJmYWNlIC0gZ290IGlkCi1odWIgMi0wOjEuMDogVVNCIGh1YiBmb3VuZAotaHVi
IDItMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQKLWh1YiAyLTA6MS4wOiBzdGFuZGFsb25lIGh1
YgotaHViIDItMDoxLjA6IG5vIHBvd2VyIHN3aXRjaGluZyAodXNiIDEuMCkKLWh1YiAyLTA6
MS4wOiBpbmRpdmlkdWFsIHBvcnQgb3Zlci1jdXJyZW50IHByb3RlY3Rpb24KLWh1YiAyLTA6
MS4wOiBwb3dlciBvbiB0byBwb3dlciBnb29kIHRpbWU6IDIwbXMKLWh1YiAyLTA6MS4wOiBs
b2NhbCBwb3dlciBzb3VyY2UgaXMgZ29vZAotaHViIDItMDoxLjA6IHRyeWluZyB0byBlbmFi
bGUgcG9ydCBwb3dlciBvbiBub24tc3dpdGNoYWJsZSBodWIKLW9oY2lfaGNkOiBVU0IgMS4x
ICdPcGVuJyBIb3N0IENvbnRyb2xsZXIgKE9IQ0kpIERyaXZlcgotb2hjaV9oY2Q6IGJsb2Nr
IHNpemVzOiBlZCA4MCB0ZCA5NgoteGhjaV9oY2QgMDAwMDowYjowMC4wOiBlbmFibGluZyBi
dXMgbWFzdGVyaW5nCi14aGNpX2hjZCAwMDAwOjBiOjAwLjA6IHhIQ0kgSG9zdCBDb250cm9s
bGVyCi14aGNpX2hjZCAwMDAwOjBiOjAwLjA6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFz
c2lnbmVkIGJ1cyBudW1iZXIgMwoteGhjaV9oY2QgMDAwMDowYjowMC4wOiBlbmFibGluZyBN
ZW0tV3ItSW52YWwKLXhoY2lfaGNkIDAwMDA6MGI6MDAuMDogc3VwcG9ydHMgVVNCIHJlbW90
ZSB3YWtldXAKLXhoY2lfaGNkIDAwMDA6MGI6MDAuMDogaXJxIDE2LCBpbyBtZW0gMHhmN2Qw
MDAwMAoteGhjaV9oY2QgMDAwMDowYjowMC4wOiBpcnEgNDIgZm9yIE1TSS9NU0ktWAoteGhj
aV9oY2QgMDAwMDowYjowMC4wOiBpcnEgNDMgZm9yIE1TSS9NU0ktWAoteGhjaV9oY2QgMDAw
MDowYjowMC4wOiBpcnEgNDQgZm9yIE1TSS9NU0ktWAotdXNiIHVzYjM6IGRlZmF1bHQgbGFu
Z3VhZ2UgMHgwNDA5Ci11c2IgdXNiMzogdWRldiAxLCBidXNudW0gMywgbWlub3IgPSAyNTYK
LXVzYiB1c2IzOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MWQ2YiwgaWRQcm9k
dWN0PTAwMDIKLXVzYiB1c2IzOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MywgUHJv
ZHVjdD0yLCBTZXJpYWxOdW1iZXI9MQotdXNiIHVzYjM6IFByb2R1Y3Q6IHhIQ0kgSG9zdCBD
b250cm9sbGVyCi11c2IgdXNiMzogTWFudWZhY3R1cmVyOiBMaW51eCAzLjcuMTAtZGVmYXVs
dCB4aGNpX2hjZAotdXNiIHVzYjM6IFNlcmlhbE51bWJlcjogMDAwMDowYjowMC4wCi11c2Ig
dXNiMzogdXNiX3Byb2JlX2RldmljZQotdXNiIHVzYjM6IGNvbmZpZ3VyYXRpb24gIzEgY2hv
c2VuIGZyb20gMSBjaG9pY2UKLXhIQ0kgeGhjaV9hZGRfZW5kcG9pbnQgY2FsbGVkIGZvciBy
b290IGh1YgoteEhDSSB4aGNpX2NoZWNrX2JhbmR3aWR0aCBjYWxsZWQgZm9yIHJvb3QgaHVi
Ci11c2IgdXNiMzogYWRkaW5nIDMtMDoxLjAgKGNvbmZpZyAjMSwgaW50ZXJmYWNlIDApCi1o
dWIgMy0wOjEuMDogdXNiX3Byb2JlX2ludGVyZmFjZQotaHViIDMtMDoxLjA6IHVzYl9wcm9i
ZV9pbnRlcmZhY2UgLSBnb3QgaWQKLWh1YiAzLTA6MS4wOiBVU0IgaHViIGZvdW5kCi1odWIg
My0wOjEuMDogMiBwb3J0cyBkZXRlY3RlZAotaHViIDMtMDoxLjA6IHN0YW5kYWxvbmUgaHVi
Ci1odWIgMy0wOjEuMDogaW5kaXZpZHVhbCBwb3J0IHBvd2VyIHN3aXRjaGluZwotaHViIDMt
MDoxLjA6IGluZGl2aWR1YWwgcG9ydCBvdmVyLWN1cnJlbnQgcHJvdGVjdGlvbgotaHViIDMt
MDoxLjA6IFNpbmdsZSBUVAotaHViIDMtMDoxLjA6IFRUIHJlcXVpcmVzIGF0IG1vc3QgOCBG
UyBiaXQgdGltZXMgKDY2NiBucykKLWh1YiAzLTA6MS4wOiBwb3dlciBvbiB0byBwb3dlciBn
b29kIHRpbWU6IDIwbXMKLWh1YiAzLTA6MS4wOiBsb2NhbCBwb3dlciBzb3VyY2UgaXMgZ29v
ZAotaHViIDMtMDoxLjA6IGVuYWJsaW5nIHBvd2VyIG9uIGFsbCBwb3J0cwoteGhjaV9oY2Qg
MDAwMDowYjowMC4wOiB4SENJIEhvc3QgQ29udHJvbGxlcgoteGhjaV9oY2QgMDAwMDowYjow
MC4wOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDQKLXho
Y2lfaGNkIDAwMDA6MGI6MDAuMDogc3VwcG9ydHMgVVNCIHJlbW90ZSB3YWtldXAKLXVzYiB1
c2I0OiBza2lwcGVkIDEgZGVzY3JpcHRvciBhZnRlciBlbmRwb2ludAotdXNiIHVzYjQ6IGRl
ZmF1bHQgbGFuZ3VhZ2UgMHgwNDA5Ci11c2IgdXNiNDogdWRldiAxLCBidXNudW0gNCwgbWlu
b3IgPSAzODQKLXVzYiB1c2I0OiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MWQ2
YiwgaWRQcm9kdWN0PTAwMDMKLXVzYiB1c2I0OiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBN
ZnI9MywgUHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9MQotdXNiIHVzYjQ6IFByb2R1Y3Q6IHhI
Q0kgSG9zdCBDb250cm9sbGVyCi11c2IgdXNiNDogTWFudWZhY3R1cmVyOiBMaW51eCAzLjcu
MTAtZGVmYXVsdCB4aGNpX2hjZAotdXNiIHVzYjQ6IFNlcmlhbE51bWJlcjogMDAwMDowYjow
MC4wCi11c2IgdXNiNDogdXNiX3Byb2JlX2RldmljZQotdXNiIHVzYjQ6IGNvbmZpZ3VyYXRp
b24gIzEgY2hvc2VuIGZyb20gMSBjaG9pY2UKLXhIQ0kgeGhjaV9hZGRfZW5kcG9pbnQgY2Fs
bGVkIGZvciByb290IGh1YgoteEhDSSB4aGNpX2NoZWNrX2JhbmR3aWR0aCBjYWxsZWQgZm9y
IHJvb3QgaHViCi11c2IgdXNiNDogYWRkaW5nIDQtMDoxLjAgKGNvbmZpZyAjMSwgaW50ZXJm
YWNlIDApCi1odWIgNC0wOjEuMDogdXNiX3Byb2JlX2ludGVyZmFjZQotaHViIDQtMDoxLjA6
IHVzYl9wcm9iZV9pbnRlcmZhY2UgLSBnb3QgaWQKLWh1YiA0LTA6MS4wOiBVU0IgaHViIGZv
dW5kCi1odWIgNC0wOjEuMDogMiBwb3J0cyBkZXRlY3RlZAotaHViIDQtMDoxLjA6IHN0YW5k
YWxvbmUgaHViCi1odWIgNC0wOjEuMDogaW5kaXZpZHVhbCBwb3J0IHBvd2VyIHN3aXRjaGlu
ZwotaHViIDQtMDoxLjA6IGluZGl2aWR1YWwgcG9ydCBvdmVyLWN1cnJlbnQgcHJvdGVjdGlv
bgotaHViIDQtMDoxLjA6IFRUIHJlcXVpcmVzIGF0IG1vc3QgOCBGUyBiaXQgdGltZXMgKDY2
NiBucykKLWh1YiA0LTA6MS4wOiBwb3dlciBvbiB0byBwb3dlciBnb29kIHRpbWU6IDIwbXMK
LWh1YiA0LTA6MS4wOiBsb2NhbCBwb3dlciBzb3VyY2UgaXMgZ29vZAotaHViIDQtMDoxLjA6
IGVuYWJsaW5nIHBvd2VyIG9uIGFsbCBwb3J0cwotZWhjaV9oY2QgMDAwMDowMDoxYS4wOiBH
ZXRTdGF0dXMgcG9ydDoxIHN0YXR1cyAwMDE4MDMgMCAgQUNLIFBPV0VSIHNpZz1qIENTQyBD
T05ORUNUCi1odWIgMS0wOjEuMDogcG9ydCAxOiBzdGF0dXMgMDUwMSBjaGFuZ2UgMDAwMQog
SW5pdGlhbGl6aW5nIFVTQiBNYXNzIFN0b3JhZ2UgZHJpdmVyLi4uCi11c2Jjb3JlOiByZWdp
c3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYi1zdG9yYWdlCi1VU0IgTWFzcyBTdG9y
YWdlIHN1cHBvcnQgcmVnaXN0ZXJlZC4KLXVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVy
ZmFjZSBkcml2ZXIgdW1zLWRhdGFmYWIKLXVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVy
ZmFjZSBkcml2ZXIgdW1zLWZyZWVjb20KLXVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVy
ZmFjZSBkcml2ZXIgdW1zLXJlYWx0ZWsKLXVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVy
ZmFjZSBkcml2ZXIgdW1zLXVzYmF0CiBpODA0MjogUE5QOiBQUy8yIENvbnRyb2xsZXIgW1BO
UDAzMDM6S0JDLFBOUDBmMTM6UFMyXSBhdCAweDYwLDB4NjQgaXJxIDEsMTIKIHNlcmlvOiBp
ODA0MiBLQkQgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEKIHNlcmlvOiBpODA0MiBBVVggcG9y
dCBhdCAweDYwLDB4NjQgaXJxIDEyCiBtb3VzZWRldjogUFMvMiBtb3VzZSBkZXZpY2UgY29t
bW9uIGZvciBhbGwgbWljZQotdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRy
aXZlciBzeW5hcHRpY3NfdXNiCiBydGNfY21vcyAwMDowNTogUlRDIGNhbiB3YWtlIGZyb20g
UzQKIHJ0YyAobnVsbCk6IGFsYXJtIHJvbGxvdmVyOiBkYXkKIHJ0Y19jbW9zOiBkZXYgKDI1
NDowKQpAQCAtODg2LDI0ICs3NDIsMTUgQEAKIGRldmljZS1tYXBwZXI6IHVldmVudDogdmVy
c2lvbiAxLjAuMwogZGV2aWNlLW1hcHBlcjogaW9jdGw6IDQuMjMuMC1pb2N0bCAoMjAxMi0w
Ny0yNSkgaW5pdGlhbGlzZWQ6IGRtLWRldmVsQHJlZGhhdC5jb20KIGRldmljZS1tYXBwZXI6
IGRtLWxvZy11c2Vyc3BhY2U6IHZlcnNpb24gMS4xLjAgbG9hZGVkCi11c2Jjb3JlOiByZWdp
c3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIGJ0dXNiCiBFREFDIE1DOiBWZXI6IDMuMC4w
CiBpbnB1dDogQVQgVHJhbnNsYXRlZCBTZXQgMiBrZXlib2FyZCBhcyAvZGV2aWNlcy9wbGF0
Zm9ybS9pODA0Mi9zZXJpbzAvaW5wdXQvaW5wdXQ0CiBjcHVpZGxlOiB1c2luZyBnb3Zlcm5v
ciBsYWRkZXIKIGNwdWlkbGU6IHVzaW5nIGdvdmVybm9yIG1lbnUKIHNkaGNpOiBTZWN1cmUg
RGlnaXRhbCBIb3N0IENvbnRyb2xsZXIgSW50ZXJmYWNlIGRyaXZlcgogc2RoY2k6IENvcHly
aWdodChjKSBQaWVycmUgT3NzbWFuCi1laGNpX2hjZCAwMDAwOjAwOjFkLjA6IEdldFN0YXR1
cyBwb3J0OjEgc3RhdHVzIDAwMTgwMyAwICBBQ0sgUE9XRVIgc2lnPWogQ1NDIENPTk5FQ1QK
LWh1YiAyLTA6MS4wOiBwb3J0IDE6IHN0YXR1cyAwNTAxIGNoYW5nZSAwMDAxCiBkY2RiYXMg
ZGNkYmFzOiBEZWxsIFN5c3RlbXMgTWFuYWdlbWVudCBCYXNlIERyaXZlciAodmVyc2lvbiA1
LjYuMC0zLjIpCi11c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVz
YmhpZAotdXNiaGlkOiBVU0IgSElEIGNvcmUgZHJpdmVyCiBpbnB1dDogRGVsbCBXTUkgaG90
a2V5cyBhcyAvZGV2aWNlcy92aXJ0dWFsL2lucHV0L2lucHV0NQotaHViIDMtMDoxLjA6IHN0
YXRlIDcgcG9ydHMgMiBjaGcgMDAwMCBldnQgMDAwMAotaHViIDQtMDoxLjA6IHN0YXRlIDcg
cG9ydHMgMiBjaGcgMDAwMCBldnQgMDAwMAotc25kX2hkYV9pbnRlbCAwMDAwOjAwOjFiLjA6
IGlycSA0NSBmb3IgTVNJL01TSS1YCi1odWIgMS0wOjEuMDogc3RhdGUgNyBwb3J0cyAyIGNo
ZyAwMDAyIGV2dCAwMDAwCi1odWIgMS0wOjEuMDogcG9ydCAxLCBzdGF0dXMgMDUwMSwgY2hh
bmdlIDAwMDAsIDQ4MCBNYi9zCitzbmRfaGRhX2ludGVsIDAwMDA6MDA6MWIuMDogaXJxIDQy
IGZvciBNU0kvTVNJLVgKIGlucHV0OiBIREEgRGlnaXRhbCBQQ0JlZXAgYXMgL2RldmljZXMv
cGNpMDAwMDowMC8wMDAwOjAwOjFiLjAvaW5wdXQvaW5wdXQ2CiBpbnB1dDogSERBIEludGVs
IFBDSCBIRE1JL0RQLHBjbT0zIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxYi4w
L3NvdW5kL2NhcmQwL2lucHV0NwogaW5wdXQ6IEhEQSBJbnRlbCBQQ0ggTWljIGFzIC9kZXZp
Y2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxYi4wL3NvdW5kL2NhcmQwL2lucHV0OApAQCAtOTE4
LDEzICs3NjUsMTAgQEAKIEJsdWV0b290aDogQk5FUCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6
ZWQKIEJsdWV0b290aDogSElEUCAoSHVtYW4gSW50ZXJmYWNlIEVtdWxhdGlvbikgdmVyIDEu
MgogQmx1ZXRvb3RoOiBISURQIHNvY2tldCBsYXllciBpbml0aWFsaXplZAotZWhjaV9oY2Qg
MDAwMDowMDoxYS4wOiBwb3J0IDEgcmVzZXQgY29tcGxldGUsIHBvcnQgZW5hYmxlZAotZWhj
aV9oY2QgMDAwMDowMDoxYS4wOiBHZXRTdGF0dXMgcG9ydDoxIHN0YXR1cyAwMDEwMDUgMCAg
QUNLIFBPV0VSIHNpZz1zZTAgUEUgQ09OTkVDVAogc2N0cDogSGFzaCB0YWJsZXMgY29uZmln
dXJlZCAoZXN0YWJsaXNoZWQgNjU1MzYgYmluZCA2NTUzNikKIEtleSB0eXBlIGRuc19yZXNv
bHZlciByZWdpc3RlcmVkCiBQTTogQ2hlY2tpbmcgaGliZXJuYXRpb24gaW1hZ2UgcGFydGl0
aW9uIC9kZXYvc2RhNgogYXRhMTogU0FUQSBsaW5rIHVwIDMuMCBHYnBzIChTU3RhdHVzIDEy
MyBTQ29udHJvbCAzMDApCi11c2IgMS0xOiBuZXcgaGlnaC1zcGVlZCBVU0IgZGV2aWNlIG51
bWJlciAyIHVzaW5nIGVoY2lfaGNkCiBhdGExLjAwOiBBQ1BJIGNtZCAwMC8wMDowMDowMDow
MDowMDphMCAoTk9QKSByZWplY3RlZCBieSBkZXZpY2UgKFN0YXQ9MHg1MSBFcnI9MHgwNCkK
IGF0YTEuMDA6IEFUQS04OiBXREMgV0Q3NTAwQlBLVC03NVBLNFQwLCAwMS4wMUEwMSwgbWF4
IFVETUEvMTMzCiBhdGExLjAwOiAxNDY1MTQ5MTY4IHNlY3RvcnMsIG11bHRpIDE2OiBMQkE0
OCBOQ1EgKGRlcHRoIDMxLzMyKSwgQUEKQEAgLTkzNywyMDUgKzc4MSw1NSBAQAogc2QgMDow
OjA6MDogW3NkYV0gTW9kZSBTZW5zZTogMDAgM2EgMDAgMDAKIHNkIDA6MDowOjA6IFtzZGFd
IFdyaXRlIGNhY2hlOiBlbmFibGVkLCByZWFkIGNhY2hlOiBlbmFibGVkLCBkb2Vzbid0IHN1
cHBvcnQgRFBPIG9yIEZVQQogc2QgMDowOjA6MDogQXR0YWNoZWQgc2NzaSBnZW5lcmljIHNn
MCB0eXBlIDAKLWVoY2lfaGNkIDAwMDA6MDA6MWEuMDogcG9ydCAxIHJlc2V0IGNvbXBsZXRl
LCBwb3J0IGVuYWJsZWQKLWVoY2lfaGNkIDAwMDA6MDA6MWEuMDogR2V0U3RhdHVzIHBvcnQ6
MSBzdGF0dXMgMDAxMDA1IDAgIEFDSyBQT1dFUiBzaWc9c2UwIFBFIENPTk5FQ1QKLXRzYzog
UmVmaW5lZCBUU0MgY2xvY2tzb3VyY2UgY2FsaWJyYXRpb246IDI3OTMuNjUzIE1IegotZWhj
aV9oY2QgMDAwMDowMDoxYS4wOiBzZXQgZGV2IGFkZHJlc3MgMiBmb3IgcG9ydCAxCi1laGNp
X2hjZCAwMDAwOjAwOjFhLjA6IExQTTogbm8gZGV2aWNlIGF0dGFjaGVkCit0c2M6IFJlZmlu
ZWQgVFNDIGNsb2Nrc291cmNlIGNhbGlicmF0aW9uOiAyNzkzLjY1MiBNSHoKIFN3aXRjaGlu
ZyB0byBjbG9ja3NvdXJjZSB0c2MKLXVzYiAxLTE6IHVkZXYgMiwgYnVzbnVtIDEsIG1pbm9y
ID0gMQotdXNiIDEtMTogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTgwODcsIGlk
UHJvZHVjdD0wMDI0Ci11c2IgMS0xOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MCwg
UHJvZHVjdD0wLCBTZXJpYWxOdW1iZXI9MAotdXNiIDEtMTogdXNiX3Byb2JlX2RldmljZQot
dXNiIDEtMTogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQotdXNiIDEt
MTogYWRkaW5nIDEtMToxLjAgKGNvbmZpZyAjMSwgaW50ZXJmYWNlIDApCi1odWIgMS0xOjEu
MDogdXNiX3Byb2JlX2ludGVyZmFjZQotaHViIDEtMToxLjA6IHVzYl9wcm9iZV9pbnRlcmZh
Y2UgLSBnb3QgaWQKLWh1YiAxLTE6MS4wOiBVU0IgaHViIGZvdW5kCi1odWIgMS0xOjEuMDog
NiBwb3J0cyBkZXRlY3RlZAotaHViIDEtMToxLjA6IHN0YW5kYWxvbmUgaHViCi1odWIgMS0x
OjEuMDogaW5kaXZpZHVhbCBwb3J0IHBvd2VyIHN3aXRjaGluZwotaHViIDEtMToxLjA6IGlu
ZGl2aWR1YWwgcG9ydCBvdmVyLWN1cnJlbnQgcHJvdGVjdGlvbgotaHViIDEtMToxLjA6IFNp
bmdsZSBUVAotaHViIDEtMToxLjA6IFRUIHJlcXVpcmVzIGF0IG1vc3QgOCBGUyBiaXQgdGlt
ZXMgKDY2NiBucykKLWh1YiAxLTE6MS4wOiBwb3dlciBvbiB0byBwb3dlciBnb29kIHRpbWU6
IDEwMG1zCi1odWIgMS0xOjEuMDogbG9jYWwgcG93ZXIgc291cmNlIGlzIGdvb2QKICBzZGE6
IHNkYTEgc2RhMiBzZGEzIHNkYTQgPCBzZGE1IHNkYTYgPgogc2QgMDowOjA6MDogW3NkYV0g
QXR0YWNoZWQgU0NTSSBkaXNrCi1odWIgMS0xOjEuMDogZW5hYmxpbmcgcG93ZXIgb24gYWxs
IHBvcnRzCi1odWIgMi0wOjEuMDogc3RhdGUgNyBwb3J0cyAyIGNoZyAwMDAyIGV2dCAwMDAw
Ci1odWIgMi0wOjEuMDogcG9ydCAxLCBzdGF0dXMgMDUwMSwgY2hhbmdlIDAwMDAsIDQ4MCBN
Yi9zCi1laGNpX2hjZCAwMDAwOjAwOjFkLjA6IHBvcnQgMSByZXNldCBjb21wbGV0ZSwgcG9y
dCBlbmFibGVkCi1laGNpX2hjZCAwMDAwOjAwOjFkLjA6IEdldFN0YXR1cyBwb3J0OjEgc3Rh
dHVzIDAwMTAwNSAwICBBQ0sgUE9XRVIgc2lnPXNlMCBQRSBDT05ORUNUCi1odWIgMS0xOjEu
MDogcG9ydCA1OiBzdGF0dXMgMDEwMSBjaGFuZ2UgMDAwMQotdXNiIDItMTogbmV3IGhpZ2gt
c3BlZWQgVVNCIGRldmljZSBudW1iZXIgMiB1c2luZyBlaGNpX2hjZAotZWhjaV9oY2QgMDAw
MDowMDoxZC4wOiBwb3J0IDEgcmVzZXQgY29tcGxldGUsIHBvcnQgZW5hYmxlZAotZWhjaV9o
Y2QgMDAwMDowMDoxZC4wOiBHZXRTdGF0dXMgcG9ydDoxIHN0YXR1cyAwMDEwMDUgMCAgQUNL
IFBPV0VSIHNpZz1zZTAgUEUgQ09OTkVDVAotdXNiIDEtMTogbGluayBxaDI1Ni0wMDAxL2Zm
ZmY4ODA0MGFmNDY4NTAgc3RhcnQgMSBbMS8wIHVzXQogYXRhNTogU0FUQSBsaW5rIHVwIDEu
NSBHYnBzIChTU3RhdHVzIDExMyBTQ29udHJvbCAzMDApCiBhdGE1LjAwOiBBVEFQSTogUExE
UyBEVkQrLy1SVyBEUy04QThTSCwgS0QxMSwgbWF4IFVETUEvMTAwCiBhdGE1LjAwOiBjb25m
aWd1cmVkIGZvciBVRE1BLzEwMAotZWhjaV9oY2QgMDAwMDowMDoxZC4wOiBzZXQgZGV2IGFk
ZHJlc3MgMiBmb3IgcG9ydCAxCi1laGNpX2hjZCAwMDAwOjAwOjFkLjA6IExQTTogbm8gZGV2
aWNlIGF0dGFjaGVkCi11c2IgMi0xOiB1ZGV2IDIsIGJ1c251bSAyLCBtaW5vciA9IDEyOQot
dXNiIDItMTogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTgwODcsIGlkUHJvZHVj
dD0wMDI0Ci11c2IgMi0xOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MCwgUHJvZHVj
dD0wLCBTZXJpYWxOdW1iZXI9MAotdXNiIDItMTogdXNiX3Byb2JlX2RldmljZQotdXNiIDIt
MTogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQotdXNiIDItMTogYWRk
aW5nIDItMToxLjAgKGNvbmZpZyAjMSwgaW50ZXJmYWNlIDApCi1odWIgMi0xOjEuMDogdXNi
X3Byb2JlX2ludGVyZmFjZQotaHViIDItMToxLjA6IHVzYl9wcm9iZV9pbnRlcmZhY2UgLSBn
b3QgaWQKLWh1YiAyLTE6MS4wOiBVU0IgaHViIGZvdW5kCi1odWIgMi0xOjEuMDogOCBwb3J0
cyBkZXRlY3RlZAotaHViIDItMToxLjA6IHN0YW5kYWxvbmUgaHViCi1odWIgMi0xOjEuMDog
aW5kaXZpZHVhbCBwb3J0IHBvd2VyIHN3aXRjaGluZwotaHViIDItMToxLjA6IGluZGl2aWR1
YWwgcG9ydCBvdmVyLWN1cnJlbnQgcHJvdGVjdGlvbgotaHViIDItMToxLjA6IFNpbmdsZSBU
VAotaHViIDItMToxLjA6IFRUIHJlcXVpcmVzIGF0IG1vc3QgOCBGUyBiaXQgdGltZXMgKDY2
NiBucykKLWh1YiAyLTE6MS4wOiBwb3dlciBvbiB0byBwb3dlciBnb29kIHRpbWU6IDEwMG1z
Ci1odWIgMi0xOjEuMDogbG9jYWwgcG93ZXIgc291cmNlIGlzIGdvb2QKIHNjc2kgNDowOjA6
MDogQ0QtUk9NICAgICAgICAgICAgUExEUyAgICAgRFZEKy1SVyBEUy04QThTSCBLRDExIFBR
OiAwIEFOU0k6IDUKIHNyMDogc2NzaTMtbW1jIGRyaXZlOiAyNHgvMjR4IHdyaXRlciBkdmQt
cmFtIGNkL3J3IHhhL2Zvcm0yIGNkZGEgdHJheQogY2Ryb206IFVuaWZvcm0gQ0QtUk9NIGRy
aXZlciBSZXZpc2lvbjogMy4yMAotaHViIDItMToxLjA6IGVuYWJsaW5nIHBvd2VyIG9uIGFs
bCBwb3J0cwogc3IgNDowOjA6MDogQXR0YWNoZWQgc2NzaSBDRC1ST00gc3IwCi1odWIgMS0x
OjEuMDogc3RhdGUgNyBwb3J0cyA2IGNoZyAwMDIwIGV2dCAwMDAwCi1odWIgMS0xOjEuMDog
cG9ydCA1LCBzdGF0dXMgMDEwMSwgY2hhbmdlIDAwMDAsIDEyIE1iL3MKIHNyIDQ6MDowOjA6
IEF0dGFjaGVkIHNjc2kgZ2VuZXJpYyBzZzEgdHlwZSA1CiBBQ1BJOiBJbnZhbGlkIFBvd2Vy
IFJlc291cmNlIHRvIHJlZ2lzdGVyIQogQUNQSTogSW52YWxpZCBQb3dlciBSZXNvdXJjZSB0
byByZWdpc3RlciEKLXVzYiAxLTEuNTogbmV3IGhpZ2gtc3BlZWQgVVNCIGRldmljZSBudW1i
ZXIgMyB1c2luZyBlaGNpX2hjZAotaHViIDItMToxLjA6IHBvcnQgMjogc3RhdHVzIDAxMDEg
Y2hhbmdlIDAwMDEKLWh1YiAyLTE6MS4wOiBwb3J0IDM6IHN0YXR1cyAwMTAxIGNoYW5nZSAw
MDAxCi11c2IgMS0xLjU6IHNraXBwZWQgMSBkZXNjcmlwdG9yIGFmdGVyIGNvbmZpZ3VyYXRp
b24KLXVzYiAxLTEuNTogc2tpcHBlZCA2IGRlc2NyaXB0b3JzIGFmdGVyIGludGVyZmFjZQot
dXNiIDEtMS41OiBza2lwcGVkIDEgZGVzY3JpcHRvciBhZnRlciBlbmRwb2ludAotdXNiIDEt
MS41OiBza2lwcGVkIDE5IGRlc2NyaXB0b3JzIGFmdGVyIGludGVyZmFjZQotdXNiIDEtMS41
OiBza2lwcGVkIDEgZGVzY3JpcHRvciBhZnRlciBlbmRwb2ludAotdXNiIDEtMS41OiBkZWZh
dWx0IGxhbmd1YWdlIDB4MDQwOQotdXNiIDEtMS41OiB1ZGV2IDMsIGJ1c251bSAxLCBtaW5v
ciA9IDIKLXVzYiAxLTEuNTogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTA1Y2Es
IGlkUHJvZHVjdD0xODIwCi11c2IgMS0xLjU6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1m
cj0xLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0wCi11c2IgMS0xLjU6IFByb2R1Y3Q6IExh
cHRvcF9JbnRlZ3JhdGVkX1dlYmNhbV9GSEQKLXVzYiAxLTEuNTogTWFudWZhY3R1cmVyOiBD
TjAxTVdNOTcyNDg3MUE0S0IyOEEwMAotdXNiIDEtMS41OiB1c2JfcHJvYmVfZGV2aWNlCi11
c2IgMS0xLjU6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZyb20gMSBjaG9pY2UKLXVzYiAy
LTE6IGxpbmsgcWgyNTYtMDAwMS9mZmZmODgwNDBiMTQ3YmUwIHN0YXJ0IDEgWzEvMCB1c10K
LXVzYiAxLTEuNTogYWRkaW5nIDEtMS41OjEuMCAoY29uZmlnICMxLCBpbnRlcmZhY2UgMCkK
LXVzYiAxLTEuNTogYWRkaW5nIDEtMS41OjEuMSAoY29uZmlnICMxLCBpbnRlcmZhY2UgMSkK
LWh1YiAyLTE6MS4wOiBzdGF0ZSA3IHBvcnRzIDggY2hnIDAwMGMgZXZ0IDAwMDAKLWh1YiAy
LTE6MS4wOiBwb3J0IDIsIHN0YXR1cyAwMTAxLCBjaGFuZ2UgMDAwMCwgMTIgTWIvcwotdXNi
IDItMS4yOiBuZXcgaGlnaC1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciAzIHVzaW5nIGVoY2lf
aGNkCiBpbnB1dDogRHVhbFBvaW50IFN0aWNrIGFzIC9kZXZpY2VzL3BsYXRmb3JtL2k4MDQy
L3NlcmlvMS9pbnB1dC9pbnB1dDEwCiBpbnB1dDogQWxwc1BTLzIgQUxQUyBEdWFsUG9pbnQg
VG91Y2hQYWQgYXMgL2RldmljZXMvcGxhdGZvcm0vaTgwNDIvc2VyaW8xL2lucHV0L2lucHV0
MTEKIGF0YTY6IFNBVEEgbGluayBkb3duIChTU3RhdHVzIDAgU0NvbnRyb2wgMzAwKQogUE06
IEhpYmVybmF0aW9uIGltYWdlIHBhcnRpdGlvbiA4OjYgcHJlc2VudAogUE06IExvb2tpbmcg
Zm9yIGhpYmVybmF0aW9uIGltYWdlLgotdXNiIDItMS4yOiBkZWZhdWx0IGxhbmd1YWdlIDB4
MDQwOQotdXNiIDItMS4yOiB1ZGV2IDMsIGJ1c251bSAyLCBtaW5vciA9IDEzMAotdXNiIDIt
MS4yOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MjEwOSwgaWRQcm9kdWN0PTM0
MzEKLXVzYiAyLTEuMjogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTAsIFByb2R1Y3Q9
MSwgU2VyaWFsTnVtYmVyPTAKLXVzYiAyLTEuMjogUHJvZHVjdDogVVNCMi4wIEh1YgotdXNi
IDItMS4yOiB1c2JfcHJvYmVfZGV2aWNlCi11c2IgMi0xLjI6IGNvbmZpZ3VyYXRpb24gIzEg
Y2hvc2VuIGZyb20gMSBjaG9pY2UKLXVzYiAyLTEuMjogYWRkaW5nIDItMS4yOjEuMCAoY29u
ZmlnICMxLCBpbnRlcmZhY2UgMCkKLWh1YiAyLTEuMjoxLjA6IHVzYl9wcm9iZV9pbnRlcmZh
Y2UKLWh1YiAyLTEuMjoxLjA6IHVzYl9wcm9iZV9pbnRlcmZhY2UgLSBnb3QgaWQKLWh1YiAy
LTEuMjoxLjA6IFVTQiBodWIgZm91bmQKLWh1YiAyLTEuMjoxLjA6IDQgcG9ydHMgZGV0ZWN0
ZWQKLWh1YiAyLTEuMjoxLjA6IHN0YW5kYWxvbmUgaHViCi1odWIgMi0xLjI6MS4wOiBpbmRp
dmlkdWFsIHBvcnQgcG93ZXIgc3dpdGNoaW5nCi1odWIgMi0xLjI6MS4wOiBpbmRpdmlkdWFs
IHBvcnQgb3Zlci1jdXJyZW50IHByb3RlY3Rpb24KLWh1YiAyLTEuMjoxLjA6IFNpbmdsZSBU
VAotaHViIDItMS4yOjEuMDogVFQgcmVxdWlyZXMgYXQgbW9zdCAzMiBGUyBiaXQgdGltZXMg
KDI2NjQgbnMpCi1odWIgMi0xLjI6MS4wOiBQb3J0IGluZGljYXRvcnMgYXJlIHN1cHBvcnRl
ZAotaHViIDItMS4yOjEuMDogcG93ZXIgb24gdG8gcG93ZXIgZ29vZCB0aW1lOiAxMDBtcwot
aHViIDItMS4yOjEuMDogbG9jYWwgcG93ZXIgc291cmNlIGlzIGdvb2QKLWh1YiAyLTEuMjox
LjA6IGVuYWJsaW5nIHBvd2VyIG9uIGFsbCBwb3J0cwogUE06IEltYWdlIG5vdCBmb3VuZCAo
Y29kZSAtMjIpCiBQTTogSGliZXJuYXRpb24gaW1hZ2Ugbm90IHByZXNlbnQgb3IgY291bGQg
bm90IGJlIGxvYWRlZC4KIGttZW1sZWFrOiBLZXJuZWwgbWVtb3J5IGxlYWsgZGV0ZWN0b3Ig
aW5pdGlhbGl6ZWQKIGttZW1sZWFrOiBBdXRvbWF0aWMgbWVtb3J5IHNjYW5uaW5nIHRocmVh
ZCBzdGFydGVkCi1odWIgMi0xOjEuMDogcG9ydCAzLCBzdGF0dXMgMDEwMSwgY2hhbmdlIDAw
MDAsIDEyIE1iL3MKLXJ0Y19jbW9zIDAwOjA1OiBzZXR0aW5nIHN5c3RlbSBjbG9jayB0byAy
MDEzLTAzLTExIDIzOjM1OjMzIFVUQyAoMTM2MzA0NDkzMykKK3J0Y19jbW9zIDAwOjA1OiBz
ZXR0aW5nIHN5c3RlbSBjbG9jayB0byAyMDEzLTAzLTExIDIzOjQxOjU3IFVUQyAoMTM2MzA0
NTMxNykKIEJJT1MgRUREIGZhY2lsaXR5IHYwLjE2IDIwMDQtSnVuLTI1LCAxIGRldmljZXMg
Zm91bmQKIEFMU0EgZGV2aWNlIGxpc3Q6Ci0gICMwOiBIREEgSW50ZWwgUENIIGF0IDB4Zjdm
MDAwMDAgaXJxIDQ1CisgICMwOiBIREEgSW50ZWwgUENIIGF0IDB4ZjdmMDAwMDAgaXJxIDQy
CiBtZDogV2FpdGluZyBmb3IgYWxsIGRldmljZXMgdG8gYmUgYXZhaWxhYmxlIGJlZm9yZSBh
dXRvZGV0ZWN0CiBtZDogSWYgeW91IGRvbid0IHVzZSByYWlkLCB1c2UgcmFpZD1ub2F1dG9k
ZXRlY3QKIG1kOiBBdXRvZGV0ZWN0aW5nIFJBSUQgYXJyYXlzLgogbWQ6IFNjYW5uZWQgMCBh
bmQgYWRkZWQgMCBkZXZpY2VzLgogbWQ6IGF1dG9ydW4gLi4uCiBtZDogLi4uIGF1dG9ydW4g
RE9ORS4KLXVzYiAyLTEuMzogbmV3IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgNCB1
c2luZyBlaGNpX2hjZAoga2pvdXJuYWxkIHN0YXJ0aW5nLiAgQ29tbWl0IGludGVydmFsIDUg
c2Vjb25kcwogRVhUMy1mcyAoc2RhNSk6IG1vdW50ZWQgZmlsZXN5c3RlbSB3aXRoIHdyaXRl
YmFjayBkYXRhIG1vZGUKIFZGUzogTW91bnRlZCByb290IChleHQzIGZpbGVzeXN0ZW0pIHJl
YWRvbmx5IG9uIGRldmljZSA4OjUuCi1odWIgMi0xLjI6MS4wOiBwb3J0IDM6IHN0YXR1cyAw
MzAxIGNoYW5nZSAwMDAxCi1odWIgMi0xLjI6MS4wOiBwb3J0IDQ6IHN0YXR1cyAwMzAxIGNo
YW5nZSAwMDAxCiBkZXZ0bXBmczogbW91bnRlZAogRnJlZWluZyB1bnVzZWQga2VybmVsIG1l
bW9yeTogNjg4ayBmcmVlZAotdXNiIDItMS4zOiBlcDAgbWF4cGFja2V0ID0gOAotdXNiIDIt
MS4zOiBkZWZhdWx0IGxhbmd1YWdlIDB4MDQwOQotdXNiIDItMS4zOiB1ZGV2IDQsIGJ1c251
bSAyLCBtaW5vciA9IDEzMQotdXNiIDItMS4zOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRW
ZW5kb3I9MTM4YSwgaWRQcm9kdWN0PTAwMTEKLXVzYiAyLTEuMzogTmV3IFVTQiBkZXZpY2Ug
c3RyaW5nczogTWZyPTAsIFByb2R1Y3Q9MCwgU2VyaWFsTnVtYmVyPTEKLXVzYiAyLTEuMzog
U2VyaWFsTnVtYmVyOiA1NmVkNTgyMWFmZTIKLXVzYiAyLTEuMzogdXNiX3Byb2JlX2Rldmlj
ZQotdXNiIDItMS4zOiBjb25maWd1cmF0aW9uICMxIGNob3NlbiBmcm9tIDEgY2hvaWNlCi11
c2IgMi0xLjM6IGFkZGluZyAyLTEuMzoxLjAgKGNvbmZpZyAjMSwgaW50ZXJmYWNlIDApCi1o
dWIgMi0xOjEuMDogc3RhdGUgNyBwb3J0cyA4IGNoZyAwMDAwIGV2dCAwMDA4Ci11c2IgMi0x
LjI6IGxpbmsgcWgyNTYtMDAwMS9mZmZmODgwNDBhOWJiMTMwIHN0YXJ0IDIgWzEvMCB1c10K
LWh1YiAyLTEuMjoxLjA6IHN0YXRlIDcgcG9ydHMgNCBjaGcgMDAxOCBldnQgMDAwMAotaHVi
IDItMS4yOjEuMDogcG9ydCAzLCBzdGF0dXMgMDMwMSwgY2hhbmdlIDAwMDAsIDEuNSBNYi9z
Ci11c2IgMi0xLjIuMzogbmV3IGxvdy1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciA1IHVzaW5n
IGVoY2lfaGNkCi11c2IgMi0xLjIuMzogc2tpcHBlZCAxIGRlc2NyaXB0b3IgYWZ0ZXIgaW50
ZXJmYWNlCi11c2IgMi0xLjIuMzogZGVmYXVsdCBsYW5ndWFnZSAweDA0MDkKLXVzYiAyLTEu
Mi4zOiB1ZGV2IDUsIGJ1c251bSAyLCBtaW5vciA9IDEzMgotdXNiIDItMS4yLjM6IE5ldyBV
U0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0wNDZkLCBpZFByb2R1Y3Q9YzA1MAotdXNiIDIt
MS4yLjM6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsIFNlcmlh
bE51bWJlcj0wCi11c2IgMi0xLjIuMzogUHJvZHVjdDogVVNCLVBTLzIgT3B0aWNhbCBNb3Vz
ZQotdXNiIDItMS4yLjM6IE1hbnVmYWN0dXJlcjogTG9naXRlY2gKLXVzYiAyLTEuMi4zOiB1
c2JfcHJvYmVfZGV2aWNlCi11c2IgMi0xLjIuMzogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4g
ZnJvbSAxIGNob2ljZQotdXNiIDItMS4yLjM6IGFkZGluZyAyLTEuMi4zOjEuMCAoY29uZmln
ICMxLCBpbnRlcmZhY2UgMCkKLXVzYmhpZCAyLTEuMi4zOjEuMDogdXNiX3Byb2JlX2ludGVy
ZmFjZQotdXNiaGlkIDItMS4yLjM6MS4wOiB1c2JfcHJvYmVfaW50ZXJmYWNlIC0gZ290IGlk
Ci1pbnB1dDogTG9naXRlY2ggVVNCLVBTLzIgT3B0aWNhbCBNb3VzZSBhcyAvZGV2aWNlcy9w
Y2kwMDAwOjAwLzAwMDA6MDA6MWQuMC91c2IyLzItMS8yLTEuMi8yLTEuMi4zLzItMS4yLjM6
MS4wL2lucHV0L2lucHV0MTIKLWhpZC1nZW5lcmljIDAwMDM6MDQ2RDpDMDUwLjAwMDE6IGlu
cHV0LGhpZHJhdzA6IFVTQiBISUQgdjEuMTAgTW91c2UgW0xvZ2l0ZWNoIFVTQi1QUy8yIE9w
dGljYWwgTW91c2VdIG9uIHVzYi0wMDAwOjAwOjFkLjAtMS4yLjMvaW5wdXQwCi1odWIgMi0x
LjI6MS4wOiBwb3J0IDQsIHN0YXR1cyAwMzAxLCBjaGFuZ2UgMDAwMCwgMS41IE1iL3MKLXVz
YiAyLTEuMi40OiBuZXcgbG93LXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDYgdXNpbmcgZWhj
aV9oY2QKLXVzYiAyLTEuMi40OiBza2lwcGVkIDEgZGVzY3JpcHRvciBhZnRlciBpbnRlcmZh
Y2UKLXVzYiAyLTEuMi40OiBkZWZhdWx0IGxhbmd1YWdlIDB4MDQwOQotdXNiIDItMS4yLjQ6
IHVkZXYgNiwgYnVzbnVtIDIsIG1pbm9yID0gMTMzCi11c2IgMi0xLjIuNDogTmV3IFVTQiBk
ZXZpY2UgZm91bmQsIGlkVmVuZG9yPTA0ZjIsIGlkUHJvZHVjdD0wMTE2Ci11c2IgMi0xLjIu
NDogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEsIFByb2R1Y3Q9MiwgU2VyaWFsTnVt
YmVyPTAKLXVzYiAyLTEuMi40OiBQcm9kdWN0OiBVU0IgS2V5Ym9hcmQKLXVzYiAyLTEuMi40
OiBNYW51ZmFjdHVyZXI6IENISUNPTlkKLXVzYiAyLTEuMi40OiB1c2JfcHJvYmVfZGV2aWNl
Ci11c2IgMi0xLjIuNDogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQot
dXNiIDItMS4yLjQ6IGFkZGluZyAyLTEuMi40OjEuMCAoY29uZmlnICMxLCBpbnRlcmZhY2Ug
MCkKLXVzYmhpZCAyLTEuMi40OjEuMDogdXNiX3Byb2JlX2ludGVyZmFjZQotdXNiaGlkIDIt
MS4yLjQ6MS4wOiB1c2JfcHJvYmVfaW50ZXJmYWNlIC0gZ290IGlkCi1pbnB1dDogQ0hJQ09O
WSBVU0IgS2V5Ym9hcmQgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFkLjAvdXNi
Mi8yLTEvMi0xLjIvMi0xLjIuNC8yLTEuMi40OjEuMC9pbnB1dC9pbnB1dDEzCi11c2IgMi0x
LjIuNDogbGluayBxaDgtMGUwMS9mZmZmODgwNDBhOWJiNDI4IHN0YXJ0IDMgWzEvMiB1c10K
LWhpZC1nZW5lcmljIDAwMDM6MDRGMjowMTE2LjAwMDI6IGlucHV0LGhpZHJhdzE6IFVTQiBI
SUQgdjEuMTAgS2V5Ym9hcmQgW0NISUNPTlkgVVNCIEtleWJvYXJkXSBvbiB1c2ItMDAwMDow
MDoxZC4wLTEuMi40L2lucHV0MAotaHViIDMtMDoxLjA6IGh1Yl9zdXNwZW5kCi11c2IgdXNi
MzogYnVzIGF1dG8tc3VzcGVuZCwgd2FrZXVwIDEKLWh1YiA0LTA6MS4wOiBodWJfc3VzcGVu
ZAotdXNiIHVzYjQ6IGJ1cyBhdXRvLXN1c3BlbmQsIHdha2V1cCAxCi1zeXN0ZW1kLXVkZXZk
WzE5MzRdOiBzdGFydGluZyB2ZXJzaW9uIDE5Nworc3lzdGVtZC11ZGV2ZFsxODg3XTogc3Rh
cnRpbmcgdmVyc2lvbiAxOTcKIGZpcmV3aXJlX29oY2kgMDAwMDoxMTowMC4wOiBjYWxsaW5n
IHF1aXJrX3ZpYV92bGluaysweDAvMHhhNQogZmlyZXdpcmVfb2hjaSAwMDAwOjExOjAwLjA6
IGFkZGVkIE9IQ0kgdjEuMTAgZGV2aWNlIGFzIGNhcmQgMCwgNCBJUiArIDggSVQgY29udGV4
dHMsIHF1aXJrcyAweDExCiBJbnRlbChSKSBXaXJlbGVzcyBXaUZpIGRyaXZlciBmb3IgTGlu
dXgsIGluLXRyZWU6ZAogQ29weXJpZ2h0KGMpIDIwMDMtMjAxMiBJbnRlbCBDb3Jwb3JhdGlv
bgogaXdsd2lmaSAwMDAwOjA5OjAwLjA6IHBjaV9yZXNvdXJjZV9sZW4gPSAweDAwMDAyMDAw
Ci1pd2x3aWZpIDAwMDA6MDk6MDAuMDogcGNpX3Jlc291cmNlX2Jhc2UgPSBmZmZmYzkwMDAx
ODdjMDAwCitpd2x3aWZpIDAwMDA6MDk6MDAuMDogcGNpX3Jlc291cmNlX2Jhc2UgPSBmZmZm
YzkwMDA2YWE4MDAwCiBpd2x3aWZpIDAwMDA6MDk6MDAuMDogSFcgUmV2aXNpb24gSUQgPSAw
eDM0Ci1pd2x3aWZpIDAwMDA6MDk6MDAuMDogaXJxIDQ2IGZvciBNU0kvTVNJLVgKLWZpcmV3
aXJlX2NvcmUgMDAwMDoxMTowMC4wOiBjcmVhdGVkIGRldmljZSBmdzA6IEdVSUQgMDAxMTA2
NjYwMDAwMDAwMywgUzQwMAoraXdsd2lmaSAwMDAwOjA5OjAwLjA6IGlycSA0MyBmb3IgTVNJ
L01TSS1YCiBpd2x3aWZpIDAwMDA6MDk6MDAuMDogbG9hZGVkIGZpcm13YXJlIHZlcnNpb24g
MTguMTY4LjYuMQotW2RybV0gSW5pdGlhbGl6ZWQgZHJtIDEuMS4wIDIwMDYwODEwCitmaXJl
d2lyZV9jb3JlIDAwMDA6MTE6MDAuMDogY3JlYXRlZCBkZXZpY2UgZncwOiBHVUlEIDAwMTEw
NjY2MDAwMDAwMDMsIFM0MDAKIGl3bGR2bTogSW50ZWwoUikgV2lyZWxlc3MgV2lGaSBMaW5r
IEFHTiBkcml2ZXIgZm9yIExpbnV4LCBpbi10cmVlOmQKIGl3bGR2bTogQ29weXJpZ2h0KGMp
IDIwMDMtMjAxMiBJbnRlbCBDb3Jwb3JhdGlvbgogaXdsd2lmaSAwMDAwOjA5OjAwLjA6IENP
TkZJR19JV0xXSUZJX0RFQlVHIGVuYWJsZWQKQEAgLTExNTEsMTEgKzg0NSwxOCBAQAogaXds
d2lmaSAwMDAwOjA5OjAwLjA6IFZhbGlkIFR4IGFudDogMHgxLCBWYWxpZCBSeCBhbnQ6IDB4
MwogUmVnaXN0ZXJlZCBsZWQgZGV2aWNlOiBwaHkwLWxlZAogaWVlZTgwMjExIHBoeTA6IFNl
bGVjdGVkIHJhdGUgY29udHJvbCBhbGdvcml0aG0gJ2l3bC1hZ24tcnMnCitbZHJtXSBJbml0
aWFsaXplZCBkcm0gMS4xLjAgMjAwNjA4MTAKK3I4MTY5IDAwMDA6MDU6MDAuMDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjA6IFBNRSMgZW5hYmxlZAorcjgxNjkgMDAw
MDowNTowMC4wIGV0aDA6IHJ0bF9waHlhcl9jb25kID09IDEgKGxvb3A6IDIwLCBkZWxheTog
MjUpLgorcjgxNjkgMDAwMDowNTowMC4wIGV0aDA6IHJ0bF9waHlhcl9jb25kID09IDEgKGxv
b3A6IDIwLCBkZWxheTogMjUpLgorcjgxNjkgMDAwMDowNTowMC4wIGV0aDA6IHJ0bF9waHlh
cl9jb25kID09IDEgKGxvb3A6IDIwLCBkZWxheTogMjUpLgorcjgxNjkgMDAwMDowNTowMC4w
IGV0aDA6IHJ0bF9waHlhcl9jb25kID09IDEgKGxvb3A6IDIwLCBkZWxheTogMjUpLgogcGNp
IDAwMDA6MDA6MDAuMDogSW50ZWwgU2FuZHlicmlkZ2UgQ2hpcHNldAogcGNpIDAwMDA6MDA6
MDAuMDogZGV0ZWN0ZWQgZ3R0IHNpemU6IDIwOTcxNTJLIHRvdGFsLCAyNjIxNDRLIG1hcHBh
YmxlCiBwY2kgMDAwMDowMDowMC4wOiBkZXRlY3RlZCA2NTUzNksgc3RvbGVuIG1lbW9yeQog
aTkxNSAwMDAwOjAwOjAyLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NAotaTkxNSAw
MDAwOjAwOjAyLjA6IGlycSA0NyBmb3IgTVNJL01TSS1YCitpOTE1IDAwMDA6MDA6MDIuMDog
aXJxIDQ0IGZvciBNU0kvTVNJLVgKIFtkcm1dIFN1cHBvcnRzIHZibGFuayB0aW1lc3RhbXAg
Y2FjaGluZyBSZXYgMSAoMTAuMTAuMjAxMCkuCiBbZHJtXSBEcml2ZXIgc3VwcG9ydHMgcHJl
Y2lzZSB2YmxhbmsgdGltZXN0YW1wIHF1ZXJ5LgogdmdhYXJiOiBkZXZpY2UgY2hhbmdlZCBk
ZWNvZGVzOiBQQ0k6MDAwMDowMDowMi4wLG9sZGRlY29kZXM9aW8rbWVtLGRlY29kZXM9aW8r
bWVtOm93bnM9aW8rbWVtCkBAIC0xMTY2LDMxICs4NjcsMjY3IEBACiBkcm06IHJlZ2lzdGVy
ZWQgcGFuaWMgbm90aWZpZXIKIGFjcGkgZGV2aWNlOjM0OiByZWdpc3RlcmVkIGFzIGNvb2xp
bmdfZGV2aWNlMgogQUNQSTogVmlkZW8gRGV2aWNlIFtHRlgwXSAobXVsdGktaGVhZDogeWVz
ICByb206IG5vICBwb3N0OiBubykKLWlucHV0OiBWaWRlbyBCdXMgYXMgL2RldmljZXMvTE5Y
U1lTVE06MDAvTE5YU1lCVVM6MDAvUE5QMEEwODowMC9MTlhWSURFTzowMC9pbnB1dC9pbnB1
dDE0CitpbnB1dDogVmlkZW8gQnVzIGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVT
OjAwL1BOUDBBMDg6MDAvTE5YVklERU86MDAvaW5wdXQvaW5wdXQxMgogW2RybV0gSW5pdGlh
bGl6ZWQgaTkxNSAxLjYuMCAyMDA4MDczMCBmb3IgMDAwMDowMDowMi4wIG9uIG1pbm9yIDAK
IEVYVDMtZnMgKHNkYTUpOiB1c2luZyBpbnRlcm5hbCBqb3VybmFsCiBBZGRpbmcgNDk5ODk3
Mmsgc3dhcCBvbiAvZGV2L3NkYTYuICBQcmlvcml0eTotMSBleHRlbnRzOjEgYWNyb3NzOjQ5
OTg5NzJrIAorcjgxNjkgMDAwMDowNTowMC4wOiBQTUUjIGRpc2FibGVkCiByODE2OSAwMDAw
OjA1OjAwLjAgZXRoMDogdW5hYmxlIHRvIGxvYWQgZmlybXdhcmUgcGF0Y2ggcnRsX25pYy9y
dGw4MTY4ZS0yLmZ3ICgtMikKIHI4MTY5IDAwMDA6MDU6MDAuMCBldGgwOiBsaW5rIGRvd24K
IHI4MTY5IDAwMDA6MDU6MDAuMCBldGgwOiBsaW5rIGRvd24KIHI4MTY5IDAwMDA6MDU6MDAu
MCBldGgwOiBsaW5rIHVwCi11c2IgMi0xLjIuMzogbGluayBxaDgtMGUwMS9mZmZmODgwNDBj
OGYwMDAwIHN0YXJ0IDQgWzEvMiB1c10KIG1pY3JvY29kZTogQ1BVMCB1cGRhdGVkIHRvIHJl
dmlzaW9uIDB4MjgsIGRhdGUgPSAyMDEyLTA0LTI0CiBtaWNyb2NvZGU6IENQVTEgdXBkYXRl
ZCB0byByZXZpc2lvbiAweDI4LCBkYXRlID0gMjAxMi0wNC0yNAogcGVyZl9ldmVudF9pbnRl
bDogUEVCUyBlbmFibGVkIGR1ZSB0byBtaWNyb2NvZGUgdXBkYXRlCiByODE2OSAwMDAwOjA1
OjAwLjAgZXRoMDogbGluayBkb3duCityODE2OSAwMDAwOjA1OjAwLjA6IFBNRSMgZW5hYmxl
ZAorcjgxNjkgMDAwMDowNTowMC4wOiBQTUUjIGRpc2FibGVkCityODE2OSAwMDAwOjA1OjAw
LjAgZXRoMDogbGluayBkb3duCiByODE2OSAwMDAwOjA1OjAwLjAgZXRoMDogbGluayB1cAot
dXNiIHVzYjM6IHVzYiBhdXRvLXJlc3VtZQotaHViIDMtMDoxLjA6IGh1Yl9yZXN1bWUKLXVz
YiB1c2I0OiB1c2IgYXV0by1yZXN1bWUKLWh1YiAzLTA6MS4wOiBzdGF0ZSA3IHBvcnRzIDIg
Y2hnIDAwMDAgZXZ0IDAwMDAKLWh1YiA0LTA6MS4wOiBodWJfcmVzdW1lCi1odWIgNC0wOjEu
MDogc3RhdGUgNyBwb3J0cyAyIGNoZyAwMDAwIGV2dCAwMDAwCi1odWIgMy0wOjEuMDogaHVi
X3N1c3BlbmQKLXVzYiB1c2IzOiBidXMgYXV0by1zdXNwZW5kLCB3YWtldXAgMQotaHViIDQt
MDoxLjA6IGh1Yl9zdXNwZW5kCi11c2IgdXNiNDogYnVzIGF1dG8tc3VzcGVuZCwgd2FrZXVw
IDEKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6
MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlz
YWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1F
IyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVw
b3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJs
ZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6
MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlz
YWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1F
IyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVw
b3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJs
ZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6
MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlz
YWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1F
IyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVw
b3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJs
ZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6
MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlz
YWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1F
IyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVw
b3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJs
ZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6
MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlz
YWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1F
IyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVw
b3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJs
ZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6
MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlz
YWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1F
IyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVw
b3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJs
ZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVk
CiBmaXJld2lyZV9jb3JlIDAwMDA6MTE6MDAuMDogcGh5IGNvbmZpZzogbmV3IHJvb3Q9ZmZj
MSwgZ2FwX2NvdW50PTUKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAor
cGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJs
ZWQKIGZpcmV3aXJlX2NvcmUgMDAwMDoxMTowMC4wOiBjcmVhdGVkIGRldmljZSBmdzE6IEdV
SUQgMDAxMDEwMDU1MDAwMTFiOCwgUzQwMAogc2NzaTYgOiBTQlAtMiBJRUVFLTEzOTQKIGZp
cmV3aXJlX3NicDIgZncxLjA6IGxvZ2dlZCBpbiB0byBMVU4gMDAwMCAoMCByZXRyaWVzKQpA
QCAtMTIwMiwxNiArMTEzOSw1MTYgQEAKIHNkIDY6MDowOjA6IFtzZGJdIE1pc3NpbmcgaGVh
ZGVyIGluIE1PREVfU0VOU0UgcmVzcG9uc2UKIHNkIDY6MDowOjA6IFtzZGJdIFdyaXRlIGNh
Y2hlOiBlbmFibGVkLCByZWFkIGNhY2hlOiBlbmFibGVkLCBkb2Vzbid0IHN1cHBvcnQgRFBP
IG9yIEZVQQogc2QgNjowOjA6MDogW3NkYl0gTWlzc2luZyBoZWFkZXIgaW4gTU9ERV9TRU5T
RSByZXNwb25zZQorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40
OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAor
cGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2Fi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAogIHNkYjogc2RiMQog
c2QgNjowOjA6MDogW3NkYl0gTWlzc2luZyBoZWFkZXIgaW4gTU9ERV9TRU5TRSByZXNwb25z
ZQogc2QgNjowOjA6MDogW3NkYl0gQXR0YWNoZWQgU0NTSSBkaXNrCi11c2IgdXNiMzogdXNi
IGF1dG8tcmVzdW1lCi1odWIgMy0wOjEuMDogaHViX3Jlc3VtZQotdXNiIHVzYjQ6IHVzYiBh
dXRvLXJlc3VtZQotaHViIDMtMDoxLjA6IHN0YXRlIDcgcG9ydHMgMiBjaGcgMDAwMCBldnQg
MDAwMAotaHViIDQtMDoxLjA6IGh1Yl9yZXN1bWUKLWh1YiA0LTA6MS4wOiBzdGF0ZSA3IHBv
cnRzIDIgY2hnIDAwMDAgZXZ0IDAwMDAKLWh1YiAzLTA6MS4wOiBodWJfc3VzcGVuZAotdXNi
IHVzYjM6IGJ1cyBhdXRvLXN1c3BlbmQsIHdha2V1cCAxCi1odWIgNC0wOjEuMDogaHViX3N1
c3BlbmQKLXVzYiB1c2I0OiBidXMgYXV0by1zdXNwZW5kLCB3YWtldXAgMQorcGNpZXBvcnQg
MDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40
OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAor
cGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2Fi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAw
MDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQ
TUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNp
ZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDow
MDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5h
YmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUj
IGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBv
cnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDox
Yy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxl
ZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRp
c2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQg
MDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40
OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAor
cGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2Fi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAw
MDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQ
TUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNp
ZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDow
MDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5h
YmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUj
IGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBv
cnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDox
Yy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxl
ZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRp
c2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQg
MDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40
OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAor
cGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2Fi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAw
MDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQ
TUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNp
ZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDow
MDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5h
YmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUj
IGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBv
cnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDox
Yy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxl
ZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRp
c2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQg
MDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40
OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAor
ZmlyZXdpcmVfb2hjaSAwMDAwOjExOjAwLjA6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNzogUE1FIyBlbmFibGVkCitzZCA2OjA6MDowOiBbc2RiXSBTeW5jaHJvbml6
aW5nIFNDU0kgY2FjaGUKK3NkIDY6MDowOjA6IFtzZGJdICAKK1Jlc3VsdDogaG9zdGJ5dGU9
RElEX0JVU19CVVNZIGRyaXZlcmJ5dGU9RFJJVkVSX09LCitzZCA2OjA6MDowOiBbc2RiXSBT
dG9wcGluZyBkaXNrCitzZCA2OjA6MDowOiBbc2RiXSBTVEFSVF9TVE9QIEZBSUxFRAorc2Qg
NjowOjA6MDogW3NkYl0gIAorUmVzdWx0OiBob3N0Ynl0ZT1ESURfQlVTX0JVU1kgZHJpdmVy
Ynl0ZT1EUklWRVJfT0sKK2ZpcmV3aXJlX3NicDIgZncxLjA6IHJlbGVhc2VkIHRhcmdldCA2
OjA6MAorZmlyZXdpcmVfb2hjaSAwMDAwOjExOjAwLjA6IHJlbW92ZWQgZnctb2hjaSBkZXZp
Y2UKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAw
MDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBk
aXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQ
TUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNp
ZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDow
MDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNh
YmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUj
IGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBv
cnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDox
Yy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxl
ZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6
MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVu
YWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQg
MDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1F
IyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVw
b3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40
OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAor
cGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJs
ZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAw
MDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBk
aXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQ
TUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNp
ZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDow
MDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNh
YmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUj
IGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBv
cnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDox
Yy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxl
ZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6
MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVu
YWJsZWQKK1N5c1JxIDogRW1lcmdlbmN5IFN5bmMKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxlZAorcGNpZXBvcnQgMDAwMDowMDox
Yy40OiBQTUUjIGVuYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBkaXNhYmxl
ZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGVuYWJsZWQKK0VtZXJnZW5jeSBTeW5j
IGNvbXBsZXRlCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVw
b3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJs
ZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6
MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlz
YWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1F
IyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVw
b3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJs
ZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6
MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlz
YWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1F
IyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVw
b3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJs
ZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6
MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlz
YWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1F
IyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVw
b3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJs
ZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDog
UE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3Bj
aWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVk
CitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6
MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlz
YWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1F
IyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVw
b3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6
MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJs
ZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBl
bmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0
IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAw
MDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitTeXNScSA6IEVtZXJnZW5jeSBTeW5jCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQKK3BjaWVwb3J0IDAwMDA6MDA6MWMu
NDogUE1FIyBlbmFibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZGlzYWJsZWQK
K3BjaWVwb3J0IDAwMDA6MDA6MWMuNDogUE1FIyBlbmFibGVkCitTeXNScSA6IEVtZXJnZW5j
eSBTeW5jCitFbWVyZ2VuY3kgU3luYyBjb21wbGV0ZQorRW1lcmdlbmN5IFN5bmMgY29tcGxl
dGUKK1N5c1JxIDogU2hvdyBCbG9ja2VkIFN0YXRlCisgIHRhc2sgICAgICAgICAgICAgICAg
ICAgICAgICBQQyBzdGFjayAgIHBpZCBmYXRoZXIKK1NjaGVkIERlYnVnIFZlcnNpb246IHYw
LjEwLCAzLjcuMTAtZGVmYXVsdCAjMgora3RpbWUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDogMjgzMzEyLjA3MTYwOAorc2NoZWRfY2xrICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDogMjgyOTkzLjIwMDc5MQorY3B1X2NsayAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDogMjgyOTkzLjIwMDgyMgoramlmZmllcyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDogNDI5NDk2NTYyNworc2NoZWRfY2xvY2tfc3RhYmxlICAg
ICAgICAgICAgICAgICAgICAgIDogMQorCitzeXNjdGxfc2NoZWQKKyAgLnN5c2N0bF9zY2hl
ZF9sYXRlbmN5ICAgICAgICAgICAgICAgICAgICA6IDEyLjAwMDAwMAorICAuc3lzY3RsX3Nj
aGVkX21pbl9ncmFudWxhcml0eSAgICAgICAgICAgIDogMS41MDAwMDAKKyAgLnN5c2N0bF9z
Y2hlZF93YWtldXBfZ3JhbnVsYXJpdHkgICAgICAgICA6IDIuMDAwMDAwCisgIC5zeXNjdGxf
c2NoZWRfY2hpbGRfcnVuc19maXJzdCAgICAgICAgICAgOiAxCisgIC5zeXNjdGxfc2NoZWRf
ZmVhdHVyZXMgICAgICAgICAgICAgICAgICAgOiAxMjA5MQorICAuc3lzY3RsX3NjaGVkX3R1
bmFibGVfc2NhbGluZyAgICAgICAgICAgIDogMSAobG9nYXJpdG1pYykKKworIE1IegorICAu
bnJfcnVubmluZyAgICAgICAgICAgICAgICAgICAgOiAwCisgIC5sb2FkICAgICAgICAgICAg
ICAgICAgICAgICAgICA6IDAKKyAgLm5yX3N3aXRjaGVzICAgICAgICAgICAgICAgICAgIDog
NTE1NTgKKyAgLm5yX2xvYWRfdXBkYXRlcyAgICAgICAgICAgICAgIDogMTQ2NjUKKyAgLm5y
X3VuaW50ZXJydXB0aWJsZSAgICAgICAgICAgIDogLTM4CisgIC5uZXh0X2JhbGFuY2UgICAg
ICAgICAgICAgICAgICA6IDQyOTQuOTY1NjE5CisgIC5jdXJyLT5waWQgICAgICAgICAgICAg
ICAgICAgICA6IDAKKyAgLmNsb2NrICAgICAgICAgICAgICAgICAgICAgICAgIDogMjgyOTAx
LjMxOTc1MAorICAuY3B1X2xvYWRbMF0gICAgICAgICAgICAgICAgICAgOiAwCisgIC5jcHVf
bG9hZFsxXSAgICAgICAgICAgICAgICAgICA6IDAKKyAgLmNwdV9sb2FkWzJdICAgICAgICAg
ICAgICAgICAgIDogMAorICAuY3B1X2xvYWRbM10gICAgICAgICAgICAgICAgICAgOiAxNwor
ICAuY3B1X2xvYWRbNF0gICAgICAgICAgICAgICAgICAgOiA0NQorICAueWxkX2NvdW50ICAg
ICAgICAgICAgICAgICAgICAgOiAwCisgIC5zY2hlZF9jb3VudCAgICAgICAgICAgICAgICAg
ICA6IDUyNjE0CisgIC5zY2hlZF9nb2lkbGUgICAgICAgICAgICAgICAgICA6IDE0NDcyCisg
IC5hdmdfaWRsZSAgICAgICAgICAgICAgICAgICAgICA6IDEwMDAwMDAKKyAgLnR0d3VfY291
bnQgICAgICAgICAgICAgICAgICAgIDogMjg5ODAKKyAgLnR0d3VfbG9jYWwgICAgICAgICAg
ICAgICAgICAgIDogMjQ2NTIKKworCisgIC5leGVjX2Nsb2NrICAgICAgICAgICAgICAgICAg
ICA6IDE1Njk2LjU0OTkyMworICAuTUlOX3ZydW50aW1lICAgICAgICAgICAgICAgICAgOiAw
LjAwMDAwMQorICAubWluX3ZydW50aW1lICAgICAgICAgICAgICAgICAgOiAyMzQ1OS41NDY4
NjEKKyAgLm1heF92cnVudGltZSAgICAgICAgICAgICAgICAgIDogMC4wMDAwMDEKKyAgLnNw
cmVhZCAgICAgICAgICAgICAgICAgICAgICAgIDogMC4wMDAwMDAKKyAgLnNwcmVhZDAgICAg
ICAgICAgICAgICAgICAgICAgIDogMC4wMDAwMDAKKyAgLm5yX3NwcmVhZF9vdmVyICAgICAg
ICAgICAgICAgIDogNgorICAubnJfcnVubmluZyAgICAgICAgICAgICAgICAgICAgOiAwCisg
IC5sb2FkICAgICAgICAgICAgICAgICAgICAgICAgICA6IDAKKworCisgIC5ydF9ucl9ydW5u
aW5nICAgICAgICAgICAgICAgICA6IDAKKyAgLnJ0X3Rocm90dGxlZCAgICAgICAgICAgICAg
ICAgIDogMAorICAucnRfdGltZSAgICAgICAgICAgICAgICAgICAgICAgOiAwLjAwMDAwMAor
ICAucnRfcnVudGltZSAgICAgICAgICAgICAgICAgICAgOiA5NTAuMDAwMDAwCisKKworayAg
IFBJRCAgICAgICAgIHRyZWUta2V5ICBzd2l0Y2hlcyAgcHJpbyAgICAgZXhlYy1ydW50aW1l
ICAgICAgICAgc3VtLWV4ZWMgICAgICAgIHN1bS1zbGVlcAorLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQorCisgTUh6CisgIC5ucl9ydW5uaW5nICAgICAgICAgICAg
ICAgICAgICA6IDAKKyAgLmxvYWQgICAgICAgICAgICAgICAgICAgICAgICAgIDogMAorICAu
bnJfc3dpdGNoZXMgICAgICAgICAgICAgICAgICAgOiA0NzcxMworICAubnJfbG9hZF91cGRh
dGVzICAgICAgICAgICAgICAgOiAxMzY2OAorICAubnJfdW5pbnRlcnJ1cHRpYmxlICAgICAg
ICAgICAgOiAzOAorICAubmV4dF9iYWxhbmNlICAgICAgICAgICAgICAgICAgOiA0Mjk0Ljk2
NTYyMworICAuY3Vyci0+cGlkICAgICAgICAgICAgICAgICAgICAgOiAwCisgIC5jbG9jayAg
ICAgICAgICAgICAgICAgICAgICAgICA6IDI4Mjk0MS4zMjc1MzIKKyAgLmNwdV9sb2FkWzBd
ICAgICAgICAgICAgICAgICAgIDogMAorICAuY3B1X2xvYWRbMV0gICAgICAgICAgICAgICAg
ICAgOiAwCisgIC5jcHVfbG9hZFsyXSAgICAgICAgICAgICAgICAgICA6IDAKKyAgLmNwdV9s
b2FkWzNdICAgICAgICAgICAgICAgICAgIDogMworICAuY3B1X2xvYWRbNF0gICAgICAgICAg
ICAgICAgICAgOiAxNgorICAueWxkX2NvdW50ICAgICAgICAgICAgICAgICAgICAgOiAwCisg
IC5zY2hlZF9jb3VudCAgICAgICAgICAgICAgICAgICA6IDQ4NzI1CisgIC5zY2hlZF9nb2lk
bGUgICAgICAgICAgICAgICAgICA6IDEzNDQyCisgIC5hdmdfaWRsZSAgICAgICAgICAgICAg
ICAgICAgICA6IDEwMDAwMDAKKyAgLnR0d3VfY291bnQgICAgICAgICAgICAgICAgICAgIDog
MjYzNjkKKyAgLnR0d3VfbG9jYWwgICAgICAgICAgICAgICAgICAgIDogMjE1MDgKKworCisg
IC5leGVjX2Nsb2NrICAgICAgICAgICAgICAgICAgICA6IDI1NDEwLjUxODE4NAorICAuTUlO
X3ZydW50aW1lICAgICAgICAgICAgICAgICAgOiAwLjAwMDAwMQorICAubWluX3ZydW50aW1l
ICAgICAgICAgICAgICAgICAgOiAxNDM1NzQuNjYyNzgwCisgIC5tYXhfdnJ1bnRpbWUgICAg
ICAgICAgICAgICAgICA6IDAuMDAwMDAxCisgIC5zcHJlYWQgICAgICAgICAgICAgICAgICAg
ICAgICA6IDAuMDAwMDAwCisgIC5zcHJlYWQwICAgICAgICAgICAgICAgICAgICAgICA6IDEy
MDExNS4xMTU5MTkKKyAgLm5yX3NwcmVhZF9vdmVyICAgICAgICAgICAgICAgIDogMTAKKyAg
Lm5yX3J1bm5pbmcgICAgICAgICAgICAgICAgICAgIDogMAorICAubG9hZCAgICAgICAgICAg
ICAgICAgICAgICAgICAgOiAwCisKKworICAucnRfbnJfcnVubmluZyAgICAgICAgICAgICAg
ICAgOiAwCisgIC5ydF90aHJvdHRsZWQgICAgICAgICAgICAgICAgICA6IDAKKyAgLnJ0X3Rp
bWUgICAgICAgICAgICAgICAgICAgICAgIDogMC4wMDAwMDAKKyAgLnJ0X3J1bnRpbWUgICAg
ICAgICAgICAgICAgICAgIDogOTUwLjAwMDAwMAorCisKK2sgICBQSUQgICAgICAgICB0cmVl
LWtleSAgc3dpdGNoZXMgIHByaW8gICAgIGV4ZWMtcnVudGltZSAgICAgICAgIHN1bS1leGVj
ICAgICAgICBzdW0tc2xlZXAKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KKworcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAw
MDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUj
IGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBv
cnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6
IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitw
Y2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDox
Yy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxl
ZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAw
OjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRp
c2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQg
MDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBN
RSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2ll
cG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40
OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAor
cGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAw
OjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2Fi
bGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAw
MDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMg
ZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9y
dCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNpZXBvcnQgMDAwMDowMDoxYy40OiBQ
TUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IFBNRSMgZW5hYmxlZAorcGNp
ZXBvcnQgMDAwMDowMDoxYy40OiBQTUUjIGRpc2FibGVkCitwY2llcG9ydCAwMDAwOjAwOjFj
LjQ6IFBNRSMgZW5hYmxlZAo=
--------------020504020802030908070901--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
