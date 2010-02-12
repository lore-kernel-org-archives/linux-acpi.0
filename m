From: Chris Mason <chris.mason@oracle.com>
Subject: Re: [PATCH] set dock_station->flags to zero during dock_add
Date: Fri, 12 Feb 2010 15:45:48 -0500
Message-ID: <20100212204548.GS3524@think>
References: <20100201163043.GA3240@think>
 <20100201173518.GA28002@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:31726 "EHLO
	rcsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab0BLUqk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2010 15:46:40 -0500
Content-Disposition: inline
In-Reply-To: <20100201173518.GA28002@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

On Mon, Feb 01, 2010 at 10:35:18AM -0700, Alex Chiang wrote:
> Hi Chris,
> 
> Thanks for catching this. Seems better to just memset the stack
> variable before we kmemdup it in platform_deivce_register_data().
> 

I don't see either patch in rc8, I think we want to do something for
docking in 2.6.33...Len are you interested in picking up either of these
fixes?

[ full quote below ]

-chris

> How about this instead?
> 
> ---
> From: Alex Chiang <achiang@hp.com>
> 
> ACPI: dock: properly initialize local struct dock_station in dock_add()
> 
> Commit fe06fba2 (ACPI: dock: add struct dock_station * directly
> to platform device data) changed dock_add() to use the
> platform_device_register_data() API.
> 
> We passed that interface a stack variable, which is kmemdup'ed
> and assigned to the device's platform_data pointer.
> 
> Unfortunately, whatever random garbage is in the stack variable
> gets coped during the kmemdup, and that leads to broken behavior.
> 
> Explicitly zero out the structure before passing it to the API.
> 
> Cc: stable@kernel.org
> Reported-by: Chris Mason <chris.mason@oracle.com>
> Signed-off-by: Alex Chiang <achiang@hp.com>
> ---
> Commit fe06fba2 was introduced in 2.6.32-rc5, so we need this fix
> for the .32 stable series only.
> 
> ---
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index bbc2c13..b2586f5 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -935,6 +935,7 @@ static int dock_add(acpi_handle handle)
>  	struct platform_device *dd;
>  
>  	id = dock_station_count;
> +	memset(&ds, 0, sizeof(ds));
>  	dd = platform_device_register_data(NULL, "dock", id, &ds, sizeof(ds));
>  	if (IS_ERR(dd))
>  		return PTR_ERR(dd);
