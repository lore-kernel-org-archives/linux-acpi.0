From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/7] ACPI: updating the Kconfig file
Date: Tue, 14 Dec 2010 00:03:34 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012140002410.23573@x980>
References: <1291619058.19296.577.camel@rui>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:53292 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab0LNFDx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Dec 2010 00:03:53 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDE004FHJE0IGU0@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 13 Dec 2010 23:03:42 -0600 (CST)
In-reply-to: <1291619058.19296.577.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>



On Mon, 6 Dec 2010, Zhang Rui wrote:

> Update the drivers/acpi/Kconfig file.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/Kconfig |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/Kconfig
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/Kconfig
> +++ linux-2.6/drivers/acpi/Kconfig
> @@ -52,11 +52,9 @@ config ACPI_PROCFS
>  	  deprecated /proc/acpi/ files to exist, even when
>  	  they have been replaced by functions in /sys.
>  	  The deprecated files (and their replacements) include:
> +	  /proc/acpi/ac/* (/sys/class/power_supply)
> +	  /proc/acpi/battery/* (/sys/class/power_supply/)

skipped those two lines, since we skipped patch 1/7

> -	  /proc/acpi/processor/*/throttling (/sys/class/thermal/
> -		cooling_device*/*)
> -	  /proc/acpi/video/*/brightness (/sys/class/backlight/)
> -	  /proc/acpi/thermal_zone/*/* (/sys/class/thermal/)

merged these into previous patch, which is at least 1/3rd accurate:-)

thanks,
Len Brown, Intel Open Source Technology Center

