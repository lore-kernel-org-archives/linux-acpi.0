From: Lars Amsel <mailinglisten-Ztphx+FISXizQB+pC5nmwQ@public.gmane.org>
Subject: Still problems with ACPI sleep state
Date: Fri, 25 Jun 2004 15:47:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406251547.21050.mailinglisten@merula.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi,

I wrote some questions some week ago and since then I tried several things. I 
have a Fujitsu-Siemens Amilo L6820 with Fedora Core 2.

First I tried to repair my DSDT but I had no success with that.

Then I updated to kernel 2.6.7-1.441. Since that the ac_adapter reports its 
state correct und S3 seems to work better but not right. I start the machine 
into runlevel 3 (no X11) an log in as root. Then I do a 

[root-uXme+rPq5IdZ5tFPsFZChg@public.gmane.org lars]# echo 3 > /proc/acpi/sleep

and the notebook goes into sleep mode (the red 'sleep-LED' is blinking). After 
that I can push the power button and the notebook comes back but the screen 
stays blank. I can log in via ssh from the outside.

Any hints what I can do to get a working display after restart (relevant parts 
of /var/log/messages and dmesg appended)? 

cheers

Lars

/var/log/message:
Jun 25 15:32:52 desperados kernel: Stopping tasks: 
===============================|
Jun 25 15:32:52 desperados kernel: eth0: remaining active for wake-on-lan
Jun 25 15:32:52 desperados kernel: zapping low mappings.
Jun 25 15:32:52 desperados kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 
9 (level, low) -> IRQ 9
Jun 25 15:32:52 desperados kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 
3 (level, low) -> IRQ 3
Jun 25 15:32:52 desperados kernel: ACPI: PCI interrupt 0000:01:0a.0[A] -> GSI 
9 (level, low) -> IRQ 9
Jun 25 15:32:52 desperados kernel: ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 
3 (level, low) -> IRQ 3
Jun 25 15:32:52 desperados kernel: eth0: Setting full-duplex based on 
negotiated link capability.
Jun 25 15:32:52 desperados kernel: Restarting tasks... done

dmesg | grep ACPI:
 BIOS-e820: 000000000f7d0000 - 000000000f7df000 (ACPI data)
 BIOS-e820: 000000000f7df000 - 000000000f800000 (ACPI NVS)
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x000f5540
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000309 MSFT 0x00000097) @ 0x0f7d0000
ACPI: FADT (v002 A M I  OEMFACP  0x10000309 MSFT 0x00000097) @ 0x0f7d0200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000309 MSFT 0x00000097) @ 0x0f7d0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x10000309 MSFT 0x00000097) @ 0x0f7df040
ACPI: DSDT (v001 UW____ 755II5__ 0x00000016 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 3
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:01:0a.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 3 (level, low) -> IRQ 3
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Thermal Zone [THRM] (75 C)
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: (supports S0 S3 S4 S5)
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: PCI interrupt 0000:01:0a.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 3 (level, low) -> IRQ 3



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
