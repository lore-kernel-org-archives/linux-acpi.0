From: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Date: Fri, 5 Sep 2003 19:03:38 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030905190338.W16228@osdlab.pdx.osdl.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060016.16545.adq_dvb@lidskialf.net> <20030905170224.A16217@osdlab.pdx.osdl.net> <200309060221.30741.adq_dvb@lidskialf.net> <3F592AA7.7020700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F592AA7.7020700-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>; from jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org on Fri, Sep 05, 2003 at 08:30:31PM -0400
To: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

* Jeff Garzik (jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org) wrote:
> Andrew de Quincey wrote:
> > successful dmesg
> > dmesg from a failed boot
> > /proc/acpi/dsdt
> > /proc/interrupts
> 
> dmidecode output is also quite helpful.

I've uploaded these to:

http://lsm.immunix.org/~chris/acpi/

You'll find dmesg and interrupts from pci=noacpi, acpi=off, disassembled
dsdt and dmidecode.  Don't have the failed boot dmesg yet.  I ported
netconsole to my eth driver, but it's not yet working.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
