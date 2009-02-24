From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 3/3] ACPI: move internal core declarations to private header
Date: Tue, 24 Feb 2009 11:51:35 -0700
Message-ID: <200902241151.35935.bjorn.helgaas@hp.com>
References: <20090219195009.20619.20334.stgit@bob.kio> <20090219195153.20619.89309.stgit@bob.kio> <alpine.LFD.2.00.0902212259530.5009@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:28444 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbZBXSvk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Feb 2009 13:51:40 -0500
In-Reply-To: <alpine.LFD.2.00.0902212259530.5009@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Saturday 21 February 2009 09:21:14 pm Len Brown wrote:
> On Thu, 19 Feb 2009, Bjorn Helgaas wrote:
> 
> > A number of things that shouldn't be exposed outside the ACPI core
> > were declared in include/acpi/acpi_drivers.h, where anybody can
> > see them.  This patch moves those declarations to a new "ospm.h"
> > inside drivers/acpi.
> 
> I'm not sure that we're using the same terminology.

I'm sure we're not :-)

> In ACPI I usually use the word "core" to refer to everything
> that is now under drivers/acpi/acpica/
> eg. the ACPI interpreter and the OS agnostic code in ACPICA.
> 
> That is why dmesg prints this:
> 
> ACPI: Core revision 20090123
> 
> I use the word "Linux/ACPI" to refer to everything in
> drivers/acpi/* and the ACPI stuff under arch/ etc.

I think the common Linux usage of "core" is more along the lines
of "bus infrastructure and implementation of stuff in the driver/
kernel interface," e.g., 
    PCI core -> drivers/pci/*
    PNP core -> drivers/pnp/*
So by analogy, I think the "ACPI core" should refer to the stuff
in drivers/acpi.  The stuff in drivers/acpi/acpica is something
else that doesn't really appear in other subsystems, so using "core"
to refer to the ACPICA makes ACPI unnecessarily different.

But this is tangential, and I'll gladly remove "core" from the
changelog!

> ...
> I do want things that are private to drivers/acpi/ files
> to be in drivers/acpi/, and not in include/acpi/
> 
> so i guess I like what you're doing here,
> but for some reason i'm not excited about the name "ospm.h",
> maybe I"ll sleep on it and it will sound excellent tomorrow...

I'm not married to "ospm.h", and you're right that it's not very
descriptive and doesn't have much history in Linux.  I tried "acpi.h"
and "acpi_core.h" earlier, but those were duds as well.  Here
are some similar files in other parts of Linux:

    block/blk.h
    crypto/internal.h
    drivers/base/base.h
    drivers/pci/pci.h
    drivers/pnp/base.h
    drivers/scsi/scsi_priv.h
    fs/internal.h
    mm/internal.h

What would you think of "drivers/acpi/internal.h"?

Bjorn
