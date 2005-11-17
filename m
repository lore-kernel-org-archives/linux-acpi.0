From: Felix Homann <fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org>
Subject: Re: Flooded by button/lid events
Date: Thu, 17 Nov 2005 17:06:08 +0100
Message-ID: <200511171706.09132.fexpop@onlinehome.de>
References: <200511171006.58300.fexpop@onlinehome.de> <200511171634.03164.fexpop@onlinehome.de> <20051117153728.GA4613@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xpKfD1hxqN9PEgy"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051117153728.GA4613-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_xpKfD1hxqN9PEgy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 17 November 2005 16:37, Matthew Garrett wrote:
>
> And it carries on working after that? 

Yes, it does.

> In Linux, try doing an lspci -vxxx 
> before and after you get into the repeating event state. It's quite
> likely that there'll be a bit difference in the southbridge state.
>
> (Of course, it's possible that there is a bug in the Linux
> implementation - but it's probably more likely to be BIOS breakage)

I've done lspci -vxxx before, while and after reaching the repeating event 
state. diff doesn't show any differences. I've attached the output.

What does this mean?

Regards,

Felix

--Boundary-00=_xpKfD1hxqN9PEgy
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.txt"

0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] #09 [2109]
00: 86 80 90 25 06 01 90 20 03 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
40: 00 50 00 f0 00 00 00 f0 00 00 00 e0 00 40 00 f0
50: 00 00 02 00 13 00 00 b8 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 10 11 11 00 00 13 11 00 00 00 00 00 20 0a 39 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 14 00 00 00
e0: 09 00 09 21 42 e8 eb b0 0a 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 04 00 10 00 00 00

0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c8100000-c81fffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [a0] #10 [0141]
00: 86 80 91 25 07 04 10 00 03 00 04 06 08 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 30 30 00 00
20: 10 c8 10 c8 00 d0 f0 d7 00 00 00 00 00 00 00 00
30: 00 00 00 00 88 00 00 00 00 00 00 00 0a 01 0c 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
80: 01 90 02 c8 00 00 00 00 0d 80 00 00 25 10 66 00
90: 05 a0 01 00 04 10 e0 fe 41 40 00 00 00 00 00 00
a0: 10 00 41 01 00 00 00 00 00 00 00 00 01 2d 01 02
b0: 42 00 11 10 80 25 08 00 c0 01 48 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 01 00 00 00 00 00 00 00 04 00 00 00 80 b3

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
00: 86 80 60 26 04 00 10 00 04 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 09 09 00 f0 00 00 20
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 04 00
40: 10 80 41 01 e0 0f 00 00 00 00 10 00 11 4c 01 01
50: 00 00 01 10 e0 a0 10 00 08 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 0d a0 00 00 25 10 66 00 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 11 c0 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=0a, subordinate=0a, sec-latency=0
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
00: 86 80 62 26 04 00 10 00 04 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 0a 0a 00 f0 00 00 20
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 02 04 00
40: 10 80 41 01 e0 0f 00 00 00 00 10 00 11 4c 01 02
50: 00 00 01 10 e0 a0 18 00 08 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 0d a0 00 00 25 10 66 00 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 11 c0 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

0000:00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
00: 86 80 64 26 04 00 10 00 04 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 04 00 f0 00 00 20
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 03 04 00
40: 10 80 41 01 e0 0f 00 00 00 00 10 00 11 4c 01 03
50: 10 00 01 10 e0 a0 20 00 08 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 0d a0 00 00 25 10 66 00 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 80 00 11 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1800 [size=32]
00: 86 80 58 26 05 00 80 02 04 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 01 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1820 [size=32]
00: 86 80 59 26 05 00 80 02 04 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 18 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 01 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at 1840 [size=32]
00: 86 80 5a 26 05 00 80 02 04 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 01 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at 1860 [size=32]
00: 86 80 5b 26 05 00 80 02 04 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 18 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 01 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, medium devsel, latency 0, IRQ 11
	Memory at c8000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [20a0]
00: 86 80 5c 26 06 00 90 02 04 20 03 0c 00 00 00 00
10: 00 00 00 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 c2 c9 00 00 00 00 0a 00 a0 20 00 00 00 00
60: 20 20 ff 01 00 00 00 00 01 00 00 01 00 00 08 e0
70: 00 00 d7 3f 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 aa ff 00 55 55 ff 00 20 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 80 00 09 88 8c 40 00 80 0f 04 00 06 17 00 00

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, subordinate=07, sec-latency=216
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: c8200000-c82fffff
	Prefetchable memory behind bridge: 0000000030000000-0000000031f00000
	Capabilities: [50] #0d [0000]
00: 86 80 48 24 07 00 10 00 d4 01 04 06 00 00 81 00
10: 00 00 00 00 00 00 00 00 00 06 07 d8 40 40 80 22
20: 20 c8 20 c8 01 30 f1 31 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 04 00
40: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 0d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

0000:00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1c00 [size=256]
	I/O ports at 1880 [size=64]
	Memory at c8000800 (32-bit, non-prefetchable) [size=512]
	Memory at c8000400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
00: 86 80 6e 26 07 00 90 02 04 00 01 04 00 00 00 00
10: 01 1c 00 00 81 18 00 00 00 08 00 c8 00 04 00 c8
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00
40: 09 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 80 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

0000:00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Modem Controller (rev 04) (prog-if 00 [Generic])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at 2400 [size=256]
	I/O ports at 2000 [size=128]
	Capabilities: [50] Power Management version 2
00: 86 80 6d 26 05 00 90 02 04 00 03 07 00 00 00 00
10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 04)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, medium devsel, latency 0
00: 86 80 41 26 07 00 00 02 04 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 10 00 00 80 00 00 00 81 11 00 00 10 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0a 0b 0a 0b 90 00 00 00 0a 80 0a 0b 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 10 00 0e 3f 01 16 00 00 61 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: a0 06 00 00 00 00 00 00 00 1c 00 60 00 03 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 0a 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 33 22 11 00 67 45 00 00 cf ff 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 01 80 00 f0 00 00 00 00 80 0f 04 00 00 00 00 00

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 18c0 [size=16]
00: 86 80 6f 26 05 00 88 02 04 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: c1 18 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00
40: 77 e3 00 00 0b 00 00 00 03 00 21 00 00 00 00 00
50: 00 00 00 00 01 10 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: medium devsel, IRQ 11
	I/O ports at 20a0 [size=32]
00: 86 80 6a 26 01 00 80 02 04 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 20 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00
40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

0000:01:00.0 VGA compatible controller: ATI Technologies Inc M24 1P [Radeon Mobility X600] (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, fast devsel, latency 0, IRQ 10
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 3000 [size=256]
	Memory at c8100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at c8120000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #10 [0001]
	Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
00: 02 10 50 31 07 00 10 00 00 00 00 03 08 00 00 00
10: 08 00 00 d0 01 30 00 00 00 00 10 c8 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 66 00
50: 01 58 02 06 00 00 00 00 10 80 01 00 a0 04 2c 01
60: 10 09 00 00 01 ad 00 00 40 00 01 11 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:06:01.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at c8216000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=06, secondary=07, subordinate=08, sec-latency=176
	Memory window 0: 30000000-31fff000 (prefetchable)
	Memory window 1: 32000000-33fff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001
00: 4c 10 31 80 07 00 10 02 00 00 07 06 10 a8 82 00
10: 00 60 21 c8 a0 00 00 02 06 07 08 b0 00 00 00 30
20: 00 f0 ff 31 00 00 00 32 00 f0 ff 33 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 0b 01 c0 05
40: 25 10 66 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 d0 44 38 19 00 d3 02 00 00 0f 00 22 1b c2 01
90: c0 02 64 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 12 fe 00 00 c0 00 00 00 00 00 00 00 00 00
b0: 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:06:01.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394 Host Controller (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: medium devsel, IRQ 11
	Memory at c8217000 (32-bit, non-prefetchable) [size=2K]
	Memory at c8210000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
00: 4c 10 32 80 12 00 10 02 00 10 00 0c 08 20 80 00
10: 00 70 21 c8 00 00 21 c8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 03 04
40: 00 00 00 00 01 00 02 7e 00 00 00 00 00 00 00 00
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
f0: 00 00 00 00 82 10 00 00 25 10 66 00 00 00 00 00

0000:06:01.3 Mass storage controller: Texas Instruments PCIxx21 Integrated FlashMedia Controller
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: medium devsel, IRQ 11
	Memory at c8214000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [44] Power Management version 2
00: 4c 10 33 80 02 00 10 02 00 00 80 01 08 39 80 00
10: 00 40 21 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 66 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 07 04
40: 00 00 00 00 01 00 02 7e 00 00 00 00 00 00 00 00
50: 25 10 66 00 05 01 00 00 00 00 00 00 00 00 00 00
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

0000:06:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
	Subsystem: Intel Corporation: Unknown device 2701
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at c8219000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
00: 86 80 20 42 16 00 90 02 05 00 80 02 08 20 00 00
10: 00 90 21 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 01 27
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 03 18
40: 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 c8
e0: 00 20 00 13 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:06:08.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788 Gigabit Ethernet (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0066
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 10
	Memory at c8200000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
00: e4 14 9c 16 06 00 b0 02 03 00 00 02 08 20 00 00
10: 00 00 20 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 25 10 66 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 01 40 00
40: 00 00 00 00 00 00 00 00 01 50 02 c0 00 20 00 00
50: 03 58 fc 00 00 00 00 78 05 00 86 00 f4 ff ff bf
60: ff fd ff df ff ff 00 00 98 00 03 30 00 00 3f 76
70: f6 10 00 00 40 00 00 80 10 70 00 00 00 00 00 00
80: a8 b4 4b 7e 03 40 00 0c 34 00 13 04 82 90 09 04
90: 09 97 00 01 00 00 00 00 00 00 00 00 c8 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--Boundary-00=_xpKfD1hxqN9PEgy--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
