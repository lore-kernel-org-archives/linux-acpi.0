From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] ACPI: battery: add sysfs serial number
Date: Tue, 22 Jan 2008 21:00:09 +0300
Message-ID: <47962F29.7000102@suse.de>
References: <1201024010-6103-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:47826 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751045AbYAVSAz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 13:00:55 -0500
In-Reply-To: <1201024010-6103-1-git-send-email-max@stro.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

ACK
maximilian attems wrote:
> egrep serial /proc/acpi/battery/BAT0/info
> serial number:           32090
> 
> serial number can tell you from the imminent danger
> of beeing set on fire.
> 
> Signed-off-by: maximilian attems <max@stro.at>
> ---
>  drivers/acpi/battery.c             |    5 +++++
>  drivers/power/power_supply_sysfs.c |    1 +
>  include/linux/power_supply.h       |    1 +
>  3 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index c4a769d..f6215e8 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -194,6 +194,9 @@ static int acpi_battery_get_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_MANUFACTURER:
>  		val->strval = battery->oem_info;
>  		break;
> +	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> +		val->strval = battery->serial_number;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -212,6 +215,7 @@ static enum power_supply_property charge_battery_props[] = {
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
>  };
>  
>  static enum power_supply_property energy_battery_props[] = {
> @@ -226,6 +230,7 @@ static enum power_supply_property energy_battery_props[] = {
>  	POWER_SUPPLY_PROP_ENERGY_NOW,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
>  };
>  #endif
>  
> diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
> index 249f61b..8feaa48 100644
> --- a/drivers/power/power_supply_sysfs.c
> +++ b/drivers/power/power_supply_sysfs.c
> @@ -117,6 +117,7 @@ static struct device_attribute power_supply_attrs[] = {
>  	/* Properties of type `const char *' */
>  	POWER_SUPPLY_ATTR(model_name),
>  	POWER_SUPPLY_ATTR(manufacturer),
> +	POWER_SUPPLY_ATTR(serial_number),
>  };
>  
>  static ssize_t power_supply_show_static_attrs(struct device *dev,
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 606c095..300159b 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -101,6 +101,7 @@ enum power_supply_property {
>  	/* Properties of type `const char *' */
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
>  };
>  
>  enum power_supply_type {

