From: Andrew Morton <akpm@osdl.org>
Subject: Re: "Device is not power manageable"
Date: Tue, 21 Feb 2006 19:08:40 -0800
Message-ID: <20060221190840.5e67d07e.akpm@osdl.org>
References: <20060221042708.653944c1.akpm@osdl.org>
	<20060221185920.df65a7e3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:61335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751242AbWBVDKY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Feb 2006 22:10:24 -0500
In-Reply-To: <20060221185920.df65a7e3.rdunlap@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-acpi@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> Here's the patch that I have used.
> 
>  -- 
> 
>  From: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
> 
>  Identify which device is not power-manageable to make
>  the message more useful.
> 
>  Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
>  ---
>   drivers/acpi/bus.c |    5 +++--
>   1 files changed, 3 insertions(+), 2 deletions(-)
> 
>  --- linux-2616-rc4.orig/drivers/acpi/bus.c
>  +++ linux-2616-rc4/drivers/acpi/bus.c
>  @@ -197,8 +197,9 @@ int acpi_bus_set_power(acpi_handle handl
>   	/* Make sure this is a valid target state */
>   
>   	if (!device->flags.power_manageable) {
>  -		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
>  -				  "Device is not power manageable\n"));
>  +		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  +				  "Device '%s' is not power manageable\n",
>  +					device->kobj.name));
>   		return_VALUE(-ENODEV);
>   	}
>   	/*

Thanks.  I guess that won't be very popular due to using linux-specific
stuff in a generic file, but I'll merge it.

