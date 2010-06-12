From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/5] ACPI: remove ACPI debugfs out of
 drivers/acpi/debug.c
Date: Sat, 12 Jun 2010 10:57:55 +0800
Message-ID: <1276311475.19052.17238.camel@rzhang1-desktop>
References: <1276235272.19052.15871.camel@rzhang1-desktop>
	 <alpine.LFD.2.00.1006111143020.4096@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45417 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982Ab0FLC5c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jun 2010 22:57:32 -0400
In-Reply-To: <alpine.LFD.2.00.1006111143020.4096@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2010-06-11 at 23:53 +0800, Len Brown wrote:
> On Fri, 11 Jun 2010, Zhang Rui wrote:
> 
> > ACPI debugfs I/F should not depend on CONFIG_ACPI_DEBUG.
> 
> It would be good to state how much size you are adding to ACPI here --
> since it will be an additional size burnden to those not already
> shipping with CONFIG_ACPI_DEBUG=y.
> 
okay, will state this in the patch set V2.

> > Introduce driver/acpi/debugfs.c for ACPI debugfs I/F.
> > 
> > No function change in this patch.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/Makefile   |    1 
> >  drivers/acpi/bus.c      |    1 
> >  drivers/acpi/debug.c    |   75 ---------------------------------------------
> >  drivers/acpi/debugfs.c  |   80 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/acpi/internal.h |    1 
> >  5 files changed, 83 insertions(+), 75 deletions(-)
> > 
> > Index: linux-2.6/drivers/acpi/debugfs.c
> > ===================================================================
> 
> 
> > +++ linux-2.6/drivers/acpi/Makefile
> > @@ -38,6 +38,7 @@ acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
> >  acpi-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
> >  acpi-y				+= power.o
> >  acpi-y				+= system.o event.o
> > +acpi-y				+= debugfs.o
> >  acpi-$(CONFIG_ACPI_DEBUG)	+= debug.o
> 
> Perhaps it would make sense for this file to depend on CONFIG_DEBUG_FS
> and have it cost 0-bytes when not set -- along with a static inline
> for acpi_debugfs_init()?
> 
The current code invokes dummy debugfs_create_dir/debugfs_create_file
when CONFIG_DEBUG_FS is cleared.
But to make it cleaner, I agree that we can make this file depends on
CONFIG_DEBUG_FS.

thanks,
rui

> Though honestly, with CONFIG_TRACING and others selecting it,
> DEBUG_FS is probably enabled on most systems...
> 
> thanks,
> -Len Brown, Intel Open Source Technology Center
> 


