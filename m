From: "Natalie Protasevich" <protasnb@gmail.com>
Subject: Re: FW: [PATCH] i386: irq: Kill IRQ compression
Date: Fri, 16 Feb 2007 02:11:20 -0700
Message-ID: <32209efe0702160111q78a32df8i70e3112e5d8da5c1@mail.gmail.com>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0E20@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:21830 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423430AbXBPJLV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Feb 2007 04:11:21 -0500
Received: by nz-out-0506.google.com with SMTP id s1so826164nze
        for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2007 01:11:21 -0800 (PST)
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0E20@USRV-EXCH4.na.uis.unisys.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, lenb@kernel.org
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

> From: Eric W. Biederman [mailto:ebiederm@xmission.com]
> Sent: Friday, February 16, 2007 12:44 AM
> To: Len Brown
> Cc: Andi Kleen; Protasevich, Natalie; lkml - Kernel Mailing List;
> linux-acpi@vger.kernel.org
> Subject: Re: [PATCH] i386: irq: Kill IRQ compression
>
> Len Brown <lenb@kernel.org> writes:
>
> > This code makes simple systems complex:
> >
> > ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 18 (level, low) -> IRQ 16
> > ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 17
> > ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 18
> > ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 19
> >
> > The same code was already removed from x86_64
>
> By itself I don't think we are going to observe any real problems
> with this patch.
>
> However if we are going to be serious about this we need to do a
> few more things.
>
> - kill iopaic_renumber_irq.

This routine actually renumbers gsi's. I don't think you can kill
ioapic_renumber_irq without bringing down ES7000 that have swapped
legacy/PCI ranges and are still out there. Moreover, mach-es7000
purpose is to define and use the range swapper on the first ioapic.
Kernel still assumes legacy mapping having no overrides of that
extent. Perhaps the real fix is to have ACPI/MPS parsers to read the
actual pin/gsi information from the tables, which turned out pretty
difficult last time we tried.
--Natalie

> - Increase NR_IRQS.
>
> We will still be limited to about 208 interrupts in use at one
> time, but we can allow more irq sources to be described.
>
> This reminds me.  I really need to dig up my patch that doesn't
> allocate a vector for an irq until request irq time.
>
> Eric
>
