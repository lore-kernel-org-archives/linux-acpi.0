From: Laszlo 'GCS' Boszormenyi <gcs-gKC9iF2I70U@public.gmane.org>
Subject: gericom notebook reboots instead of poweroff
Date: Tue, 26 Oct 2004 21:40:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041026194029.GA10954@pooh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

 I have a Gericom 1st supersonic (PIII 1.2Ghz) laptop, running Debian
Sarge (up-to-date). I have it since ~2.4.14, and until 2.6.8.1 the
'halt' command shut down the machine correctly. Starting with 2.6.8.1-bk1
it reboots. :( I realize that -bk1 has a big ACPI update, which may be
the problem IMHO.
 I have tried to look into existing bugreports, but could not find any
similar to this on the Kernel Bugzilla nor in the ACPI Bugzilla. All I
could found some note that Local APIC can cause problems, but even if I
disable that, the problem remains. Asked LKML without any reply; hope
here I can get some help, so if you need more information about it,
please let me know.
Some maybe relevant bits from the machine:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e0000000-e00fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


A dmesg between a working 2.6.8.1 and 2.6.8.1-bk1 reveals only minor(?)
things:
 Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
-CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
+CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000
+CPU: After vendor identify, caps:  0383f9ff 00000000 00000000 00000000
 CPU: L1 I cache: 16K, L1 D cache: 16K
 CPU: L2 cache: 256K
-CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
+CPU: After all inits, caps:        0383f9ff 00000000 00000000 00000040
 Intel machine check architecture supported.
[...]
-enabled ExtINT on CPU#0
-ESR value before enabling vector: 00000000
-ESR value after enabling vector: 00000000
-Using local APIC timer interrupts.
-calibrating APIC timer ...
-..... CPU clock speed is 1199.0574 MHz.
-..... host bus clock speed is 133.0285 MHz.
+ACPI: IRQ9 SCI: Edge set to Level Trigger.
 NET: Registered protocol family 16
 PCI: PCI BIOS revision 2.10 entry at 0xfd84e, last bus=1
 PCI: Using configuration type 1
 mtrr: v2.0 (20020519)
-ACPI: Subsystem revision 20040326
-ACPI: IRQ9 SCI: Edge set to Level Trigger.
+ACPI: Subsystem revision 20040715
[...]
 Initializing Cryptographic API
-PCI: Disabling Via external APIC routing
 PCI: Via IRQ fixup for 0000:00:07.5, from 255 to 5

Anyone have at least a shot what can cause this problem?
I would be happy to try out patches or back out ones from -bk1 if
needed.

Any help is greatly appreciated in advance,
Laszlo/GCS



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
