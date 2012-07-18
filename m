From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] ACPI: battery: fix battery->alarm is updated when it
 is not supported
Date: Thu, 19 Jul 2012 00:16:46 +0800
Message-ID: <5006E16E.9070202@canonical.com>
References: <1337515556-5232-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58848 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab2GRQQx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2012 12:16:53 -0400
In-Reply-To: <1337515556-5232-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Hi,

I haven't received any feedback for the patch. I am wondering whether I 
can improve the patch or the extra check is not needed.

Any suggestion is the most appreciated.

Best Regards,
Alex Hung

On 05/20/2012 08:05 PM, Alex Hung wrote:
> battery alarm is checked whether BIOS supports it before past to BIOS;
> however, the value is updatd without being checked. This causes alarm return
> an incorrect value that never represents an actual state BIOS is in.
>
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>   drivers/acpi/battery.c |    6 ++++--
>   1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 86933ca..14548e8 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -535,7 +535,8 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
>   {
>   	unsigned long x;
>   	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
> -	if (sscanf(buf, "%ld\n", &x) == 1)
> +	if (sscanf(buf, "%ld\n", &x) == 1 &&
> +		test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
>   		battery->alarm = x/1000;
>   	if (acpi_battery_present(battery))
>   		acpi_battery_set_alarm(battery);
> @@ -805,7 +806,8 @@ static ssize_t acpi_battery_write_alarm(struct file *file,
>   		goto end;
>   	}
>   	alarm_string[count] = '\0';
> -	battery->alarm = simple_strtol(alarm_string, NULL, 0);
> +	if (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
> +		battery->alarm = simple_strtol(alarm_string, NULL, 0);
>   	result = acpi_battery_set_alarm(battery);
>         end:
>   	if (!result)
>

