From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: check the online state of all children in container
Date: Wed, 22 Mar 2017 01:58:30 +0100
Message-ID: <4105478.B7tRAuaXDe@aspire.rjw.lan>
References: <20170322010148.32675-1-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55450 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757730AbdCVBGK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Mar 2017 21:06:10 -0400
In-Reply-To: <20170322010148.32675-1-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Michal Hocko <mhocko@suse.com>, Jiri Kosina <jkosina@suse.cz>

On Wednesday, March 22, 2017 09:01:48 AM Lee, Chun-Yi wrote:
> Just checking the state of container is not enough to confirm that
> the whole container is offlined.

And why is that so?

> Kernel should checks all children's
> offline state as the logic in acpi_container_offline().
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  drivers/acpi/scan.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 1926918..f08ca31 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -260,13 +260,15 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
>  static int acpi_scan_hot_remove(struct acpi_device *device)
>  {
>  	acpi_handle handle = device->handle;
> +	struct acpi_device *child;
>  	unsigned long long sta;
>  	acpi_status status;
>  
>  	if (device->handler && device->handler->hotplug.demand_offline
>  	    && !acpi_force_hot_remove) {
> -		if (!acpi_scan_is_offline(device, true))
> -			return -EBUSY;
> +		list_for_each_entry(child, &device->children, node)
> +			if (!acpi_scan_is_offline(child, false))
> +				return -EBUSY;
>  	} else {
>  		int error = acpi_scan_try_to_offline(device);
>  		if (error)
> 

