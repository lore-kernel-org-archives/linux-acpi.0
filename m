From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] 2.6.0-test4 ACPI fixes series (4/4)
Date: Sat, 6 Sep 2003 13:27:16 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309061327.16347.adq_dvb@lidskialf.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060157.47121.adq_dvb@lidskialf.net> <3F5936D2.3060502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3F5936D2.3060502-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
To: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 06 September 2003 02:22, Jeff Garzik wrote:
> Andrew de Quincey wrote:
> > This patch removes some erroneous code from mpparse which breaks IO-APIC
> > programming
> >
> >
> > --- linux-2.6.0-test4.null_crs/arch/i386/kernel/mpparse.c	2003-09-06
> > 00:23:10.000000000 +0100 +++
> > linux-2.6.0-test4.duffmpparse/arch/i386/kernel/mpparse.c	2003-09-06
> > 00:28:23.788124872 +0100 @@ -1129,9 +1129,6 @@
> >  			continue;
> >  		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
> >
> > -		if (!ioapic && (irq < 16))
> > -			irq += 16;
> > -
>
> Even though I've been digging through stuff off and on, I consider
> myself pretty darn IOAPIC-clueless.  Mikael, does this look sane to you?

Really breaks on TX150 servers... All IRQs < 16 get +16 added onto them, which 
breaks all IRQ routing. It's also already been removed from 2.4.23-pre3
