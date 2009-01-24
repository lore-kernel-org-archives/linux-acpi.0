From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: ACPI battery driver emits POWER_SUPPLY_STATUS_FULL when power
 lead plugged in
Date: Sat, 24 Jan 2009 19:37:39 +0300
Message-ID: <497B43D3.80703@suse.de>
References: <1232729843.3504.6.camel@hughsie-work.lan> <497A13C0.5020604@suse.de> <20090123220243.GB26701@khazad-dum.debian.net> <1232753981.3504.10.camel@hughsie-work.lan> <497A5D49.6070706@suse.de> <20090124124158.GC5325@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:43290 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755548AbZAXQh0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Jan 2009 11:37:26 -0500
In-Reply-To: <20090124124158.GC5325@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>

Henrique de Moraes Holschuh wrote:
> On Sat, 24 Jan 2009, Alexey Starikovskiy wrote:
>> How about such definition: Fully charged == current_capacity >= 90 % of 
>> last_capacity && !charging and !discharging? 
> 
> Not good.  It is usual to tell the EC to stop charging at 95% or 98%.
No. You don't understand the idea. EC does not stop charging at 95%, it will treat 
battery with 95% of charge as fully charged, it will not *start* charging until charge of the 
battery drops below this threshold. This is needed to save limited number of battery recharges until it dies.
So, in other words, if EC does not charge battery, it thinks battery is *full* within some threshold.
Now we talk about sub-second interval, then EC makes a decision to charge or not the battery, 
and what to report in this sub-second interval. I am trying to apply same logic as EC does --
if it is above some threshold (90, 95, 98 %%) of last_capacity, report it full. 
> 
> I don't understand, why this guesswork over fully charged?  If you cannot
> detect fully charged, then *don't*.
> 
> But if you must sinthesize it, and you can get an up-to-date "last full
> capacity" from the battery when comparing, I suggest:
> 
> full = (current capacity == last full capacity) && !charging &&
>        !discharging
certainly, 90% is wrong, but 100% makes a day...
> 
> That would *still* be wrong in a few corner cases, but at least they're rare
> corner cases that happens only when the pack recalibrates its fuel gauge.
full in this case is not exact term. As any other term beside current_now and voltage_now.
Capacity of the battery is estimated, so any number that was depending on it, is estimated too.
> If there isn't a reliable way to detect the "full" state, just drop the
> fully charged detection altogether.
People are used to see "full" state of the battery. I think we could tolerate not-full-enough 
for sub-second interval instead of dropping full state altogether.

Regards,
Alex.


