From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Date: Sat, 6 Sep 2003 13:32:39 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309061332.39489.adq_dvb@lidskialf.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <3F592AA7.7020700@pobox.com> <20030905190338.W16228@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030905190338.W16228-BI/OLcgY7/cyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
Content-Disposition: inline
To: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Saturday 06 September 2003 03:03, Chris Wright wrote:
> * Jeff Garzik (jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org) wrote:
> > Andrew de Quincey wrote:
> > > successful dmesg
> > > dmesg from a failed boot
> > > /proc/acpi/dsdt
> > > /proc/interrupts
> >
> > dmidecode output is also quite helpful.
>
> I've uploaded these to:
>
> http://lsm.immunix.org/~chris/acpi/
>
> You'll find dmesg and interrupts from pci=noacpi, acpi=off, disassembled
> dsdt and dmidecode.  Don't have the failed boot dmesg yet.  I ported
> netconsole to my eth driver, but it's not yet working.

Cool, ta.. I'll have a look, but I'll probably need the failed dmesg to make 
any real progress.
