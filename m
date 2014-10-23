From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: invoke acpi_device_wakeup() with correct parameters
Date: Thu, 23 Oct 2014 23:17:12 +0200
Message-ID: <12772278.iba2CloSMG@vostro.rjw.lan>
References: <1414067127.13162.43.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55033 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752511AbaJWU4o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2014 16:56:44 -0400
In-Reply-To: <1414067127.13162.43.camel@rzhang1-toshiba>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, October 23, 2014 08:25:27 PM Zhang Rui wrote:
> From f0d75284074478790a50655bf3cc1096f5f943fa Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Thu, 23 Oct 2014 20:20:00 +0800
> Subject: [PATCH] ACPI: invoke acpi_device_wakeup() with correct parameters
> 
> Fix a bug that invokes acpi_device_wakeup() with wrong parameters.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied, thanks!

> ---
>  drivers/acpi/device_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 9177547..b4743d4 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -711,7 +711,7 @@ int acpi_pm_device_run_wake(struct device *phys_dev, bool enable)
>  		return -ENODEV;
>  	}
>  
> -	return acpi_device_wakeup(adev, enable, ACPI_STATE_S0);
> +	return acpi_device_wakeup(adev, ACPI_STATE_S0, enable);
>  }
>  EXPORT_SYMBOL(acpi_pm_device_run_wake);
>  #endif /* CONFIG_PM_RUNTIME */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
