From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: add Haswell LPSS devices to acpi_platform_device_ids list
Date: Fri, 07 Dec 2012 23:28:32 +0100
Message-ID: <2687190.2D3RhPKGYB@vostro.rjw.lan>
References: <1354874882-1162-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44638 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971Ab2LGWXg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2012 17:23:36 -0500
In-Reply-To: <1354874882-1162-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On Friday, December 07, 2012 12:08:02 PM Mika Westerberg wrote:
> All devices behind Haswell LPSS (Low Power Subsystem) should be represented
> as platform devices so add them to the acpi_platform_device_ids list.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied.

Thanks,
Rafael


> ---
>  drivers/acpi/scan.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 67a7fa6..8ee379e 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -37,6 +37,16 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
>  
>  	{ "PNP0D40" },
>  
> +	/* Haswell LPSS devices */
> +	{ "INT33C0", 0 },
> +	{ "INT33C1", 0 },
> +	{ "INT33C2", 0 },
> +	{ "INT33C3", 0 },
> +	{ "INT33C4", 0 },
> +	{ "INT33C5", 0 },
> +	{ "INT33C6", 0 },
> +	{ "INT33C7", 0 },
> +
>  	{ }
>  };
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
