From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/7] ACPI: delete CONFIG_ACPI_PROCFS_POWER
Date: Mon, 13 Dec 2010 23:59:39 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012132356120.23573@x980>
References: <1291619053.19296.575.camel@rui>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:63383 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758105Ab0LNE7z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Dec 2010 23:59:55 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDE004TRJ7H6Q55@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 13 Dec 2010 22:59:49 -0600 (CST)
In-reply-to: <1291619053.19296.575.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 6 Dec 2010, Zhang Rui wrote:

> 
> CONFIG_ACPI_PROCFS_POWER is introduced to use the ac and battery driver
> procfs I/F even if CONFIG_ACPI_PROCFS is cleared.
> This is not useful anymore because we want to use the sysfs I/F of
> these drivers, and remove the deprecated procfs I/F permanently in 2.6.39.
> 
> So delete this kernel config and fold into CONFIG_ACPI_PROCFS.

Per our discussion tonight, lets keep CONFIG_ACPI_PROCFS.
We just changed it to default to =n in 2.6.36, and even
that caused complaints -- so there are still users out
there of /proc/acpi/batter, even though /sys/class/power_supply
shipped in 2007.

In 2.6.38, lets add it to feature-removal.txt,
say for a year from now, and add a (single) run-time
warning on access.

thanks,
-Len

> Sign-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/Kconfig   |   15 ---------------
>  drivers/acpi/Makefile  |    2 +-
>  drivers/acpi/ac.c      |   20 ++++++++++----------
>  drivers/acpi/battery.c |   20 ++++++++++----------
>  drivers/acpi/sbs.c     |   20 ++++++++++----------
>  5 files changed, 31 insertions(+), 46 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/Kconfig
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/Kconfig
> +++ linux-2.6/drivers/acpi/Kconfig
> @@ -62,21 +62,6 @@ config ACPI_PROCFS
>  
>  	  Say N to delete /proc/acpi/ files that have moved to /sys/
>  
> -config ACPI_PROCFS_POWER
> -	bool "Deprecated power /proc/acpi directories"
> -	depends on PROC_FS
> -	help
> -	  For backwards compatibility, this option allows
> -          deprecated power /proc/acpi/ directories to exist, even when
> -          they have been replaced by functions in /sys.
> -          The deprecated directories (and their replacements) include:
> -	  /proc/acpi/battery/* (/sys/class/power_supply/*)
> -	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*)
> -	  This option has no effect on /proc/acpi/ directories
> -	  and functions, which do not yet exist in /sys
> -
> -	  Say N to delete power /proc/acpi/ directories that have moved to /sys/
> -
>  config ACPI_POWER_METER
>  	tristate "ACPI 4.0 power meter"
>  	depends on HWMON
