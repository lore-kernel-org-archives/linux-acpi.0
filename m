From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: FW: [PATCH] i386: irq: Kill IRQ compression
Date: Fri, 16 Feb 2007 02:27:12 -0700
Message-ID: <m11wkqh2q7.fsf@ebiederm.dsl.xmission.com>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0E20@USRV-EXCH4.na.uis.unisys.com>
	<32209efe0702160111q78a32df8i70e3112e5d8da5c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50392 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423466AbXBPJ2p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Feb 2007 04:28:45 -0500
In-Reply-To: <32209efe0702160111q78a32df8i70e3112e5d8da5c1@mail.gmail.com>
	(Natalie Protasevich's message of "Fri, 16 Feb 2007 02:11:20 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Natalie Protasevich <protasnb@gmail.com>
Cc: lenb@kernel.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

"Natalie Protasevich" <protasnb@gmail.com> writes:

> This routine actually renumbers gsi's. I don't think you can kill
> ioapic_renumber_irq without bringing down ES7000 that have swapped
> legacy/PCI ranges and are still out there. Moreover, mach-es7000
> purpose is to define and use the range swapper on the first ioapic.
> Kernel still assumes legacy mapping having no overrides of that
> extent. Perhaps the real fix is to have ACPI/MPS parsers to read the
> actual pin/gsi information from the tables, which turned out pretty
> difficult last time we tried.
> --Natalie

Yes I noticed, and you replied just before I send off an email explicitly
asking you about this :)  At first glance I thought it was that other piece of
irq compression that showed up in arch/x86_64/io_apic.c but it appears
arch/i386/io_apic.c does not have that.

Anyway now all we have to do is bump up NR_IRQS and we should be good, patch
in a moment.

Eric
