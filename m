From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: install ACPI table handler before any dynamic
 tables being loaded
Date: Tue, 26 Oct 2010 10:11:57 +0800
Message-ID: <1288059117.2210.167.camel@rui>
References: <1288058814.2210.165.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:56182 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372Ab0JZCMb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Oct 2010 22:12:31 -0400
In-Reply-To: <1288058814.2210.165.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "dennis.jansen@web.de" <dennis.jansen@web.de>, achiang@canonical.com

cc Alex Chiang.

On Tue, 2010-10-26 at 10:06 +0800, Zhang Rui wrote:
> ACPI table sysfs I/F is broken by commit
> 
> 78f1699659963fff97975df44db6d5dbe7218e55
> Author: Alex Chiang <achiang@hp.com>
> Date:   Sun Dec 20 12:19:09 2009 -0700
>     ACPI: processor: call _PDC early
> 
> because dynamic SSDT tables may be loaded in _PDC,
> before installing the ACPI table handler.
> As a result, the sysfs I/F of these dynamic tables are
> located at  /sys/firmware/acpi/tables instead of
> /sys/firmware/acpi/tables/dynamic, which is not true.
> 
> Invoke acpi_sysfs_init() before acpi_early_processor_set_pdc(),
> so that the table handler is installed before any dynamic tables loaded.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=21142
> 
> CC: Dennis Jansen <dennis.jansen@web.de>
> CC: Alex Chiang <achiang@hp.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/bus.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/bus.c
> +++ linux-2.6/drivers/acpi/bus.c
> @@ -935,6 +935,12 @@ static int __init acpi_bus_init(void)
>  		goto error1;
>  	}
>  
> +	/*
> +	 * _PDC control method may load dynamic SSDT tables,
> +	 * and we need to install the table handler before that.
> +	 */
> +	acpi_sysfs_init();
> +
>  	acpi_early_processor_set_pdc();
>  
>  	/*
> @@ -1026,7 +1032,6 @@ static int __init acpi_init(void)
>  	acpi_scan_init();
>  	acpi_ec_init();
>  	acpi_power_init();
> -	acpi_sysfs_init();
>  	acpi_debugfs_init();
>  	acpi_sleep_proc_init();
>  	acpi_wakeup_device_init();
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


