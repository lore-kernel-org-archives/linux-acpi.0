From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PM: remove leading whitespace from #ifdef
Date: Tue, 15 Jan 2013 01:04:39 +0100
Message-ID: <5272741.Mx404yLOW6@vostro.rjw.lan>
References: <1358194417-10477-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40823 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757180Ab3ANX6t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jan 2013 18:58:49 -0500
In-Reply-To: <1358194417-10477-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

On Monday, January 14, 2013 10:13:37 PM Mika Westerberg wrote:
> It is there probably due to an accident, get rid of it so that the format
> is consistent across the file.

Applied.

Thanks,
Rafael


> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/device_pm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 8bca746..43116cd 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -592,7 +592,7 @@ static inline void acpi_wakeup_device(acpi_handle handle, u32 event,
>  				      void *context) {}
>  #endif /* CONFIG_PM_RUNTIME */
>  
> - #ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_PM_SLEEP
>  /**
>   * __acpi_device_sleep_wake - Enable or disable device to wake up the system.
>   * @dev: Device to enable/desible to wake up the system.
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
