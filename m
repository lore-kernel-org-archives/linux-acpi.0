From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] ACPI / LPSS: make code less confusing for reader
Date: Tue, 26 Mar 2013 14:36:30 +0100
Message-ID: <1536658.klx7ZE7lrX@vostro.rjw.lan>
References: <1363781670-28775-1-git-send-email-andriy.shevchenko@linux.intel.com> <1363781670-28775-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43091 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932367Ab3CZN3E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Mar 2013 09:29:04 -0400
In-Reply-To: <1363781670-28775-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wednesday, March 20, 2013 02:14:30 PM Andy Shevchenko wrote:
> The excerpt like this:
> 
> 	if (err) {
> 		err = 0;
> 		goto error_out;
> 	}
> 
> makes a reader confused even if it's commented. Let's do necessary actions and
> return no error explicitly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to linux-pm.git/linux-next.

Thanks,
Rafael


> ---
>  drivers/acpi/acpi_lpss.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index c695841..5d7ded2 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -152,8 +152,8 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
>  			 * Skip the device, but don't terminate the namespace
>  			 * scan.
>  			 */
> -			ret = 0;
> -			goto err_out;
> +			kfree(pdata);
> +			return 0;
>  		}
>  	}
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
