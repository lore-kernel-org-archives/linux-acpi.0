From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 2/7] ACPI / LPSS: allow to use specific PM domain
 during ->probe()
Date: Thu, 26 Nov 2015 18:30:26 +0200
Message-ID: <565733A2.6050900@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1448551153-84719-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:47570 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbbKZQaa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Nov 2015 11:30:30 -0500
In-Reply-To: <1448551153-84719-3-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On 11/26/2015 05:19 PM, Andy Shevchenko wrote:
> This is an amendment to previously pushed commit 01ac170ba29a (ACPI / LPSS:
> allow to use specific PM domain during ->probe()). We can't assign anything to
> the platform device on ADD_DEVICE stage since it might be changed during
> unbound / bind cycle.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/acpi/acpi_lpss.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index f9e0d09..e840229 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -705,8 +705,14 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
>   	}
>
>   	switch (action) {
> -	case BUS_NOTIFY_ADD_DEVICE:
> +	case BUS_NOTIFY_BIND_DRIVER:
>   		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
> +		break;
> +	case BUS_NOTIFY_BIND_DRIVER_ERROR:
> +	case BUS_NOTIFY_UNBOUND_DRIVER:
> +		pdev->dev.pm_domain = NULL;
> +		break;
> +	case BUS_NOTIFY_ADD_DEVICE:

This won't fix like revert of original commit does. Primary problem here 
is that there is no explicit power on at all during LPSS device probe 
because dev->pm_domain is set before probing.

driver_probe_device
   platform_drv_prove
     dev_pm_domain_attach
       acpi_dev_pm_attach
         returns instantly because of dev->pm_domain is set

Problem got unnoticed because devices are on during boot but 
rmmod/modprobe cycle will hit it.

With this patch situation remains the same but works if you assign the 
domain after probing when BUS_NOTIFY_BOUND_DRIVER notification comes 
(s/BUS_NOTIFY_BIND_DRIVER/BUS_NOTIFY_BOUND_DRIVER/ above).

-- 
Jarkko

