From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 3/5] ACPI: introduce drivers/acpi/sysfs.c
Date: Sat, 12 Jun 2010 11:00:35 +0800
Message-ID: <1276311635.19052.17243.camel@rzhang1-desktop>
References: <1276235278.19052.15873.camel@rzhang1-desktop>
	 <alpine.LFD.2.00.1006111156350.4096@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59537 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752213Ab0FLDAM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jun 2010 23:00:12 -0400
In-Reply-To: <alpine.LFD.2.00.1006111156350.4096@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 2010-06-12 at 00:00 +0800, Len Brown wrote:
> On Fri, 11 Jun 2010, Zhang Rui wrote:
> 
> > 
> > Introduce driver/acpi/sysfs.c, which contains the code for ACPI sysfs I/F.
> > 
> > Remove driver/acpi/debug.c in this patch,
> > the code for ACPI debug sysfs I/F is moved to driver/acpi/sysfs.c.
> > 
> > No function change in this patch.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/Makefile |    2 
> >  drivers/acpi/debug.c  |  198 --------------------------------------------------
> >  drivers/acpi/sysfs.c  |  196 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 197 insertions(+), 199 deletions(-)
> > 
> > Index: linux-2.6/drivers/acpi/Makefile
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/Makefile
> > +++ linux-2.6/drivers/acpi/Makefile
> > @@ -39,7 +39,7 @@ acpi-y				+= pci_root.o pci_link.o pci_i
> >  acpi-y				+= power.o
> >  acpi-y				+= system.o event.o
> >  acpi-y				+= debugfs.o
> > -acpi-$(CONFIG_ACPI_DEBUG)	+= debug.o
> > +acpi-y				+= sysfs.o
> 
> I do like the name change.
> 
> But here you are moving things from CONFIG_ACPI_DEBUG, to enabled always.
> 
No, we have #ifdef CONFIG_ACPI_DEBUG in sysfs.c, for the ACPI debug
sysfs I/F.
So I don't think this is a problem. :)

thanks,
rui
> Are debug_layer and debug_level useful when CONFIG_ACPI_DEBUG=n?

> thanks,
> Len Brown, Intel Open Source Technology Center
> 
> 


