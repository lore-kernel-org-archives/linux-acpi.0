From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] i386: irq: Kill IRQ compression
Date: Fri, 16 Feb 2007 00:44:07 -0700
Message-ID: <m1wt2ih7i0.fsf@ebiederm.dsl.xmission.com>
References: <200702160015.04453.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56705 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbXBPHpn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Feb 2007 02:45:43 -0500
In-Reply-To: <200702160015.04453.lenb@kernel.org> (Len Brown's message of
	"Fri, 16 Feb 2007 00:15:04 -0500")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <ak@suse.de>, Natalie Protasevich <Natalie.Protasevich@unisys.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Len Brown <lenb@kernel.org> writes:

> This code makes simple systems complex:
>
> ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 18 (level, low) -> IRQ 16
> ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 17
> ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 18
> ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 19
>
> The same code was already removed from x86_64

By itself I don't think we are going to observe any real problems
with this patch.

However if we are going to be serious about this we need to do a
few more things.

- kill iopaic_renumber_irq.
- Increase NR_IRQS.

We will still be limited to about 208 interrupts in use at one
time, but we can allow more irq sources to be described.

This reminds me.  I really need to dig up my patch that doesn't
allocate a vector for an irq until request irq time.

Eric
