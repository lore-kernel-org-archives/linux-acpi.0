From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: ACPI battery driver emits POWER_SUPPLY_STATUS_FULL when power
 lead plugged in
Date: Sat, 24 Jan 2009 03:14:01 +0300
Message-ID: <497A5D49.6070706@suse.de>
References: <1232729843.3504.6.camel@hughsie-work.lan>	 <497A13C0.5020604@suse.de>  <20090123220243.GB26701@khazad-dum.debian.net> <1232753981.3504.10.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:50399 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755938AbZAXANv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jan 2009 19:13:51 -0500
In-Reply-To: <1232753981.3504.10.camel@hughsie-work.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>

Richard Hughes wrote:
> On Fri, 2009-01-23 at 20:02 -0200, Henrique de Moraes Holschuh wrote:
>> On Fri, 23 Jan 2009, Alexey Starikovskiy wrote:
>>> This is probably related to this piece of code (drivers/acpi/battery.c),
>>> similar code exists in drivers/acpi/sbs.c, but it is not relevant to your case:
>>> 	case POWER_SUPPLY_PROP_STATUS:
>>> 		if (battery->state & 0x01)
>>> 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>>> 		else if (battery->state & 0x02)
>>> 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
>>> 		else if (battery->state == 0)
>>> 			val->intval = POWER_SUPPLY_STATUS_FULL;
>>> 		else
>>> 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
>>> 		break;
>>>
>>> Actually, state==0 means POWER_SUPPLY_STATUS_NOT_CHARGING, so if that is preferred it could be changed.
>> It should be fixed, yes.  Batteries being idle without being full are really
>> common in laptops with battery-life-saving functions (charge/stop-charge
>> threshold control).
> 
> I suspected this might be the case. Is there a way we can get true
> battery state out of acpi for the battery? I always thought there could
> be two booleans: charging and discharging.
> 
> I guess fully charged isn't just !charging and !discharging.
> 
> Richard.
How about such definition: Fully charged == current_capacity >= 90 % of last_capacity && !charging and !discharging? 

Alex.
