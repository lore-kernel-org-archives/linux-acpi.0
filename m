From: Sylvain Jeaugey <sylvain.jeaugey-6ktuUTfB/bM@public.gmane.org>
Subject: Re: [DMESG] cpumask_t in action
Date: Fri, 7 Nov 2003 09:13:11 +0100 (CET)
Sender: linux-ia64-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0311070907020.29453-100000@localhost.localdomain>
References: <20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ia64-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20031106165159.GE26869-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 6 Nov 2003, Matthew Wilcox wrote:

> > ACPI: SRAT Processor (id[0x00] eid[0x00]) in proximity domain 0 enabled
> > ACPI: SRAT Processor (id[0x20] eid[0x00]) in proximity domain 0 enabled
[...]
> > ACPI: SRAT Processor (id[0x00] eid[0x5e]) in proximity domain 47 enabled
> > ACPI: SRAT Processor (id[0x20] eid[0x5e]) in proximity domain 47 enabled
> 
> ... for example ;-)  96 lines which honestly tell me nothing.
> 
> > ACPI: SRAT Memory (0x0000003000000000 length 0x0000001000000000 type 0x1) in proximity domain 0 enabled
> > ACPI: SRAT Memory (0x000000b000000000 length 0x0000001000000000 type 0x1) in proximity domain 1 enabled
> [ snip 44 lines ]
> > ACPI: SRAT Memory (0x0000173000000000 length 0x0000001000000000 type 0x1) in proximity domain 46 enabled
> > ACPI: SRAT Memory (0x000017b000000000 length 0x0000001000000000 type 0x1) in proximity domain 47 enabled
> 
> ... and again.
> 
These lines show you the numa topology of your machine (in our case, we 
have 2 CPUS per domain, and a memory area).
This is quite a big piece of information about hardware. Even if it is 
quite long, I think it should be part of the ACPI information.

Sylvain

-
To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
