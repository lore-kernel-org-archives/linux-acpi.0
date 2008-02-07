From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: [BUG] 2.6.24 refuses to boot - NMI watchdog problem?
Date: Thu, 7 Feb 2008 22:22:02 +0000 (GMT)
Message-ID: <977240.37174.qm@web52901.mail.re2.yahoo.com>
References: <20080207122652.02a7d5d5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web52901.mail.re2.yahoo.com ([206.190.49.11]:38498 "HELO
	web52901.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754825AbYBGWWI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 17:22:08 -0500
In-Reply-To: <20080207122652.02a7d5d5.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lenb@kernel.org, rankincj@yahoo.com, linux-kernel@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de, linux-acpi@vger.kernel.org

--- Andrew Morton <akpm@linux-foundation.org> wrote:
> So it's a CONFIG_SMP=y kernel on a single-cpu machine?
Correct.

> It is unclear to me what clocksource (if any) your machine is using.
The 2.6.23.x kernel uses the TSC:

...
ACPI: Core revision 20070126
CPU0: Intel Pentium III (Coppermine) stepping 06
Total of 1 processors activated (2011.69 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
APIC timer registered as dummy, due to nmi_watchdog=1!
Brought up 1 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0e30, last bus=3
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region e400-e47f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region ec00-ec3f claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 15 devices
ACPI: ACPI bus type pnp unregistered
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Time: tsc clocksource has been installed.
...

Cheers,
Chris




      ___________________________________________________________
Support the World Aids Awareness campaign this month with Yahoo! For Good http://uk.promotions.yahoo.com/forgood/
