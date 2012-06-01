From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI Battery: Added capacity
Date: Fri, 01 Jun 2012 19:00:00 -0400
Message-ID: <4FC94970.20403@kernel.org>
References: <1333672734-10536-1-git-send-email-srinivas.pandruvada@intel.com> <4F7F984C.5010907@kernel.org> <4FA419E87744DF4DAECD5BCE1214B7A9170E8316@ORSMSX104.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:47950 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965935Ab2FAXAF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jun 2012 19:00:05 -0400
Received: by qabj40 with SMTP id j40so1002562qab.1
        for <linux-acpi@vger.kernel.org>; Fri, 01 Jun 2012 16:00:04 -0700 (PDT)
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A9170E8316@ORSMSX104.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 04/09/2012 10:59 AM, Pandruvada, Srinivas wrote:

> This can be computed in user space. But this patch is targeting ANDROID, where this needs change in Android framework. Other battery drivers are providing this field, so added this field in ACPI battery also.

okay.

Applied.

thanks,
Len Brown, Intel Open Source Technology Center


> -----Original Message-----
> From: Len Brown [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> Sent: Friday, April 06, 2012 6:29 PM
> To: Pandruvada, Srinivas
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: [PATCH] ACPI Battery: Added capacity
> 
> Can't this be computed in user-space?
> 
> -L
> 
> On 04/05/2012 08:38 PM, srinivas pandruvada wrote:
> 
>> Added Capacity field, which is a pre-defined power_supply property. 
>> Calculating capacity using current charge/energy and full 
>> charge/energy.
>> Some user mode implementations are relying on capacity field to show 
>> battery strength and power down decision.
>>
>> Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
>> ---
>>  drivers/acpi/battery.c |    9 +++++++++
>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c index 
>> fcc13ac..997b369 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -251,6 +251,13 @@ static int acpi_battery_get_property(struct power_supply *psy,
>>  		else
>>  			val->intval = battery->capacity_now * 1000;
>>  		break;
>> +	case POWER_SUPPLY_PROP_CAPACITY:
>> +		if (battery->capacity_now && battery->full_charge_capacity)
>> +			val->intval = battery->capacity_now * 100/
>> +					battery->full_charge_capacity;
>> +		else
>> +			val->intval = 0;
>> +		break;
>>  	case POWER_SUPPLY_PROP_MODEL_NAME:
>>  		val->strval = battery->model_number;
>>  		break;
>> @@ -277,6 +284,7 @@ static enum power_supply_property charge_battery_props[] = {
>>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>>  	POWER_SUPPLY_PROP_CHARGE_FULL,
>>  	POWER_SUPPLY_PROP_CHARGE_NOW,
>> +	POWER_SUPPLY_PROP_CAPACITY,
>>  	POWER_SUPPLY_PROP_MODEL_NAME,
>>  	POWER_SUPPLY_PROP_MANUFACTURER,
>>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,
>> @@ -293,6 +301,7 @@ static enum power_supply_property energy_battery_props[] = {
>>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>>  	POWER_SUPPLY_PROP_ENERGY_FULL,
>>  	POWER_SUPPLY_PROP_ENERGY_NOW,
>> +	POWER_SUPPLY_PROP_CAPACITY,
>>  	POWER_SUPPLY_PROP_MODEL_NAME,
>>  	POWER_SUPPLY_PROP_MANUFACTURER,
>>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> 
> 


