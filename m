From: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] 2.6.0-test4 ACPI fixes series (4/4)
Date: Fri, 05 Sep 2003 21:22:26 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3F5936D2.3060502@pobox.com>
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com> <200309060157.47121.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200309060157.47121.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Andrew de Quincey wrote:
> This patch removes some erroneous code from mpparse which breaks IO-APIC programming
> 
> 
> --- linux-2.6.0-test4.null_crs/arch/i386/kernel/mpparse.c	2003-09-06 00:23:10.000000000 +0100
> +++ linux-2.6.0-test4.duffmpparse/arch/i386/kernel/mpparse.c	2003-09-06 00:28:23.788124872 +0100
> @@ -1129,9 +1129,6 @@
>  			continue;
>  		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
>  
> -		if (!ioapic && (irq < 16))
> -			irq += 16;
> -


Even though I've been digging through stuff off and on, I consider 
myself pretty darn IOAPIC-clueless.  Mikael, does this look sane to you?
