From: Mark Eaton <meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org>
Subject: ASUS W2 ACPI Error
Date: Wed, 3 Aug 2005 08:48:47 +1000
Message-ID: <200508030848.47674.meaton@vasco.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have just purchased this laptop, and whilst the ACPI seems to work almost 
flawlessly I get  the following message dozens of times a second in the 
system log

Aug  3 08:35:55 localhost kernel: Asus ACPI: Error reading LCD status

The hardware is

0000:00:00.0 Host bridge: Intel Corp. Mobile Memory Controller Hub (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 1977
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] #09 [2109]

0000:00:01.0 PCI bridge: Intel Corp. Mobile Memory Controller Hub PCI Express 
Port (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000cfff
        Memory behind bridge: fe900000-fe9fffff
        Prefetchable memory behind bridge: cff00000-dfefffff
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
        Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 
Enable-
        Capabilities: [a0] #10 [0141]

0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High 
Definition Audio Controller (rev 04)
        Subsystem: Asustek Computer, Inc.: Unknown device 1973
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at febfc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
        Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 1 (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 00000000-000fffff
        Prefetchable memory behind bridge: 0000000000000000-0000000000000000
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 
Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 1977
        Flags: bus master, medium devsel, latency 0, IRQ 23
        I/O ports at e800 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 1977
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at e880 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 1977
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at ec00 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 1977
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at febfbc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d4) (prog-if 01 
[Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=04, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fea00000-feafffff
        Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corp. 82801FBM (ICH6M) LPC Interface Bridge 
(rev 04)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 1977
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at ffa0 [size=16]

0000:01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 
5652 (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 1962
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        I/O ports at c000 [size=256]
        Memory at fe9f0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at fe9c0000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #10 [0001]
        Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-

0000:03:00.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit 
Ethernet 10/100/1000Base-T Adapter (rev 13)
        Subsystem: Asustek Computer, Inc.: Unknown device 173c
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
        Memory at feafc000 (32-bit, non-prefetchable) [size=16K]
        I/O ports at d800 [size=256]
        Expansion ROM at feac0000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data

0000:03:01.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
        Subsystem: Intel Corp.: Unknown device 2701
        Flags: bus master, medium devsel, latency 64, IRQ 16
        Memory at feafb000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2

0000:03:02.0 Multimedia controller: Philips Semiconductors SAA7133 Audio+video 
broadcast decoder (rev f0)
        Subsystem: Animation Technologies Inc.: Unknown device 0307
        Flags: bus master, medium devsel, latency 64, IRQ 16
        Memory at feafa800 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [40] Power Management version 2

0000:03:03.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
        Subsystem: Asustek Computer, Inc.: Unknown device 1977
        Flags: bus master, medium devsel, latency 168, IRQ 21
        Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=03, secondary=04, subordinate=07, sec-latency=176
        Memory window 0: 40400000-407ff000 (prefetchable)
        Memory window 1: 40800000-40bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

0000:03:03.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller 
(rev 08) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 1977
        Flags: bus master, medium devsel, latency 64, IRQ 22
        Memory at feaf9000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2

0000:03:03.2 0805: Ricoh Co Ltd: Unknown device 0822 (rev 17)
        Subsystem: Asustek Computer, Inc.: Unknown device 1977
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at feaf9c00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

0000:03:03.3 System peripheral: Ricoh Co Ltd: Unknown device 0592 (rev 08)
        Subsystem: Asustek Computer, Inc.: Unknown device 1977
        Flags: medium devsel, IRQ 5
        Memory at feafa000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

0000:03:03.4 System peripheral: Ricoh Co Ltd: Unknown device 0852 (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 1977
        Flags: medium devsel, IRQ 5
        Memory at feafa400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2


-- 
Mark Eaton
Senior Software Engineer
+61 7 3511 5404
meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org
VASCO Data Security Pty Ltd


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
