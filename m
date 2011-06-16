From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] ACPI: use after free in acpi_battery_add()
Date: Thu, 16 Jun 2011 22:18:58 +0300
Message-ID: <BANLkTinOEVR=8kqpyee2VoKh12tWOhVgaQ@mail.gmail.com>
References: <20110329031210.GA9856@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33393 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756995Ab1FPTS7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jun 2011 15:18:59 -0400
In-Reply-To: <20110329031210.GA9856@bicker>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org, kyle@redhat.com

It seems like this patch was missed.

regards,
dan carpenter

On 3/29/11, Dan Carpenter <error27@gmail.com> wrote:
> "battery" was dereferenced on the error path here.
>
> Signed-off-by: Dan Carpenter <error27@gmail.com>
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index fcc13ac..cfc7a5b 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -988,6 +988,7 @@ static int acpi_battery_add(struct acpi_device *device)
>  		acpi_battery_remove_fs(device);
>  #endif
>  		kfree(battery);
> +		return result;
>  	}
>
>  	battery->pm_nb.notifier_call = battery_notify;
>
