From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 3/3] ACPI: move internal core declarations to private header
Date: Thu, 26 Feb 2009 15:08:25 -0700
Message-ID: <200902261508.26729.bjorn.helgaas@hp.com>
References: <20090219195009.20619.20334.stgit@bob.kio> <200902241151.35935.bjorn.helgaas@hp.com> <alpine.LFD.2.00.0902261548580.6492@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:46469 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbZBZWIr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Feb 2009 17:08:47 -0500
In-Reply-To: <alpine.LFD.2.00.0902261548580.6492@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Thursday 26 February 2009 02:00:01 pm Len Brown wrote:
> On Tue, 24 Feb 2009, Bjorn Helgaas wrote:
> > What would you think of "drivers/acpi/internal.h"?
> 
> better.
> 
> I do like internal.h better than ospm.h because internal.h
> sounds like something that drivers should not include,
> while ospm.h sounds like something they should include.

Yep, I can agree with that.

> The murkyness right now I think is because we still have two
> different types of code in drivers/acpi/
> 
> acpi/ seems to be where we have some infrastructre code,
> plus some "acpi drivers", such as battery.c that use the
> infrastructure to implement OS policy.  Maybe we should
> have the infrastructure and the drivers in two different
> directories?

Yes, maybe so.  We certainly don't have drivers under drivers/pci
just because they happen to call pci_register_driver().

drivers/platform/x86 obviously isn't the right place for generic
things like battery.c, fan.c, etc, but I'd be happy if they were
moved out of drivers/acpi someday.

Bjorn

> acpi/acpica/ is a single place for the ACPICA C-code
> 	and has its own private headers down there, finally.
> 
> include/linux/acpi.h
> 	this is what other parts of the kernel use to talk
> 	to the acpi sub-system
> 
> include/acpi/
> 	this is here so that the above can include <acpi/acpi.h>
> 	which bundles various public ACPICA headers
> 	there is probably a more elegant way to do this.
> 
> drivers/platform/x86/
> 	platform specific drivers that use acpi
> 	rather than implement acpi, finally moved out
> 	of the drivers/acpi/ directory

