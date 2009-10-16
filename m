From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 4/4] ACPI: Battery: Add support for _BIX extended info
	method
Date: Fri, 16 Oct 2009 10:08:05 +0100
Message-ID: <9b2b86520910160208l5bc6e20dkca79ae54505428ed@mail.gmail.com>
References: <20091015103122.3853.34760.stgit@thinkpad>
	 <20091015103144.3853.9717.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:49141 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757047AbZJPJIn (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 16 Oct 2009 05:08:43 -0400
Received: by fxm18 with SMTP id 18so2145164fxm.37
        for <Linux-acpi@vger.kernel.org>; Fri, 16 Oct 2009 02:08:05 -0700 (PDT)
In-Reply-To: <20091015103144.3853.9717.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On 10/15/09, Alexey Starikovskiy <astarikovskiy@suse.de> wrote:
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
>
>  drivers/acpi/battery.c |   59
> +++++++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 53 insertions(+), 6 deletions(-)
>
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 7adc1fa..4ac8f2d 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -54,6 +54,7 @@
>  #define ACPI_BATTERY_DEVICE_NAME	"Battery"
>  #define ACPI_BATTERY_NOTIFY_STATUS	0x80
>  #define ACPI_BATTERY_NOTIFY_INFO	0x81
> +#define ACPI_BATTERY_NOTIFY_THRESHOLD   0x82
>
>  #define _COMPONENT		ACPI_BATTERY_COMPONENT
>
> @@ -90,6 +91,7 @@ MODULE_DEVICE_TABLE(acpi, battery_device_ids);
>
>  enum {
>  	ACPI_BATTERY_ALARM_PRESENT,
> +	ACPI_BATTERY_XINFO_PRESENT,
>  	/* For buggy DSDTs that report negative 16-bit values for either charging
>  	* or discharging current and/or report 0 as 65536 due to bad math.
>  	*/
> @@ -112,6 +114,12 @@ struct acpi_battery {
>  	int design_voltage;
>  	int design_capacity_warning;
>  	int design_capacity_low;
> +	int cycle_count;
> +	int measurement_accuracy;
> +	int max_sampling_time;
> +	int min_sampling_time;
> +	int max_averaging_interval;
> +	int min_averaging_interval;
>  	int capacity_granularity_1;
>  	int capacity_granularity_2;
>  	int alarm;
> @@ -200,6 +208,9 @@ static int acpi_battery_get_property(struct power_supply
> *psy,
>  	case POWER_SUPPLY_PROP_TECHNOLOGY:
>  		val->intval = acpi_battery_technology(battery);
>  		break;
> +	case POWER_SUPPLY_PROP_CYCLE_COUNT:
> +		val->intval = battery->cycle_count;
> +		break;

So userspace is supposed to realise that "0" means "this attribute is
not supported", as opposed to "I am a brand new battery and don't
remember being factory-tested".

How about returning -1 for batteries without _BIX?

<reads spec>.  Particularly since Cycle Count in _BIX is spec'ed to
return 0xFFFFFFFF for unknown, which we will return as -1, no?

Regards
Alan
