From: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Date: Wed, 10 Sep 2003 18:36:55 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030910183655.H9800@osdlab.pdx.osdl.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <3F592AA7.7020700@pobox.com> <20030905190338.W16228@osdlab.pdx.osdl.net> <200309061332.39489.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200309061332.39489.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>; from adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org on Sat, Sep 06, 2003 at 01:32:39PM +0100
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

* Andrew de Quincey (adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org) wrote:
> On Saturday 06 September 2003 03:03, Chris Wright wrote:
> > You'll find dmesg and interrupts from pci=noacpi, acpi=off, disassembled
> > dsdt and dmidecode.  Don't have the failed boot dmesg yet.  I ported
> > netconsole to my eth driver, but it's not yet working.
> 
> Cool, ta.. I'll have a look, but I'll probably need the failed dmesg to make 
> any real progress.

Sorry, for the delay.  I captured console output from failed (normal
acpi) boot.  I also re-ran on 2.6.0-test5 and captured those outputs.
The test3-bk3 is actually test3-bk2+acpi_>15_irq.patch which is the
patch that began the breakage for me.

http://developer.osdl.org/chrisw/acpi/2.6.0-test3-bk3/
http://developer.osdl.org/chrisw/acpi/2.6.0-test5/

Each have dmesg and interrupts from pci=noacpi and acpi=off, dmesg with
acpi enabled, disassembled dsdt, and dmidecode.

Let me know if you need any more info.
thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
