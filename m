From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI Battery: Added capacity
Date: Fri, 06 Apr 2012 21:28:44 -0400
Message-ID: <4F7F984C.5010907@kernel.org>
References: <1333672734-10536-1-git-send-email-srinivas.pandruvada@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:38426 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab2DGB2s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Apr 2012 21:28:48 -0400
Received: by qcro28 with SMTP id o28so1697036qcr.19
        for <linux-acpi@vger.kernel.org>; Fri, 06 Apr 2012 18:28:47 -0700 (PDT)
In-Reply-To: <1333672734-10536-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: linux-acpi@vger.kernel.org

Can't this be computed in user-space?

-L

On 04/05/2012 08:38 PM, srinivas pandruvada wrote:

> Added Capacity field, which is a pre-defined power_supply
> property. Calculating capacity using current charge/energy and
> full charge/energy.
> Some user mode implementations are relying on capacity field to
> show battery strength and power down decision.
> 
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
> ---
>  drivers/acpi/battery.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index fcc13ac..997b369 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -251,6 +251,13 @@ static int acpi_battery_get_property(struct power_supply *psy,
>  		else
>  			val->intval = battery->capacity_now * 1000;
>  		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		if (battery->capacity_now && battery->full_charge_capacity)
> +			val->intval = battery->capacity_now * 100/
> +					battery->full_charge_capacity;
> +		else
> +			val->intval = 0;
> +		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME:
>  		val->strval = battery->model_number;
>  		break;
> @@ -277,6 +284,7 @@ static enum power_supply_property charge_battery_props[] = {
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CHARGE_FULL,
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> @@ -293,6 +301,7 @@ static enum power_supply_property energy_battery_props[] = {
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_FULL,
>  	POWER_SUPPLY_PROP_ENERGY_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,


