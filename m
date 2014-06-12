From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] ACPI/Battery: Retry to get Battery information if failed
 during probing
Date: Wed, 11 Jun 2014 23:55:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1406112354070.23724@chino.kir.corp.google.com>
References: <1402552946-14704-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:50031 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734AbaFLGzw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2014 02:55:52 -0400
Received: by mail-ie0-f180.google.com with SMTP id rl12so761854iec.39
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jun 2014 23:55:52 -0700 (PDT)
In-Reply-To: <1402552946-14704-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, naszar@ya.ru, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Thu, 12 Jun 2014, Lan Tianyu wrote:

> Some machines'(E,G Lenovo Z480) ECs are not stable during boot up
> and causes battery driver fails to be probed due to failure of getting
> battery information from EC sometimes. After several retries, the
> operation will work. This patch is to retry to get battery information 5
> times if the first try fails.
> 
> Reported-and-tested-by: naszar <naszar@ya.ru>
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=75581
> Cc: stable@vger.kernel.org
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/acpi/battery.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index e48fc98..485009d 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -34,6 +34,7 @@
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
> +#include <linux/delay.h>
>  #include <asm/unaligned.h>
>  
>  #ifdef CONFIG_ACPI_PROCFS_POWER
> @@ -1119,7 +1120,7 @@ static struct dmi_system_id bat_dmi_table[] = {
>  
>  static int acpi_battery_add(struct acpi_device *device)
>  {
> -	int result = 0;
> +	int result = 0, retry = 5;
>  	struct acpi_battery *battery = NULL;
>  
>  	if (!device)
> @@ -1135,7 +1136,16 @@ static int acpi_battery_add(struct acpi_device *device)
>  	mutex_init(&battery->sysfs_lock);
>  	if (acpi_has_method(battery->device->handle, "_BIX"))
>  		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
> +
> +retry_get_info:
>  	result = acpi_battery_update(battery, false);
> +
> +	if (result && retry) {
> +		msleep(20);

We're really going to wait up to 20 * 5 = 100ms for acpi_battery_update() 
to succeed?  How are these the numbers that are determined to be optimal 
for probing?

> +		retry--;
> +		goto retry_get_info;
> +	}

This most certainly could be rewritten as a for-loop and remove the ugly 
goto.

> +
>  	if (result)
>  		goto fail;
>  #ifdef CONFIG_ACPI_PROCFS_POWER
