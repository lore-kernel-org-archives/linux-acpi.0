From: Marek Michalkiewicz <marekm-HuSaFJn/uQtscumT1wHf3A@public.gmane.org>
Subject: Re: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Date: Tue, 24 Jun 2003 08:36:12 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030624063612.GB20235@alf.amelek.gda.pl>
References: <F760B14C9561B941B89469F59BA3A847E96FBE@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96FBE-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 23, 2003 at 03:23:48PM -0700, Grover, Andrew wrote:
> Is this an SMP machine?

No, it's a low cost Socket-370 Micro-ATX board with built-in VGA and
RTL8139 LAN, VT8601/VT82C686A chipset, Celeron 1200A processor.

Some of the kernel build options:

CONFIG_MPENTIUMIII=y
CONFIG_SMP=n
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y

But, there are some SMP-related boot messages:

found SMP MP-table at 000f6430

Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.

I can provide the complete boot messages if necessary.

> What do the INT_SRC_OVR lines in the dmesg say?

There are none.

The following part of the boot messages is always the same, it doesn't
matter if ACPI uses IRQ9 (not working) or IRQ11 (working).

PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 11	<- usb-uhci
PCI->APIC IRQ transform: (B0,I7,P3) -> 11	<- usb-uhci
PCI->APIC IRQ transform: (B0,I7,P2) -> 12	<- via82cxxx (sound)
PCI->APIC IRQ transform: (B0,I8,P0) -> 10	<- serial (NM9835 #1)
PCI->APIC IRQ transform: (B0,I9,P0) -> 5	<- serial (NM9835 #2)
PCI->APIC IRQ transform: (B0,I14,P0) -> 11	<- eth0 (RTL8139)
PCI->APIC IRQ transform: (B1,I0,P0) -> 10	<- VGA
PCI: Enabling Via external APIC routing

As you can see, ACPI (even if sharing the IRQ with usb-uhci and eth0)
does not appear in any of the above "PCI->APIC IRQ transform" lines.

It looks like an IRQ is only routed if at least one device uses it,
but ACPI is somehow excluded from these devices.

Thanks,
Marek
