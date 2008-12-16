From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC][PATCH] ACPI: battery: add power_{now, avg} properties to
 power_class
Date: Tue, 16 Dec 2008 18:28:36 +0300
Message-ID: <4947C924.6090002@suse.de>
References: <20081215213855.8414.9349.stgit@thinkpad> <200812161617.21420.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:39060 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755793AbYLPP2o (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 16 Dec 2008 10:28:44 -0500
In-Reply-To: <200812161617.21420.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 15 of December 2008, Alexey Starikovskiy wrote:
>> ACPI has smart batteries, which work in units of energy and measure
>> rate of (dis)charge as power, thus it is not appropriate to export it
>> as a current_now.
>>
>> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
>> ---
>>
>>  drivers/acpi/battery.c             |    3 ++-
>>  drivers/acpi/sbs.c                 |    6 ++++--
>>  drivers/power/power_supply_sysfs.c |    2 ++
>>  include/linux/power_supply.h       |    2 ++
>>  4 files changed, 10 insertions(+), 3 deletions(-)
>>
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 1423b0c..88f1fb5 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -173,6 +173,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
>>  		val->intval = battery->voltage_now * 1000;
>>  		break;
>>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>> +	case POWER_SUPPLY_PROP_POWER_NOW:
>>  		val->intval = battery->current_now * 1000;
>>  		break;
>>  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>> @@ -223,7 +224,7 @@ static enum power_supply_property energy_battery_props[] = {
>>  	POWER_SUPPLY_PROP_TECHNOLOGY,
>>  	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
>>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>> -	POWER_SUPPLY_PROP_CURRENT_NOW,
>> +	POWER_SUPPLY_PROP_POWER_NOW,
>>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>>  	POWER_SUPPLY_PROP_ENERGY_FULL,
>>  	POWER_SUPPLY_PROP_ENERGY_NOW,
>> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
>> index 6050ce4..994c04e 100644
>> --- a/drivers/acpi/sbs.c
>> +++ b/drivers/acpi/sbs.c
>> @@ -224,10 +224,12 @@ static int acpi_sbs_battery_get_property(struct power_supply *psy,
>>  				acpi_battery_vscale(battery) * 1000;
>>  		break;
>>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>> +	case POWER_SUPPLY_PROP_POWER_NOW:
>>  		val->intval = abs(battery->current_now) *
>>  				acpi_battery_ipscale(battery) * 1000;
> 
> Please introduce another field called 'battery->power_now' for this purpose.
> Otherwise, confusion is guaranteed to ensue.
How about 'battery->rate_now' for both cases? All other fields are re-used as well, and it did not cause any confusion.
Probably no-one ever looked at this code.
> 
>>  		break;
>>  	case POWER_SUPPLY_PROP_CURRENT_AVG:
>> +	case POWER_SUPPLY_PROP_POWER_AVG:
>>  		val->intval = abs(battery->current_avg) *
>>  				acpi_battery_ipscale(battery) * 1000;
> 
> Same here.
> 
> Also, as per our IRC conversation, I'd like 'current_now' to be reported even
> if energy units are used, at least for some time, to give a chance to the user
> land to switch to 'power_now' and 'power_avg' without pain.
To clarify, you suggest that "current_now" will report same value 
as "power_now" in case of energy units?
> 
> You can put information about that into
> Documentation/feature-removal-schedule.txt and say that after 2.6.29
> 'current_now' will no longer be reported when energy units are used.
Sounds good.

Thanks,
Alex.
> 
> Thanks,
> Rafael

