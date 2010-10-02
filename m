From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/4] ACPI AC/Battery/SBS: deprecate procfs I/F and make
 sysfs I/F always built in
Date: Fri, 01 Oct 2010 21:40:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010012137240.2293@localhost.localdomain>
References: <1285965576.2111.3744.camel@rui>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61985 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab0JBBlD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2010 21:41:03 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9N00GAB3CDMEI0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 01 Oct 2010 20:41:02 -0500 (CDT)
In-reply-to: <1285965576.2111.3744.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Sat, 2 Oct 2010, Zhang Rui wrote:

> 
> ACPI AC/Battery/SBS driver has different kernel option for procfs and sysfs I/F.
> 
> This patch,
> 1. Change CONFIG_ACPI_PROCFS_POWER to 'n' by default so that we can remove it in the next release or two.
> 2. Remove CONFIG_ACPI_SYSFS_POWER and always build in the sysfs I/F of these drivers.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/Kconfig   |    9 +--------
>  drivers/acpi/ac.c      |   14 --------------
>  drivers/acpi/battery.c |   21 ---------------------
>  drivers/acpi/sbs.c     |   25 -------------------------
>  4 files changed, 1 insertion(+), 68 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/Kconfig
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/Kconfig
> +++ linux-2.6/drivers/acpi/Kconfig
> @@ -66,7 +66,7 @@ config ACPI_PROCFS
>  config ACPI_PROCFS_POWER
>  	bool "Deprecated power /proc/acpi directories"
>  	depends on PROC_FS
> -	default y
> +	default n

"default n" is redundant, since Kconfig defaults to 'n'
when no default is specified.


> -config ACPI_SYSFS_POWER
> -	bool "Future power /sys interface"
> -	select POWER_SUPPLY

If we stop selecting POWER_SUPPLY here,
we become exposed to a build error:

drivers/built-in.o: In function `sysfs_remove_battery':
battery.c:(.text+0x5106e): undefined reference to 
`power_supply_unregister'
drivers/built-in.o: In function `acpi_battery_update':
battery.c:(.text+0x5162b): undefined reference to `power_supply_register'
drivers/built-in.o: In function `acpi_battery_notify':
battery.c:(.text+0x516ed): undefined reference to `power_supply_changed'


thanks,
Len Brown, Intel Open Source Technology Center

