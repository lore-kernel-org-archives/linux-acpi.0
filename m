From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 4/5] i386: turn on CONFIG_PNP in defconfig
Date: Thu, 18 Jan 2007 10:49:00 -0700
Message-ID: <200701181049.00452.bjorn.helgaas@hp.com>
References: <200701161028.10109.bjorn.helgaas@hp.com> <200701161034.59194.bjorn.helgaas@hp.com> <200701172208.56185.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:42581 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084AbXARRtJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jan 2007 12:49:09 -0500
In-Reply-To: <200701172208.56185.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

On Wednesday 17 January 2007 20:08, Len Brown wrote:
> > --- mm-work13.orig/arch/i386/defconfig	2007-01-11 13:56:18.000000000 -0700
> > +++ mm-work13/arch/i386/defconfig	2007-01-11 13:57:23.000000000 -0700
> > @@ -466,7 +466,7 @@
> >  #
> >  # Plug and Play support
> >  #
> > -# CONFIG_PNP is not set
> > +CONFIG_PNP=y
> >  
> >  #
> >  # Block devices
> 
> shouldn't CONFIG_PNPACPI=y also appear in defconfig with this change?
> If it doesn't, then somebody who runs make oldconfig will get prompted for it.

Yes, you're right.  I'll add PNPACPI=y in the next round.

> Also, do we need to be concerned about the case where
> CONFIG_PNP=n
> CONFIG_ACPI=y
> This is the case that motherboard.c was intended to cover.
> 
> CONFIG_PNP depends on ACPI (or ISA)
> But nothing mandates that somebody must select it.

Hmmm... true.  Could we get away with having ACPI select PNP?

Two other, longer term thoughts:
  1) I think it would be good if PNP reserved resources for all
     active devices, as PCI already does (though PCI might do it
     even for disabled devices).  Then we really wouldn't need
     system.c or motherboard.c at all.

  2) I think we should deprecate ACPI driver registration and do
     everything through PNP, with the ACPI stuff as an optional
     capability of PNP devices.  Then PNP=n, ACPI=y really wouldn't
     make much sense.

Bjorn
