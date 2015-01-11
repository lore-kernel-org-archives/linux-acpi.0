From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: check the result of ioremap
Date: Sun, 11 Jan 2015 23:35:30 +0100
Message-ID: <1758606.yZCgaz5aih@vostro.rjw.lan>
References: <1420703845-85859-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49352 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751187AbbAKWNM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Jan 2015 17:13:12 -0500
In-Reply-To: <1420703845-85859-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Thursday, January 08, 2015 09:57:25 AM Heikki Krogerus wrote:
> If it fails we have to skip the device.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

"stable" stuff?  Which version if so?

> ---
>  drivers/acpi/acpi_lpss.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 4f3febf..d12f98a 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -340,6 +340,8 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
>  				pdata->mmio_size = resource_size(&rentry->res);
>  			pdata->mmio_base = ioremap(rentry->res.start,
>  						   pdata->mmio_size);
> +			if (!pdata->mmio_base)
> +				goto err_out;
>  			break;
>  		}
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
