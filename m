From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / AC: change notification handler type to ACPI_ALL_NOTIFY
Date: Sun, 05 Jan 2014 23:11:04 +0100
Message-ID: <10297406.yzztQfvCpu@vostro.rjw.lan>
References: <1388801279-15502-1-git-send-email-mezin.alexander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55030 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751629AbaAEV5T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Jan 2014 16:57:19 -0500
In-Reply-To: <1388801279-15502-1-git-send-email-mezin.alexander@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Mezin <mezin.alexander@gmail.com>
Cc: linux-acpi@vger.kernel.org, tianyu.lan@intel.com

On Saturday, January 04, 2014 09:07:59 AM Alexander Mezin wrote:
> With kernel 3.13rc5 there are no AC adapter notifications on my laptop.
> 
> Commit cc8ef52707341e67a12067d6ead991d56ea017ca
> "ACPI / AC: convert ACPI ac driver to platform bus" changed the driver
> to listen only to device notifications. However, aml code on my laptop
> notifies the driver with zero event.
> 
> This patch changes the driver to listen to all events again.
> 
> References: https://bugzilla.kernel.org/show_bug.cgi?id=67821
> 
> Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>

Queued up as a regression fix for 3.13, thanks!

> ---
>  drivers/acpi/ac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 8711e37..3c2e4aa 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -207,7 +207,7 @@ static int acpi_ac_probe(struct platform_device *pdev)
>  		goto end;
>  
>  	result = acpi_install_notify_handler(ACPI_HANDLE(&pdev->dev),
> -			ACPI_DEVICE_NOTIFY, acpi_ac_notify_handler, ac);
> +			ACPI_ALL_NOTIFY, acpi_ac_notify_handler, ac);
>  	if (result) {
>  		power_supply_unregister(&ac->charger);
>  		goto end;
> @@ -255,7 +255,7 @@ static int acpi_ac_remove(struct platform_device *pdev)
>  		return -EINVAL;
>  
>  	acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev),
> -			ACPI_DEVICE_NOTIFY, acpi_ac_notify_handler);
> +			ACPI_ALL_NOTIFY, acpi_ac_notify_handler);
>  
>  	ac = platform_get_drvdata(pdev);
>  	if (ac->charger.dev)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
