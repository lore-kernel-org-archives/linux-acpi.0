From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [patch] ACPI battery driver emits POWER_SUPPLY_STATUS_FULL when
 power lead plugged in
Date: Sun, 25 Jan 2009 13:55:57 +0300
Message-ID: <497C453D.4060204@suse.de>
References: <1232729843.3504.6.camel@hughsie-work.lan>	 <497A13C0.5020604@suse.de> <20090123220243.GB26701@khazad-dum.debian.net>	 <1232753981.3504.10.camel@hughsie-work.lan> <497A5D49.6070706@suse.de>	 <20090124124158.GC5325@khazad-dum.debian.net>  <497B43D3.80703@suse.de> <1232879297.3518.26.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:38499 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752050AbZAYKzn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Jan 2009 05:55:43 -0500
In-Reply-To: <1232879297.3518.26.camel@hughsie-work.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>

Looks good to me.

Richard Hughes wrote:
> On Sat, 2009-01-24 at 19:37 +0300, Alexey Starikovskiy wrote:
>>> I don't understand, why this guesswork over fully charged?  If you cannot
>>> detect fully charged, then *don't*.
>>>
>>> But if you must sinthesize it, and you can get an up-to-date "last full
>>> capacity" from the battery when comparing, I suggest:
>>>
>>> full = (current capacity == last full capacity) && !charging &&
>>>        !discharging
>> certainly, 90% is wrong, but 100% makes a day...
> 
> I think we need some sort of logic like this.
>  
>>> That would *still* be wrong in a few corner cases, but at least they're rare
>>> corner cases that happens only when the pack recalibrates its fuel gauge.
>> full in this case is not exact term. As any other term beside current_now and voltage_now.
>> Capacity of the battery is estimated, so any number that was depending on it, is estimated too.
> 
> Right, never underestimate the brokenness of some people's batteries out
> there. Coupled with broken BIOS's, some of the fix-up code in HAL is
> 'interesting'. I think all the fix-up code in HAL belongs in in the
> kernel.
> 
>>> If there isn't a reliable way to detect the "full" state, just drop the
>>> fully charged detection altogether.
>> People are used to see "full" state of the battery. I think we could tolerate not-full-enough 
>> for sub-second interval instead of dropping full state altogether.
> 
> We shouldn't drop the full state, we should just add some metric like
> above. What about something like the attached (untested) patch? Would
> something this be accepted?
> 
> Richard.
> 
> 

