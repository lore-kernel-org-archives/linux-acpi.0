From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI battery driver emits POWER_SUPPLY_STATUS_FULL when power
	lead plugged in
Date: Sat, 24 Jan 2009 10:41:58 -0200
Message-ID: <20090124124158.GC5325@khazad-dum.debian.net>
References: <1232729843.3504.6.camel@hughsie-work.lan> <497A13C0.5020604@suse.de> <20090123220243.GB26701@khazad-dum.debian.net> <1232753981.3504.10.camel@hughsie-work.lan> <497A5D49.6070706@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40320 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751475AbZAXMmC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jan 2009 07:42:02 -0500
Content-Disposition: inline
In-Reply-To: <497A5D49.6070706@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>

On Sat, 24 Jan 2009, Alexey Starikovskiy wrote:
> Richard Hughes wrote:
>> On Fri, 2009-01-23 at 20:02 -0200, Henrique de Moraes Holschuh wrote:
>>> On Fri, 23 Jan 2009, Alexey Starikovskiy wrote:
>>>> This is probably related to this piece of code (drivers/acpi/battery.c),
>>>> similar code exists in drivers/acpi/sbs.c, but it is not relevant to your case:
>>>> 	case POWER_SUPPLY_PROP_STATUS:
>>>> 		if (battery->state & 0x01)
>>>> 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>>>> 		else if (battery->state & 0x02)
>>>> 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
>>>> 		else if (battery->state == 0)
>>>> 			val->intval = POWER_SUPPLY_STATUS_FULL;
>>>> 		else
>>>> 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
>>>> 		break;
>>>>
>>>> Actually, state==0 means POWER_SUPPLY_STATUS_NOT_CHARGING, so if that is preferred it could be changed.
>>> It should be fixed, yes.  Batteries being idle without being full are really
>>> common in laptops with battery-life-saving functions (charge/stop-charge
>>> threshold control).
>>
>> I suspected this might be the case. Is there a way we can get true
>> battery state out of acpi for the battery? I always thought there could
>> be two booleans: charging and discharging.
>>
>> I guess fully charged isn't just !charging and !discharging.
>>
>> Richard.
> How about such definition: Fully charged == current_capacity >= 90 % of 
> last_capacity && !charging and !discharging? 

Not good.  It is usual to tell the EC to stop charging at 95% or 98%.

I don't understand, why this guesswork over fully charged?  If you cannot
detect fully charged, then *don't*.

But if you must sinthesize it, and you can get an up-to-date "last full
capacity" from the battery when comparing, I suggest:

full = (current capacity == last full capacity) && !charging &&
       !discharging

That would *still* be wrong in a few corner cases, but at least they're rare
corner cases that happens only when the pack recalibrates its fuel gauge.

If there isn't a reliable way to detect the "full" state, just drop the
fully charged detection altogether.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
