From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / battery: drop redundant test for failure
Date: Sat, 16 Dec 2017 02:54:11 +0100
Message-ID: <1900895.geBAr4jvZM@aspire.rjw.lan>
References: <20171205174639.672-1-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57939 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756152AbdLPBy5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 20:54:57 -0500
In-Reply-To: <20171205174639.672-1-bjorn@mork.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, December 5, 2017 6:46:39 PM CET Bjørn Mork wrote:
> Merging the two adjacent conditionally built blocks makes the code
> a lot more readable.  And as a bonus, we drop a duplicate test when
> CONFIG_ACPI_PROCFS_POWER is undefined.
> 
> Signed-off-by: Bjørn Mork <bjorn@mork.no>
> ---
>  drivers/acpi/battery.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 13e7b56e33ae..f2eb6c37ea0a 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1237,13 +1237,11 @@ static int acpi_battery_add(struct acpi_device *device)
>  
>  #ifdef CONFIG_ACPI_PROCFS_POWER
>  	result = acpi_battery_add_fs(device);
> -#endif
>  	if (result) {
> -#ifdef CONFIG_ACPI_PROCFS_POWER
>  		acpi_battery_remove_fs(device);
> -#endif
>  		goto fail;
>  	}
> +#endif
>  
>  	printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
>  		ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
> 

Applied, thanks!


