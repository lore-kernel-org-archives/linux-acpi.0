From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Understandig ACPI routing PCI IRQ
Date: Mon, 20 Nov 2006 09:49:57 -0700
Message-ID: <200611200949.58409.bjorn.helgaas@hp.com>
References: <20061119161221.GC5208@rigacci.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:26281 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S966065AbWKTQuI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Nov 2006 11:50:08 -0500
In-Reply-To: <20061119161221.GC5208@rigacci.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Niccolo Rigacci <linux-acpi@rigacci.org>
Cc: linux-acpi@vger.kernel.org

On Sunday 19 November 2006 09:12, Niccolo Rigacci wrote:
> Hi, I'm trying to write a little howto about IRQ on modern PCs.
>  
> I still have some obscure points, can someone help me 
> understanding the following dmesg messages?
> 
>    ACPI: PCI Interrupt Link [LNK1] (IRQs *5 7 9 10 11 14 15)
>    ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
> 
> Is the label [APSI] coming from the BIOS?

Yes.  The PCI interrupt link is a device in the ACPI namespace, and
"APSI" is the name of it.

> I see several labels in  
> dmesg like LNK1, LUBA, LSID, APC1, ... what is the meaning?

These names are completely arbitrary and are made up by the BIOS
writer.  There's no consistency between different BIOSes.

> What it the IRQs list? Are those the possible values to route 
> that phisical link to?

Yes.  The ACPI link device shows the "possible" resource settings,
which are printed as this list.  The currently setting is shown
with the "*".

> Why some PCI interrupt links are assigned at the very begin of 
> boot process, where others are first disabled and then enabled 
> later?

We currently disable all PCI interrupt links initially at the end
of acpi_pci_link_add().

We used to route all PCI interrupts at boot-time.  That was
somewhat wasteful because we assigned IRQs for devices that
didn't have drivers, for unused PCI interrupt lines (if device
0000:00:0e.0 used INTA#, we assigned IRQs for the unused INTB#,
INTC#, and INTD# lines as well), and even for empty slots.

We now route the interrupt when the device driver calls
pci_enable_device().

>    ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
>    ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 185
> 
> In the above log entries, what does it means GSI?

"GSI" is an ACPI term that means "global system interrupt."  There's
some discussion in section 5.2.12 of the ACPI 3.0 spec.  Basically
it's a number that identifies either an I/O APIC interrupt input or
a legacy 8259 IRQ.

For every I/O APIC in the system, ACPI tells you the base GSI and
the APIC type and address (this is either in the MADT or in _MAT
objects).  Given the type (IOAPIC, IOSAPIC, etc) and the address,
you can read the APIC "Max Redir Entry" register to find out how
many interrupt inputs it has.

So if you have this:

             GSI base   #inputs
  IOAPIC 0      32        16
  IOAPIC 1      48        16
  IOAPIC 2      64         8

GSIs 32-47 correspond to inputs on IOAPIC 0, GSIs 48-63 correspond
to IOAPIC 1, and GSIs 64-71 correspond to IOAPIC 2.

The GSI numbers are determined by the BIOS.  The Linux IRQ numbers
(e.g., IRQ 185) are determined by the OS.

> I understand that in PCI slot 0e, there is a device 0, that uses 
> the first slot interrupt line (INTA#), which is routed to the CPU 
> IRQ 185. But what there is in the middle?

I don't know much about the link devices.  
