From: Thomas Andrews <tandrews@grok.co.za>
Subject: pci_enable_device() and pci=routeirq
Date: Sat, 2 Dec 2006 17:05:30 +0200
Message-ID: <20061202150530.GA5159@grok.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.grok.org.za ([196.1.58.22]:8207 "EHLO mail.grok.org.za")
	by vger.kernel.org with ESMTP id S1031755AbWLBPGH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Dec 2006 10:06:07 -0500
Received: from tandrews by mail.grok.org.za with local (Exim 4.60)
	(envelope-from <tandrews@grok.co.za>)
	id 1GqWQk-0001QN-Hw
	for linux-acpi@vger.kernel.org; Sat, 02 Dec 2006 17:05:30 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

A driver that I've written for the Cologne HFC-4S (based heavily on
qozap.c) only receives interrupts when pci=routeirq is specified. The
driver is calling pci_enable_device(), so pci=routeirq should not be
necessary surely?

Is there any other pci_?() call that I should be making ? (I'm currently
on kernel 2.6.17.7) The help in Documentation/kernel-parameters.txt just
says this:

    routeirq    Do IRQ routing for all PCI devices.
                This is normally done in pci_enable_device(),
                so this option is a temporary workaround
                for broken drivers that don't call it.

Here's some of dmesg output *without* pci=routeirq:

My card is using IRQ 10
-------------8<-------------8<-------------8<-------------8<-------------
ACPI: setting ELCR to 0200 (from 0c20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfaa10, last bus=0
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:00:01.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *5 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 11) *0
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 11) *0
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:01.1

...

ACPI: AC Adapter [AC] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
cs5535_gpio: base=0x6100 mask=0xb003c66 major=254
Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt Link [LNKD] BIOS reported IRQ 0, using IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11

-------------8<-------------8<-------------8<-------------8<-------------

Here's the output from lspci:
-------------8<-------------8<-------------8<-------------8<-------------

0000:00:01.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 2080 (rev 30)
0000:00:01.1 VGA compatible controller: Advanced Micro Devices [AMD]: Unknown device 2081
0000:00:01.2 Entertainment encryption device: Advanced Micro Devices [AMD]: Unknown device 2082
0000:00:0a.0 ISDN controller: Cologne Chip Designs GmbH: Unknown device 08b4 (rev 01)
0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.  RTL-8169 Gigabit Ethernet (rev 10)
0000:00:0e.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 61)
0000:00:0f.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 2090 (rev 03)
0000:00:0f.2 IDE interface: Advanced Micro Devices [AMD]: Unknown device 209a (rev 01)
0000:00:0f.3 Multimedia audio controller: Advanced Micro Devices [AMD]: Unknown device 2093 (rev 01)
0000:00:0f.4 USB Controller: Advanced Micro Devices [AMD]: Unknown device 2094 (rev 02)
0000:00:0f.5 USB Controller: Advanced Micro Devices [AMD]: Unknown device 2095 (rev 02)
-------------8<-------------8<-------------8<-------------8<-------------

Many thanks,
Thomas
