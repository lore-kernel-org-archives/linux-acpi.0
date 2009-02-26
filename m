From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/3] ACPI: move internal core declarations to private header
Date: Thu, 26 Feb 2009 16:00:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902261548580.6492@localhost.localdomain>
References: <20090219195009.20619.20334.stgit@bob.kio>
 <20090219195153.20619.89309.stgit@bob.kio>
 <alpine.LFD.2.00.0902212259530.5009@localhost.localdomain>
 <200902241151.35935.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:51273 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbZBZVAQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Feb 2009 16:00:16 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFO00466YC2MXV8@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 26 Feb 2009 15:00:08 -0600 (CST)
In-reply-to: <200902241151.35935.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 24 Feb 2009, Bjorn Helgaas wrote:

> On Saturday 21 February 2009 09:21:14 pm Len Brown wrote:
> > On Thu, 19 Feb 2009, Bjorn Helgaas wrote:
> > 
> > > A number of things that shouldn't be exposed outside the ACPI core
> > > were declared in include/acpi/acpi_drivers.h, where anybody can
> > > see them.  This patch moves those declarations to a new "ospm.h"
> > > inside drivers/acpi.
> > 
> > I'm not sure that we're using the same terminology.
> 
> I'm sure we're not :-)
> 
> > In ACPI I usually use the word "core" to refer to everything
> > that is now under drivers/acpi/acpica/
> > eg. the ACPI interpreter and the OS agnostic code in ACPICA.
> > 
> > That is why dmesg prints this:
> > 
> > ACPI: Core revision 20090123
> > 
> > I use the word "Linux/ACPI" to refer to everything in
> > drivers/acpi/* and the ACPI stuff under arch/ etc.
> 
> I think the common Linux usage of "core" is more along the lines
> of "bus infrastructure and implementation of stuff in the driver/
> kernel interface," e.g., 
>     PCI core -> drivers/pci/*
>     PNP core -> drivers/pnp/*
> So by analogy, I think the "ACPI core" should refer to the stuff
> in drivers/acpi.  The stuff in drivers/acpi/acpica is something
> else that doesn't really appear in other subsystems, so using "core"
> to refer to the ACPICA makes ACPI unnecessarily different.
> 
> But this is tangential, and I'll gladly remove "core" from the
> changelog!

Okay, lets stay away from the word core,
since it has two common conflicting uses.

> > I do want things that are private to drivers/acpi/ files
> > to be in drivers/acpi/, and not in include/acpi/
> > 
> > so i guess I like what you're doing here,
> > but for some reason i'm not excited about the name "ospm.h",
> > maybe I"ll sleep on it and it will sound excellent tomorrow...
> 
> I'm not married to "ospm.h", and you're right that it's not very
> descriptive and doesn't have much history in Linux.  I tried "acpi.h"
> and "acpi_core.h" earlier, but those were duds as well.  Here
> are some similar files in other parts of Linux:
> 
>     block/blk.h
>     crypto/internal.h
>     drivers/base/base.h
>     drivers/pci/pci.h
>     drivers/pnp/base.h
>     drivers/scsi/scsi_priv.h
>     fs/internal.h
>     mm/internal.h
> 
> What would you think of "drivers/acpi/internal.h"?

better.

I do like internal.h better than ospm.h because internal.h
sounds like something that drivers should not include,
while ospm.h sounds like something they should include.

The murkyness right now I think is because we still have two
different types of code in drivers/acpi/

acpi/ seems to be where we have some infrastructre code,
plus some "acpi drivers", such as battery.c that use the
infrastructure to implement OS policy.  Maybe we should
have the infrastructure and the drivers in two different
directories?

acpi/acpica/ is a single place for the ACPICA C-code
	and has its own private headers down there, finally.

include/linux/acpi.h
	this is what other parts of the kernel use to talk
	to the acpi sub-system

include/acpi/
	this is here so that the above can include <acpi/acpi.h>
	which bundles various public ACPICA headers
	there is probably a more elegant way to do this.

drivers/platform/x86/
	platform specific drivers that use acpi
	rather than implement acpi, finally moved out
	of the drivers/acpi/ directory

thanks,
-Len

