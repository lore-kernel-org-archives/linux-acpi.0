From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/5] ACPI: remove ACPI debugfs out of drivers/acpi/debug.c
Date: Fri, 11 Jun 2010 11:53:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006111143020.4096@localhost.localdomain>
References: <1276235272.19052.15871.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60303 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758537Ab0FKPxg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2010 11:53:36 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3U00GEJXGW3X01@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 11 Jun 2010 10:53:35 -0500 (CDT)
In-reply-to: <1276235272.19052.15871.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 11 Jun 2010, Zhang Rui wrote:

> ACPI debugfs I/F should not depend on CONFIG_ACPI_DEBUG.

It would be good to state how much size you are adding to ACPI here --
since it will be an additional size burnden to those not already
shipping with CONFIG_ACPI_DEBUG=y.

> Introduce driver/acpi/debugfs.c for ACPI debugfs I/F.
> 
> No function change in this patch.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/Makefile   |    1 
>  drivers/acpi/bus.c      |    1 
>  drivers/acpi/debug.c    |   75 ---------------------------------------------
>  drivers/acpi/debugfs.c  |   80 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/internal.h |    1 
>  5 files changed, 83 insertions(+), 75 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/debugfs.c
> ===================================================================


> +++ linux-2.6/drivers/acpi/Makefile
> @@ -38,6 +38,7 @@ acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
>  acpi-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
>  acpi-y				+= power.o
>  acpi-y				+= system.o event.o
> +acpi-y				+= debugfs.o
>  acpi-$(CONFIG_ACPI_DEBUG)	+= debug.o

Perhaps it would make sense for this file to depend on CONFIG_DEBUG_FS
and have it cost 0-bytes when not set -- along with a static inline
for acpi_debugfs_init()?

Though honestly, with CONFIG_TRACING and others selecting it,
DEBUG_FS is probably enabled on most systems...

thanks,
-Len Brown, Intel Open Source Technology Center

