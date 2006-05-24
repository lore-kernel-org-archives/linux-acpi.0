From: Sebastian =?utf-8?q?R=C3=B6der?=
	<sebastian.roeder@uni-bielefeld.de>
Subject: Dell Inspiron 6000: Suspend with Fn + F1 keys using acpid
Date: Wed, 24 May 2006 12:19:46 +0200
Message-ID: <200605241219.46413.sebastian.roeder@uni-bielefeld.de>
References: <S932666AbWEXJol/20060524094441Z+163@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-relay2.uni-bielefeld.de ([129.70.4.98]:48532 "EHLO
	smtp-relay2.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S932253AbWEXKVy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 May 2006 06:21:54 -0400
Received: from pmxchannel-daemon.mail2.hrz.uni-bielefeld.de by
 mail2.hrz.uni-bielefeld.de
 (iPlanet Messaging Server 5.2 HotFix 2.09 (built Nov 18 2005))
 id <0IZR00L01M1I3B@mail2.hrz.uni-bielefeld.de> for linux-acpi@vger.kernel.org;
 Wed, 24 May 2006 12:20:06 +0200 (MEST)
Received: from [192.168.1.33] ([217.244.215.233]) by mail2.hrz.uni-bielefeld.de
 (iPlanet Messaging Server 5.2 HotFix 2.09 (built Nov 18 2005))
 with ESMTPPSA id <0IZR00B3SM1GR6@mail2.hrz.uni-bielefeld.de> for
 linux-acpi@vger.kernel.org; Wed, 24 May 2006 12:20:05 +0200 (MEST)
In-reply-to: <S932666AbWEXJol/20060524094441Z+163@vger.kernel.org>
Content-disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I hope the list can help me to solve this problem:

I have the F1 key of my laptop labeled "Ruhezustand" (hibernate in english) - 
on Windows I can use Fn + F1 zu suspend (RAM or Disk as I like it). On linux 
this doens't work cause the Dell BIOS doesn't describe the Fn + F1 as a ACPI 
hotkey and doens't create an ACPI event.

My question is how can I "workaround" this problem, e.g. create a ACPI event 
for this buttons (kernel patch?) or make acpid work with a normal keycode 
rather than an ACPI event? I can not work on the kernel code myself cause I 
am not skilled in C language :-(

A solution would make quite some Dell Inspiron 6000 happy - I am in the 
proccess of writing a HowTo for this laptop but this problem is still not 
sorted out. 

Thanks in advance!
Sebastian

dmesg |grep -i acpi

 tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
ACPI Namespace successfully loaded at root b042fc70
evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
ACPI: bus type pci registered
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 *7 9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PCI: Using ACPI for IRQ routing
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 19 (level, low) -> IRQ 16
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
acpi_processor-0495 [14] processor_get_info    : Error getting cpuindex for 
acpiid 0x1
ACPI: Thermal Zone [THM] (32 C)
acpi_bus-0201 [09] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt for device 0000:00:1f.2 disabled
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
acpi_bus-0201 [09] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 16 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 16
ACPI wakeup devices:
ACPI: (supports S0 S3 S4 S5)
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 17 (level, low) -> IRQ 17
acpi_bus-0201 [09] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 16 (level, low) -> IRQ 18
acpi_bus-0201 [09] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 18

dmesg output when Fn + F1 pressed:

atkbd.c: Unknown key pressed (translated set 2, code 0x8a on isa0060/serio0).
atkbd.c: Use 'setkeycodes e00a <keycode>' to make it known.
