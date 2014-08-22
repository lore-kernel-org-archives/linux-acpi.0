From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Run fixed button devices' notify callback in the process context
Date: Fri, 22 Aug 2014 19:33:55 +0200
Message-ID: <3313221.quKCYo2xmm@vostro.rjw.lan>
References: <1408693091-16268-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57596 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932696AbaHVROx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Aug 2014 13:14:53 -0400
In-Reply-To: <1408693091-16268-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, bebl@mageta.org, davem@davemloft.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, August 22, 2014 03:37:55 PM Lan Tianyu wrote:
> Currently fixed button devices' notify callbacks are running in the
> interrupt context. It's not necessary and prevent calling functions
> with mutex lock(E,G evaluating ACPI method). Otherwise, it's different
> with non-fixed button device whose notify callback is running in the process
> context. This patch is to make fixed button device's notify
> callback in the process context and this also can avoid dead lock
> when using netlink to report button event to user space.

I guess this is the main reason for the patch?

Is there a bug report regarding this?

> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/acpi/scan.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0a817ad..bfb7fc5 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -922,12 +922,17 @@ static void acpi_device_notify(acpi_handle handle, u32 event, void *data)
>  	device->driver->ops.notify(device, event);
>  }
>  
> -static acpi_status acpi_device_notify_fixed(void *data)
> +static void acpi_device_notify_fixed_run(void *data)
>  {
>  	struct acpi_device *device = data;
>  
> -	/* Fixed hardware devices have no handles */
>  	acpi_device_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
> +}
> +
> +static acpi_status acpi_device_notify_fixed(void *data)
> +{
> +	/* Fixed hardware devices have no handles */
> +	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_device_notify_fixed_run, data);
>  	return AE_OK;
>  }
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
