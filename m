From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: ACPI: Always return valid 'status' from acpi_battery_get_property()
Date: Thu, 08 Nov 2007 11:29:07 +0300
Message-ID: <4732C8D3.605@suse.de>
References: <87640d1wmi.fsf@shaolin.home.digitalvampire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:57611 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750708AbXKHI3d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Nov 2007 03:29:33 -0500
In-Reply-To: <87640d1wmi.fsf@shaolin.home.digitalvampire.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roland Dreier <roland@digitalvampire.org>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

Thanks,
Alex.

Roland Dreier wrote:
> If a battery is at a critical charge level and not being charged or
> discharged, then the ACPI _BST method will return a state of 4, and
> the current acpi_battery_get_property() code will not set any property
> value for POWER_SUPPLY_PROP_STATUS.  This will cause an oops in
> power_supply_show_property() when it reads off the end of the
> status_text array.  This actually was causing a 100% reproducible
> crash on boot on my laptop with two batteries, when one battery was
> completely drained and the laptop was not plugged in.
> 
> Fix this by making sure acpi_battery_get_property() returns
> POWER_SUPPLY_STATUS_UNKNOWN for any battery state it doesn't already
> handle explicitly.  There doesn't seem to be any status enum value
> defined that makes more sense than 'unknown' for a battery at a
> critical charge level.
> 
> Signed-off-by: Roland Dreier <roland@digitalvampire.org>
Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index c2ce0ad..cbb27b4 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -152,6 +152,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
>  			val->intval = POWER_SUPPLY_STATUS_CHARGING;
>  		else if (battery->state == 0)
>  			val->intval = POWER_SUPPLY_STATUS_FULL;
> +		else
> +			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
>  		break;
>  	case POWER_SUPPLY_PROP_PRESENT:
>  		val->intval = acpi_battery_present(battery);

