From: Evan White <evwhite-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: ACPI seems to be functioning but not reporting events
Date: Mon, 11 Apr 2005 23:49:32 -0700 (PDT)
Message-ID: <20050412064932.45809.qmail@web31712.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I'm running Fedora Core 3 with kernel 2.6.10-1.770 on
a brand new Dell Inspiron laptop.  I have not
recompiled the kernel myself at any point (I'm a
relative newbie), but I'm pretty sure ACPI support is
automatically enabled in Fedora's kernel.  

I can see that it correctly monitors the various
states, but it does not report events.

For instance, by typing "cat
/proc/acpi/battery/BATO/state" I can see the battery
state ("charged"), and I can see that it monitors the
change to "discharging" when I unplug the AC adapter. 
However, it never reports the battery events in
/var/log/acpid, nor does it output anything when I
type "acpi_listen".

The same is true for the power button and for the lid
closing/opening: no event is registered in
/var/log/acpid or while running acpi_listen.

Below are some outputs that might help.  

Does anyone know how to get ACPI(D) to correctly
report all the supported events???

------------------------------------------
/var/log/acpid reads:

[Mon Apr 11 23:19:55 2005] starting up
[Mon Apr 11 23:19:55 2005] 6 rules loaded
[Mon Apr 11 23:37:54 2005] client connected from
8616[0:0]
[Mon Apr 11 23:37:54 2005] 1 client rule loaded

------------------------------------------
The output from dmesg | grep ACPI is:

ACPI: RSDP (v000 DELL                                 
) @ 0x000fc9b0
ACPI: RSDT (v001 DELL    CPi R   0x27d50204 ASL 
0x00000061) @ 0x7ffda7d3
ACPI: FADT (v001 DELL    CPi R   0x27d50204 ASL 
0x00000061) @ 0x7ffdb400
ACPI: MADT (v001 DELL    CPi R   0x27d50204 ASL 
0x00000047) @ 0x7ffdbc00
ACPI: MCFG (v016 DELL    CPi R   0x27d50204 ASL 
0x00000061) @ 0x7ffdbbc0
ACPI: BOOT (v001 DELL    CPi R   0x27d50204 ASL 
0x00000061) @ 0x7ffdb7c0
ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL
0x20030522) @ 0x7ffdabe6
ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL
0x20030522) @ 0x7ffdaa0e
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL
0x20030522) @ 0x7ffda813
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT
0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: setting ELCR to 0200 (from 0e80)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 *7 9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10
11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10
11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10
11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PCIE._PRT]
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
PCI: Using ACPI for IRQ routing
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THM] (35 C)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
ACPI: PCI interrupt 0000:00:1e.3[B] -> GSI 7 (level,
low) -> IRQ 7
ACPI wakeup devices:
ACPI: (supports S0 S3 S4 S4bios S5)
ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 7 (level,
low) -> IRQ 7
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 11 (level,
low) -> IRQ 11
ACPI: PCI interrupt 0000:03:03.0[A] -> GSI 7 (level,
low) -> IRQ 7
ACPI: PCI interrupt 0000:00:1e.2[A] -> GSI 11 (level,
low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[A] -> GSI 11 (level,
low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level,
low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 7 (level,
low) -> IRQ 7
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level,
low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 7
ACPI: PCI interrupt 0000:00:1d.3[D] -> GSI 7 (level,
low) -> IRQ 7
ACPI: PCI interrupt 0000:03:01.0[A] -> GSI 7 (level,
low) -> IRQ 7
ACPI: PCI interrupt 0000:03:01.1[B] -> GSI 9 (level,
low) -> IRQ 9
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level,
low) -> IRQ 11
ACPI: AC Adapter [AC] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Video Device [VID] (multi-head: yes  rom: no 
post: no)

------------------------------------------
The output from cat /var/log/messages | grep ACPI is:

Apr 11 17:07:11 localhost kernel: ACPI: PM-Timer IO
Port: 0x1008
Apr 11 17:07:11 localhost kernel: ACPI: setting ELCR
to 0200 (from 0e80)
Apr 11 17:07:11 localhost kernel: ACPI: Subsystem
revision 20041105
Apr 11 17:07:11 localhost kernel: ACPI: Interpreter
enabled
Apr 11 17:07:11 localhost kernel: ACPI: Using PIC for
interrupt routing
Apr 11 17:07:11 localhost kernel: ACPI: PCI Root
Bridge [PCI0] (00:00)
Apr 11 17:07:11 localhost kernel: ACPI: PCI Interrupt
Link [LNKA] (IRQs 9 10 *11)
Apr 11 17:07:11 localhost kernel: ACPI: PCI Interrupt
Link [LNKB] (IRQs 5 7) *10Apr 11 17:07:11 localhost
kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10
11)
Apr 11 17:07:12 localhost kernel: ACPI: PCI Interrupt
Link [LNKD] (IRQs 5 *7 9 10 11)
Apr 11 17:07:12 localhost kernel: ACPI: PCI Interrupt
Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
Apr 11 17:07:12 localhost kernel: ACPI: PCI Interrupt
Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
Apr 11 17:07:12 localhost kernel: ACPI: PCI Interrupt
Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
Apr 11 17:07:12 localhost kernel: pnp: PnP ACPI init
Apr 11 17:07:12 localhost kernel: pnp: PnP ACPI: found
10 devices
Apr 11 17:07:12 localhost kernel: PCI: Using ACPI for
IRQ routing
Apr 11 17:07:16 localhost kernel: ACPI: Processor
[CPU0] (supports C1 C2 C3)
Apr 11 17:07:16 localhost kernel: ACPI: Processor
[CPU0] (supports 8 throttling states)
Apr 11 17:07:16 localhost kernel: ACPI: Thermal Zone
[THM] (35 C)
Apr 11 17:07:17 localhost kernel: ACPI: PCI Interrupt
Link [LNKB] enabled at IRQ 7
Apr 11 17:07:17 localhost kernel: ACPI: PCI interrupt
0000:00:1e.3[B] -> GSI 7 (level, low) -> IRQ 7
Apr 11 17:07:19 localhost kernel: ACPI wakeup devices:
Apr 11 17:07:21 localhost kernel: ACPI: (supports S0
S3 S4 S4bios S5)
Apr 11 17:07:24 localhost kernel: ACPI: PCI interrupt
0000:00:1f.2[B] -> GSI 7 (level, low) -> IRQ 7
Apr 11 17:07:26 localhost kernel: ACPI: PCI Interrupt
Link [LNKA] enabled at IRQ 11
Apr 11 17:07:26 localhost kernel: ACPI: PCI interrupt
0000:03:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Apr 11 17:07:26 localhost kernel: ACPI: PCI interrupt
0000:03:03.0[A] -> GSI 7 (level, low) -> IRQ 7
Apr 11 17:07:26 localhost kernel: ACPI: PCI interrupt
0000:00:1e.2[A] -> GSI 11 (level, low) -> IRQ 11
Apr 11 17:07:26 localhost kernel: ACPI: PCI interrupt
0000:00:1d.7[A] -> GSI 11 (level, low) -> IRQ 11
Apr 11 17:07:26 localhost kernel: ACPI: PCI interrupt
0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
Apr 11 17:07:26 localhost kernel: ACPI: PCI interrupt
0000:00:1d.1[B] -> GSI 7 (level, low) -> IRQ 7
Apr 11 17:07:26 localhost kernel: ACPI: PCI Interrupt
Link [LNKC] enabled at IRQ 9
Apr 11 17:07:26 localhost kernel: ACPI: PCI interrupt
0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
Apr 11 17:07:26 localhost kernel: ACPI: PCI Interrupt
Link [LNKD] enabled at IRQ 7
Apr 11 17:07:26 localhost kernel: ACPI: PCI interrupt
0000:00:1d.3[D] -> GSI 7 (level, low) -> IRQ 7
Apr 11 17:07:26 localhost kernel: ACPI: PCI interrupt
0000:03:01.0[A] -> GSI 7 (level, low) -> IRQ 7
Apr 11 17:07:26 localhost kernel: ACPI: PCI interrupt
0000:03:01.1[B] -> GSI 9 (level, low) -> IRQ 9
Apr 11 17:07:27 localhost kernel: ACPI: PCI interrupt
0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Apr 11 17:07:27 localhost kernel: ACPI: AC Adapter
[AC] (off-line)
Apr 11 17:07:27 localhost kernel: ACPI: Battery Slot
[BAT0] (battery present)
Apr 11 17:07:27 localhost kernel: ACPI: Lid Switch
[LID]
Apr 11 17:07:27 localhost kernel: ACPI: Power Button
(CM) [PBTN]
Apr 11 17:07:27 localhost kernel: ACPI: Sleep Button
(CM) [SBTN]
Apr 11 17:07:27 localhost kernel: ACPI: Video Device
[VID] (multi-head: yes  rom: no  post: no)
------------------------------------------
output from cat /proc/acpi/battery/BAT0/state when
plugged in:


present:                 yes
capacity state:          ok
charging state:          charged
present rate:            1 mA
remaining capacity:      7200 mAh
present voltage:         12545 mV

------------------------------------------
output from cat /proc/acpi/battery/BAT0/state when
unplugged:


present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            2180 mA
remaining capacity:      6788 mAh
present voltage:         12343 mV



Please help!
~evan




		
__________________________________ 
Do you Yahoo!? 
Make Yahoo! your home page 
http://www.yahoo.com/r/hs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
