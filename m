From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 4/5] i386: turn on CONFIG_PNP in defconfig
Date: Fri, 19 Jan 2007 03:53:52 -0500
Message-ID: <200701190353.52224.lenb@kernel.org>
References: <200701161028.10109.bjorn.helgaas@hp.com> <200701172208.56185.lenb@kernel.org> <200701181049.00452.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39960 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964979AbXASIzv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jan 2007 03:55:51 -0500
In-Reply-To: <200701181049.00452.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

On Thursday 18 January 2007 12:49, Bjorn Helgaas wrote:
> On Wednesday 17 January 2007 20:08, Len Brown wrote:
> > > --- mm-work13.orig/arch/i386/defconfig	2007-01-11 13:56:18.000000000 -0700
> > > +++ mm-work13/arch/i386/defconfig	2007-01-11 13:57:23.000000000 -0700
> > > @@ -466,7 +466,7 @@
> > >  #
> > >  # Plug and Play support
> > >  #
> > > -# CONFIG_PNP is not set
> > > +CONFIG_PNP=y
> > >  
> > >  #
> > >  # Block devices
> > 
> > shouldn't CONFIG_PNPACPI=y also appear in defconfig with this change?
> > If it doesn't, then somebody who runs make oldconfig will get prompted for it.
> 
> Yes, you're right.  I'll add PNPACPI=y in the next round.

Hmm, I guess if we're going to include it by default,
it is time to delete its dependency on EXPERIMENTAL:
Though so many things depend on EXPERIMENTAL
these days that maybe it doesn't mean so much.

config PNPACPI
        bool "Plug and Play ACPI support (EXPERIMENTAL)"
        depends on PNP && ACPI && EXPERIMENTAL

> > Also, do we need to be concerned about the case where
> > CONFIG_PNP=n
> > CONFIG_ACPI=y
> > This is the case that motherboard.c was intended to cover.
> > 
> > CONFIG_PNP depends on ACPI (or ISA)
> > But nothing mandates that somebody must select it.
> 
> Hmmm... true.  Could we get away with having ACPI select PNP?

Every time I've tried to use select in recent memory it seems
something goes bad.  I think there is a rule, such as the
thing selected can not depend on anything else, which if violated
breaks people's ranconfigs and adrian get grumpy about it.

So I think if we want to tie them together, then ACPI
should actually depend on PNP -- which is consistent,
with how ACPI depends on PM today.

 
> Two other, longer term thoughts:
>   1) I think it would be good if PNP reserved resources for all
>      active devices, as PCI already does (though PCI might do it
>      even for disabled devices).  Then we really wouldn't need
>      system.c or motherboard.c at all.
> 
>   2) I think we should deprecate ACPI driver registration and do
>      everything through PNP, with the ACPI stuff as an optional
>      capability of PNP devices.  Then PNP=n, ACPI=y really wouldn't
>      make much sense.

Whelp, when we're guaranteed that PNP exists when ACPI exists
then we can get smarter about PNP.

thanks,
-Len
