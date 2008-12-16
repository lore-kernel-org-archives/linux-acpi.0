From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC][PATCH] ACPI: battery: add power_{now, avg} properties to
	power_class
Date: Tue, 16 Dec 2008 12:18:45 -0200
Message-ID: <20081216141845.GB13379@khazad-dum.debian.net>
References: <20081215213855.8414.9349.stgit@thinkpad> <20081216012204.GF10767@khazad-dum.debian.net> <49476C89.3050707@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36310 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753501AbYLPOSu (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 09:18:50 -0500
Content-Disposition: inline
In-Reply-To: <49476C89.3050707@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Tue, 16 Dec 2008, Alexey Starikovskiy wrote:
> Henrique de Moraes Holschuh wrote:
>> On Tue, 16 Dec 2008, Alexey Starikovskiy wrote:
>>> @@ -224,10 +224,12 @@ static int acpi_sbs_battery_get_property(struct power_supply *psy,
>>>  				acpi_battery_vscale(battery) * 1000;
>>>  		break;
>>>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>>> +	case POWER_SUPPLY_PROP_POWER_NOW:
>>>  		val->intval = abs(battery->current_now) *
>>>  				acpi_battery_ipscale(battery) * 1000;
>>>  		break;
>>>  	case POWER_SUPPLY_PROP_CURRENT_AVG:
>>> +	case POWER_SUPPLY_PROP_POWER_AVG:
>>>  		val->intval = abs(battery->current_avg) *
>>>  				acpi_battery_ipscale(battery) * 1000;
>>>  		break;
>>
>> Excuse me if I am talking nonsense (I have looked over just the patch,
>> not the entire file), but how can that be correct?  It is either power
>> or current, it cannot be both, so the CURRENT case should be dropped.
> file name under /sys depends on property, so if we want some variable to
> be named as current_now, it should be returned by case POWER_SUPPLY_PROP_CURRENT_NOW.
> Then we register with power_supply, we say which set of properties (either charge or energy) we support,
> so for one battery we will receive request for either CURRENT_AVG or POWER_AVG, not both.
>> And if it is power, why have fields named current_now... or is
>> ipscale() a voltage, and not a scaling factor?
> ipscale stands for I/P scaling, as opposed to V scaling -- it depends on units returned by actual battery.
> All energy/charge fields are reused, so battery->current_now contains either power_now or current_now from battery.

I see.  But that's a loaded-spring trap waiting for the unaware.  Can it be
called something else that is neutral re. power or current, pretty please?
even "current_or_power_now" would be less confusing...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
