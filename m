From: "Noah J. Misch" <noah-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Subject: Re: [ACPI] [PATCH][RFC] Clean up Kconfig logic for IA64 ACPI
Date: Sat, 1 Nov 2003 20:05:44 -0800 (PST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.GSO.4.58.0311011945190.18996@sue>
References: <Pine.GSO.4.58.0310251706470.15711@inky>
 <20031102031644.GB3824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20031102031644.GB3824-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: linux-ia64-WygotPe7DYIabbyE177sbg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2 Nov 2003, Matthew Wilcox wrote:

> > I found the Kconfig logic for ACPI and IA64, as defined in arch/ia64/Kconfig and
> > drivers/acpi/Kconfig to be a bit redundant and hard to follow.  It appears to do
> > the following:
>
> I posted a similar patch here:
>
> http://marc.theaimsgroup.com/?l=linux-ia64&m=106555019402117&w=2

I do not read linux-ia64 regularly, so I did not notice your work.  I apologize
for not acknowledging it.

Why not include drivers/Kconfig and scrap the individual subdirectory includes,
as i386 does?

Also, it looks like your patch makes ACPI non-mandatory.  Is that intentional?

Thanks,
Noah
