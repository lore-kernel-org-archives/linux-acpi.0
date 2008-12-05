From: Matthias Heinz <mheinz@cs.uni-frankfurt.de>
Subject: Re: samsung x360, acpi support
Date: Fri, 5 Dec 2008 20:36:13 +0100
Message-ID: <200812052036.14556.mheinz@cs.uni-frankfurt.de>
References: <200812041915.39971.mheinz@cs.uni-frankfurt.de> <1228439157.7929.28.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uKYOJs4j6VfEf33"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.rbi.informatik.uni-frankfurt.de ([141.2.1.1]:47226 "EHLO
	hera.rbi.informatik.uni-frankfurt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752641AbYLETg1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Dec 2008 14:36:27 -0500
In-Reply-To: <1228439157.7929.28.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

--Boundary-00=_uKYOJs4j6VfEf33
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Freitag, 5. Dezember 2008 schrieb Zhang Rui:
> via the procfs/sysfs backlight I/F?

Yes

> please attach the result of
> "grep . /proc/acpi/video/*/*/*" both in 2.6.26 kernel and 2.6.28-rc7
> kernel.

2.6.26:
/proc/acpi/video/GFX0/DD01/brightness:<not supported>
/proc/acpi/video/GFX0/DD01/EDID:<not supported>
/proc/acpi/video/GFX0/DD01/info:device_id:    0x0100
/proc/acpi/video/GFX0/DD01/info:type:         UNKNOWN
/proc/acpi/video/GFX0/DD01/info:known by bios: no
/proc/acpi/video/GFX0/DD01/state:state:     0x1d
/proc/acpi/video/GFX0/DD01/state:query:     0x00
/proc/acpi/video/GFX0/DD02/brightness:<not supported>
/proc/acpi/video/GFX0/DD02/EDID:<not supported>
/proc/acpi/video/GFX0/DD02/info:device_id:    0x0240
/proc/acpi/video/GFX0/DD02/info:type:         UNKNOWN
/proc/acpi/video/GFX0/DD02/info:known by bios: no
/proc/acpi/video/GFX0/DD02/state:state:     0x1d
/proc/acpi/video/GFX0/DD02/state:query:     0x00
/proc/acpi/video/GFX0/DD03/brightness:<not supported>
/proc/acpi/video/GFX0/DD03/EDID:<not supported>
/proc/acpi/video/GFX0/DD03/info:device_id:    0x0320
/proc/acpi/video/GFX0/DD03/info:type:         UNKNOWN
/proc/acpi/video/GFX0/DD03/info:known by bios: no
/proc/acpi/video/GFX0/DD03/state:state:     0x1d
/proc/acpi/video/GFX0/DD03/state:query:     0x00
/proc/acpi/video/GFX0/DD04/brightness:levels:  100 5 10 20 35 50 65 85
/proc/acpi/video/GFX0/DD04/brightness:current: 10
/proc/acpi/video/GFX0/DD04/EDID:<not supported>
/proc/acpi/video/GFX0/DD04/info:device_id:    0x0410
/proc/acpi/video/GFX0/DD04/info:type:         UNKNOWN
/proc/acpi/video/GFX0/DD04/info:known by bios: no
/proc/acpi/video/GFX0/DD04/state:state:     0x1d
/proc/acpi/video/GFX0/DD04/state:query:     0x00
/proc/acpi/video/GFX0/DD05/brightness:<not supported>
/proc/acpi/video/GFX0/DD05/EDID:<not supported>
/proc/acpi/video/GFX0/DD05/info:device_id:    0x0005
/proc/acpi/video/GFX0/DD05/info:type:         UNKNOWN
/proc/acpi/video/GFX0/DD05/info:known by bios: no
/proc/acpi/video/GFX0/DD05/state:state:     0x1d
/proc/acpi/video/GFX0/DD05/state:query:     0x00
/proc/acpi/video/NVID/CRT1/brightness:<not supported>
/proc/acpi/video/NVID/CRT1/EDID:<not supported>
/proc/acpi/video/NVID/CRT1/info:device_id:    0x0100
/proc/acpi/video/NVID/CRT1/info:type:         UNKNOWN
/proc/acpi/video/NVID/CRT1/info:known by bios: no
/proc/acpi/video/NVID/CRT1/state:state:     0x1f
/proc/acpi/video/NVID/CRT1/state:query:     0x00
/proc/acpi/video/NVID/DVI/brightness:<not supported>
/proc/acpi/video/NVID/DVI/EDID:<not supported>
/proc/acpi/video/NVID/DVI/info:device_id:    0x0120
/proc/acpi/video/NVID/DVI/info:type:         UNKNOWN
/proc/acpi/video/NVID/DVI/info:known by bios: no
/proc/acpi/video/NVID/DVI/state:state:     0x1d
/proc/acpi/video/NVID/DVI/state:query:     0x00
/proc/acpi/video/NVID/LCD/brightness:levels:  10 30 40 50 60 70 80 100
/proc/acpi/video/NVID/LCD/brightness:current: 100
/proc/acpi/video/NVID/LCD/EDID:<not supported>
/proc/acpi/video/NVID/LCD/info:device_id:    0x0110
/proc/acpi/video/NVID/LCD/info:type:         UNKNOWN
/proc/acpi/video/NVID/LCD/info:known by bios: no
/proc/acpi/video/NVID/LCD/state:state:     0x1f
/proc/acpi/video/NVID/LCD/state:query:     0x00
/proc/acpi/video/NVID/TV/brightness:<not supported>
/proc/acpi/video/NVID/TV/EDID:<not supported>
/proc/acpi/video/NVID/TV/info:device_id:    0x0200
/proc/acpi/video/NVID/TV/info:type:         UNKNOWN
/proc/acpi/video/NVID/TV/info:known by bios: no
/proc/acpi/video/NVID/TV/state:state:     0x1d
/proc/acpi/video/NVID/TV/state:query:     0x00



2.6.28-rc7:
/proc/acpi/video/GFX0/DD01/brightness:<not supported>
/proc/acpi/video/GFX0/DD01/EDID:<not supported>
/proc/acpi/video/GFX0/DD01/info:device_id:    0x0100
/proc/acpi/video/GFX0/DD01/info:type:         UNKNOWN
/proc/acpi/video/GFX0/DD01/info:known by bios: no
/proc/acpi/video/GFX0/DD01/state:state:     0x1d
/proc/acpi/video/GFX0/DD01/state:query:     0x00
/proc/acpi/video/GFX0/DD02/brightness:<not supported>
/proc/acpi/video/GFX0/DD02/EDID:<not supported>
/proc/acpi/video/GFX0/DD02/info:device_id:    0x0240
/proc/acpi/video/GFX0/DD02/info:type:         UNKNOWN
/proc/acpi/video/GFX0/DD02/info:known by bios: no
/proc/acpi/video/GFX0/DD02/state:state:     0x1d
/proc/acpi/video/GFX0/DD02/state:query:     0x00
/proc/acpi/video/GFX0/DD03/brightness:<not supported>
/proc/acpi/video/GFX0/DD03/EDID:<not supported>
/proc/acpi/video/GFX0/DD03/info:device_id:    0x0320
/proc/acpi/video/GFX0/DD03/info:type:         UNKNOWN
/proc/acpi/video/GFX0/DD03/info:known by bios: no
/proc/acpi/video/GFX0/DD03/state:state:     0x1d
/proc/acpi/video/GFX0/DD03/state:query:     0x00
/proc/acpi/video/GFX0/DD04/brightness:levels:  100 5 10 20 35 50 65 85
/proc/acpi/video/GFX0/DD04/brightness:current: 10
/proc/acpi/video/GFX0/DD04/EDID:<not supported>
/proc/acpi/video/GFX0/DD04/info:device_id:    0x0410
/proc/acpi/video/GFX0/DD04/info:type:         UNKNOWN
/proc/acpi/video/GFX0/DD04/info:known by bios: no
/proc/acpi/video/GFX0/DD04/state:state:     0x1d
/proc/acpi/video/GFX0/DD04/state:query:     0x00
/proc/acpi/video/GFX0/DD05/brightness:<not supported>
/proc/acpi/video/GFX0/DD05/EDID:<not supported>
/proc/acpi/video/GFX0/DD05/info:device_id:    0x0005
/proc/acpi/video/GFX0/DD05/info:type:         UNKNOWN
/proc/acpi/video/GFX0/DD05/info:known by bios: no
/proc/acpi/video/GFX0/DD05/state:state:     0x1d
/proc/acpi/video/GFX0/DD05/state:query:     0x00



> please attach the "lspci -vvx" output.

done


> is this a regression?

kinda, because of the bad behaviour of X to grab all key events ;)

> i.e. the hotkey events are always sent to the 
> keyboard, right?

right. FYI:
atkbd.c: Unknown key pressed (translated set 2, code 0x83 on isa0060/serio0).
atkbd.c: Use 'setkeycodes e003 <keycode>' to make it known.


> please attach the output of "grep . /sys/firmware/acpi/interrupts/*".

/sys/firmware/acpi/interrupts/error:       0
/sys/firmware/acpi/interrupts/ff_gbl_lock:       0      enabled
/sys/firmware/acpi/interrupts/ff_pmtimer:       0       invalid
/sys/firmware/acpi/interrupts/ff_pwr_btn:       0       enabled
/sys/firmware/acpi/interrupts/ff_rt_clk:       0        disabled
/sys/firmware/acpi/interrupts/ff_slp_btn:       0       invalid
/sys/firmware/acpi/interrupts/gpe00:       0    invalid
/sys/firmware/acpi/interrupts/gpe01:       0    enabled
/sys/firmware/acpi/interrupts/gpe02:       0    invalid
/sys/firmware/acpi/interrupts/gpe03:       0    enabled
/sys/firmware/acpi/interrupts/gpe04:       0    enabled
/sys/firmware/acpi/interrupts/gpe05:       0    enabled
/sys/firmware/acpi/interrupts/gpe06:       0    enabled
/sys/firmware/acpi/interrupts/gpe07:       0    enabled
/sys/firmware/acpi/interrupts/gpe08:       0    invalid
/sys/firmware/acpi/interrupts/gpe09:       0    disabled
/sys/firmware/acpi/interrupts/gpe0A:       0    invalid
/sys/firmware/acpi/interrupts/gpe0B:       0    disabled
/sys/firmware/acpi/interrupts/gpe0C:       0    enabled
/sys/firmware/acpi/interrupts/gpe0D:       0    disabled
/sys/firmware/acpi/interrupts/gpe0E:       0    enabled
/sys/firmware/acpi/interrupts/gpe0F:       0    invalid
/sys/firmware/acpi/interrupts/gpe10:       0    invalid
/sys/firmware/acpi/interrupts/gpe11:       0    invalid
/sys/firmware/acpi/interrupts/gpe12:       0    invalid
/sys/firmware/acpi/interrupts/gpe13:       0    invalid
/sys/firmware/acpi/interrupts/gpe14:       0    invalid
/sys/firmware/acpi/interrupts/gpe15:       0    invalid
/sys/firmware/acpi/interrupts/gpe16:       0    invalid
/sys/firmware/acpi/interrupts/gpe17:     936    enabled
/sys/firmware/acpi/interrupts/gpe18:       0    enabled
/sys/firmware/acpi/interrupts/gpe19:       0    invalid
/sys/firmware/acpi/interrupts/gpe1A:       0    invalid
/sys/firmware/acpi/interrupts/gpe1B:       0    invalid
/sys/firmware/acpi/interrupts/gpe1C:       0    invalid
/sys/firmware/acpi/interrupts/gpe1D:       0    invalid
/sys/firmware/acpi/interrupts/gpe1E:       0    invalid
/sys/firmware/acpi/interrupts/gpe1F:       0    invalid
/sys/firmware/acpi/interrupts/gpe20:       0    enabled
/sys/firmware/acpi/interrupts/gpe21:       0    invalid
/sys/firmware/acpi/interrupts/gpe22:       0    invalid
/sys/firmware/acpi/interrupts/gpe23:       0    invalid
/sys/firmware/acpi/interrupts/gpe24:       0    invalid
/sys/firmware/acpi/interrupts/gpe25:       0    invalid
/sys/firmware/acpi/interrupts/gpe26:       0    invalid
/sys/firmware/acpi/interrupts/gpe27:       0    invalid
/sys/firmware/acpi/interrupts/gpe28:       0    invalid
/sys/firmware/acpi/interrupts/gpe29:       0    invalid
/sys/firmware/acpi/interrupts/gpe2A:       0    invalid
/sys/firmware/acpi/interrupts/gpe2B:       0    invalid
/sys/firmware/acpi/interrupts/gpe2C:       0    invalid
/sys/firmware/acpi/interrupts/gpe2D:       0    invalid
/sys/firmware/acpi/interrupts/gpe2E:       0    invalid
/sys/firmware/acpi/interrupts/gpe2F:       0    invalid
/sys/firmware/acpi/interrupts/gpe30:       0    invalid
/sys/firmware/acpi/interrupts/gpe31:       0    invalid
/sys/firmware/acpi/interrupts/gpe32:       0    invalid
/sys/firmware/acpi/interrupts/gpe33:       0    invalid
/sys/firmware/acpi/interrupts/gpe34:       0    invalid
/sys/firmware/acpi/interrupts/gpe35:       0    invalid
/sys/firmware/acpi/interrupts/gpe36:       0    invalid
/sys/firmware/acpi/interrupts/gpe37:       0    invalid
/sys/firmware/acpi/interrupts/gpe38:       0    invalid
/sys/firmware/acpi/interrupts/gpe39:       0    invalid
/sys/firmware/acpi/interrupts/gpe3A:       0    invalid
/sys/firmware/acpi/interrupts/gpe3B:       0    invalid
/sys/firmware/acpi/interrupts/gpe3C:       0    invalid
/sys/firmware/acpi/interrupts/gpe3D:       0    invalid
/sys/firmware/acpi/interrupts/gpe3E:       0    invalid
/sys/firmware/acpi/interrupts/gpe3F:       0    invalid
/sys/firmware/acpi/interrupts/gpe_all:     936
/sys/firmware/acpi/interrupts/sci:     936


> Btw: you'd better file a bug at bugzilla.kernel.org
> and attach all the info there.

I'll do this, too.


Regards,
Matthias

--Boundary-00=_uKYOJs4j6VfEf33
Content-Type: text/plain;
  charset="iso 8859-15";
  name="lspci-samsungx360.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci-samsungx360.txt"

00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory Controller Hub (rev 07)
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information <?>
        Kernel driver in use: agpgart-intel
00: 86 80 40 2a 06 01 90 20 07 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00

00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series Chipset Integrated Graphics Controller (rev 07) (prog-if 00 [VGA controller])
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 316
        Region 0: Memory at fc000000 (64-bit, non-prefetchable) [size=4M]
        Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
        Region 4: I/O ports at 1800 [size=8]
        Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
                Address: fee0300c  Data: 4181
        Capabilities: [d0] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 42 2a 07 04 90 00 07 00 00 03 00 00 80 00
10: 04 00 00 fc 00 00 00 00 0c 00 00 d0 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 90 00 00 00 00 00 00 00 0b 01 00 00

00:02.1 Display controller: Intel Corporation Mobile 4 Series Chipset Integrated Graphics Controller (rev 07)
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Region 0: Memory at fc400000 (64-bit, non-prefetchable) [size=1M]
        Capabilities: [d0] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 43 2a 07 00 90 00 07 00 80 03 00 00 80 00
10: 04 00 40 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00

00:1a.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #4 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at 1820 [size=32]
        Capabilities: [50] PCIe advanced features <?>
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd
00: 86 80 37 29 05 00 90 02 03 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 18 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00

00:1a.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #5 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at 1840 [size=32]
        Capabilities: [50] PCIe advanced features <?>
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd
00: 86 80 38 29 05 00 90 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 00 00

00:1a.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #6 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin C routed to IRQ 19
        Region 4: I/O ports at 1860 [size=32]
        Capabilities: [50] PCIe advanced features <?>
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd
00: 86 80 39 29 05 00 90 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 18 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 03 00 00

00:1a.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #2 (rev 03) (prog-if 20 [EHCI])
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin C routed to IRQ 19
        Region 0: Memory at fc704800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Capabilities: [98] PCIe advanced features <?>
        Kernel driver in use: ehci_hcd
        Kernel modules: ehci-hcd
00: 86 80 3c 29 06 00 90 02 03 20 03 0c 00 00 00 00
10: 00 48 70 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 03 00 00

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Controller (rev 03)
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at fc700000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE- FLReset+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
                        ClockPM- Suprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [130] Root Complex Link <?>
        Kernel driver in use: HDA Intel
00: 86 80 3e 29 06 00 10 00 03 00 03 04 10 00 00 00
10: 04 00 70 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 00 00

00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: f6000000-f7ffffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f1ffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 <4us
                        ClockPM- Suprise- LLActRep+ BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
                        Slot #  0, PowerLimit 6.500000; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet+ LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
                Address: fee0300c  Data: 4161
        Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c03e
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [180] Root Complex Link <?>
        Kernel driver in use: pcieport-driver
00: 86 80 40 29 07 04 10 00 03 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 03 00 20 20 00 00
20: 00 f6 f0 f7 01 f0 f1 f1 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 04 00

00:1c.2 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 3 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: 00000000f2000000-00000000f3ffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <4us
                        ClockPM- Suprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
                        Slot #  2, PowerLimit 6.500000; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn+ PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd Off, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
                Address: fee0300c  Data: 4169
        Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c03e
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [180] Root Complex Link <?>
        Kernel driver in use: pcieport-driver
00: 86 80 44 29 07 04 10 00 03 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 04 05 00 30 30 00 00
20: 00 f8 f0 f9 01 f2 f1 f3 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 03 04 00

00:1c.3 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 4 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=06, subordinate=07, sec-latency=0
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: fa000000-fbffffff
        Prefetchable memory behind bridge: 00000000f4000000-00000000f5ffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 <4us
                        ClockPM- Suprise- LLActRep+ BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
                        Slot #  3, PowerLimit 6.500000; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet+ LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
                Address: fee0300c  Data: 4171
        Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c03e
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [180] Root Complex Link <?>
        Kernel driver in use: pcieport-driver
00: 86 80 46 29 07 04 10 00 03 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 06 07 00 40 40 00 00
20: 00 fa f0 fb 01 f4 f1 f5 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 04 04 00

00:1d.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 4: I/O ports at 1880 [size=32]
        Capabilities: [50] PCIe advanced features <?>
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd
00: 86 80 34 29 05 00 90 02 03 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 18 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 00 00

00:1d.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at 18a0 [size=32]
        Capabilities: [50] PCIe advanced features <?>
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd
00: 86 80 35 29 05 00 90 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 18 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 02 00 00

00:1d.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at 18c0 [size=32]
        Capabilities: [50] PCIe advanced features <?>
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd
00: 86 80 36 29 05 00 90 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: c1 18 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 03 00 00

00:1d.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at fc704c00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Capabilities: [98] PCIe advanced features <?>
        Kernel driver in use: ehci_hcd
        Kernel modules: ehci-hcd
00: 86 80 3a 29 06 00 90 02 03 20 03 0c 00 00 00 00
10: 00 4c 70 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 00 00

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93) (prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] Subsystem: Samsung Electronics Co Ltd Device c03e
00: 86 80 48 24 07 00 10 00 93 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 08 08 00 f0 00 80 22
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 04 00

00:1f.0 ISA bridge: Intel Corporation ICH9M-E LPC Interface Controller (rev 03)
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information <?>
00: 86 80 17 29 07 00 10 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00

00:1f.2 SATA controller: Intel Corporation ICH9M/M-E SATA AHCI Controller (rev 03) (prog-if 01 [AHCI 1.0])
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 314
        Region 0: I/O ports at 1818 [size=8]
        Region 1: I/O ports at 180c [size=4]
        Region 2: I/O ports at 1810 [size=8]
        Region 3: I/O ports at 1808 [size=4]
        Region 4: I/O ports at 18e0 [size=32]
        Region 5: Memory at fc704000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/4 Enable+
                Address: fee0300c  Data: 4191
        Capabilities: [70] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a8] SATA HBA <?>
        Capabilities: [b0] PCIe advanced features <?>
        Kernel driver in use: ahci
00: 86 80 29 29 07 04 b0 02 03 01 06 01 00 00 00 00
10: 19 18 00 00 0d 18 00 00 11 18 00 00 09 18 00 00
20: e1 18 00 00 00 40 70 fc 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 03)
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 19
        Region 0: Memory at c0000000 (64-bit, non-prefetchable) [size=256]
        Region 4: I/O ports at 1c00 [size=32]
        Kernel driver in use: i801_smbus
        Kernel modules: i2c-i801
00: 86 80 30 29 03 00 80 02 03 00 05 0c 00 00 00 00
10: 04 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 1c 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 03 00 00

02:00.0 Network controller: Intel Corporation Wireless WiFi Link 5100
        Subsystem: Intel Corporation Device 1201
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f6000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <128ns, L1 <32us
                        ClockPM+ Suprise- LLActRep- BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100] Advanced Error Reporting <?>
        Capabilities: [140] Device Serial Number e4-09-93-ff-ff-5d-21-00
        Kernel driver in use: iwlagn
        Kernel modules: iwlagn
00: 86 80 32 42 02 00 10 00 00 00 80 02 10 00 00 00
10: 04 00 00 f6 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 01 12
30: 00 00 00 00 c8 00 00 00 00 00 00 00 0b 01 00 00

06:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8055 PCI-E Gigabit Ethernet Controller (rev 13)
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 315
        Region 0: Memory at fa000000 (64-bit, non-prefetchable) [size=16K]
        Region 2: I/O ports at 4000 [size=256]
        [virtual] Expansion ROM at f4000000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data <?>
        Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable+
                Address: 00000000fee0300c  Data: 4189
        Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend+
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 unlimited
                        ClockPM+ Suprise- LLActRep- BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 128 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100] Advanced Error Reporting <?>
        Kernel driver in use: sky2
00: ab 11 63 43 07 04 10 00 13 00 00 02 10 00 00 00
10: 04 00 00 fa 00 00 00 00 01 40 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 48 00 00 00 00 00 00 00 05 01 00 00

--Boundary-00=_uKYOJs4j6VfEf33--
