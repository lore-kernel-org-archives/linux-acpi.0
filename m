From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi thermal: Use mode to enable/disable kernel thermal processing
Date: Wed, 16 Jan 2013 23:40:22 +0100
Message-ID: <7160136.fVlXlkUeLA@vostro.rjw.lan>
References: <1357834291-12943-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42199 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756310Ab3APWe2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2013 17:34:28 -0500
In-Reply-To: <1357834291-12943-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

On Thursday, January 10, 2013 08:11:31 AM Srinivas Pandruvada wrote:
> As per documentation, "mode" sysfs interface should be able to
> enable/disable thermal processing in kernel, so that user side
> is able to take more control.
> Currently acpi thermal driver is not following this setting.

Applied to the linux-next branch of the linux-pm.git tree as v3.9 material.

Thanks,
Rafael


> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 506fbd4..70036c8 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -531,6 +531,10 @@ static void acpi_thermal_check(void *data)
>  {
>  	struct acpi_thermal *tz = data;
>  
> +	if (!tz->tz_enabled) {
> +		pr_warn("thermal zone is disabled \n");
> +		return;
> +	}
>  	thermal_zone_device_update(tz->thermal_zone);
>  }
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
