From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/5] ACPI: introduce drivers/acpi/sysfs.c
Date: Fri, 11 Jun 2010 12:00:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006111156350.4096@localhost.localdomain>
References: <1276235278.19052.15873.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:44042 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0FKQBM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2010 12:01:12 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3U0001AXTKK9D1@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 11 Jun 2010 11:01:01 -0500 (CDT)
In-reply-to: <1276235278.19052.15873.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 11 Jun 2010, Zhang Rui wrote:

> 
> Introduce driver/acpi/sysfs.c, which contains the code for ACPI sysfs I/F.
> 
> Remove driver/acpi/debug.c in this patch,
> the code for ACPI debug sysfs I/F is moved to driver/acpi/sysfs.c.
> 
> No function change in this patch.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/Makefile |    2 
>  drivers/acpi/debug.c  |  198 --------------------------------------------------
>  drivers/acpi/sysfs.c  |  196 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 197 insertions(+), 199 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/Makefile
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/Makefile
> +++ linux-2.6/drivers/acpi/Makefile
> @@ -39,7 +39,7 @@ acpi-y				+= pci_root.o pci_link.o pci_i
>  acpi-y				+= power.o
>  acpi-y				+= system.o event.o
>  acpi-y				+= debugfs.o
> -acpi-$(CONFIG_ACPI_DEBUG)	+= debug.o
> +acpi-y				+= sysfs.o

I do like the name change.

But here you are moving things from CONFIG_ACPI_DEBUG, to enabled always.

Are debug_layer and debug_level useful when CONFIG_ACPI_DEBUG=n?

thanks,
Len Brown, Intel Open Source Technology Center


