From: Len Brown <lenb@kernel.org>
Subject: Re: Understandig ACPI routing PCI IRQ
Date: Mon, 11 Dec 2006 00:44:49 -0500
Message-ID: <200612110044.49884.lenb@kernel.org>
References: <20061119161221.GC5208@rigacci.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38957 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762508AbWLKFlu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Dec 2006 00:41:50 -0500
In-Reply-To: <20061119161221.GC5208@rigacci.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Niccolo Rigacci <linux-acpi@rigacci.org>
Cc: linux-acpi@vger.kernel.org

On Sunday 19 November 2006 11:12, Niccolo Rigacci wrote:
> Hi, I'm trying to write a little howto about IRQ on modern PCs.
>  
> I still have some obscure points, can someone help me 
> understanding the following dmesg messages?
> 
>    ACPI: PCI Interrupt Link [LNK1] (IRQs *5 7 9 10 11 14 15)
>    ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
> 
> Is the label [APSI] coming from the BIOS? I see several labels in 
> dmesg like LNK1, LUBA, LSID, APC1, ... what is the meaning?

Arbitrary 4-character AML names chosen by the BIOS programmer
for ACPI PCI Interrupt Link devices.

There are basically two modes, PIC mode and APIC mode.
It is common for programmers to use names that begin with 'A"
for APIC mode devices -- which clearly is the case above
since the GSI's are above 15.

> What it the IRQs list? Are those the possible values to route 
> that phisical link to?

Yes, as  communicated by the BIOS AML _PRS -- Possibile resource settings.

> Why some PCI interrupt links are assigned at the very begin of 
> boot process, where others are first disabled and then enabled 
> later?
> 
>    ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
>    ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 185
> 
> In the above log entries, what does it means GSI?

GSI = Global System Interrupt.
Ie. interrupts as seen as a single list from 0..n for the entire system.
This used to be synonymous with the IRQ#, but got screwed up by
the MSI code and also some platforms specific IRQ re-numbering code
that make the IRQ numbers look "funny".  Some of this code is being
un-done now and the GSI and IRQ will more often be the same
in 2.6.19 onward.
 
> I understand that in PCI slot 0e, there is a device 0, that uses 
> the first slot interrupt line (INTA#), which is routed to the CPU 
> IRQ 185. But what there is in the middle?

That is the ACPI PCI Interrupt Link.  Its name is APSI and per the message
above it could be programmed to 20, 21, 22, or 23.  Here Linux chose 23 --
which will depend on what other devices are in the system and the probe order.

> If someone knows detailed explanation of lspci and dmesg, give me 
> a pointer.

Well, the other part of the dmesg line above it the '*' which tells you where
the link is currently programmed.  Generally Linux tries to not move IRQs
in PIC mode, but by default will balance them in IO-APIC mode to minimize
sharing.

cheers,
-Len

