From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [patch] ACPI battery driver emits POWER_SUPPLY_STATUS_FULL
	when power lead plugged in
Date: Sun, 25 Jan 2009 11:42:03 -0200
Message-ID: <20090125134203.GA12776@khazad-dum.debian.net>
References: <1232729843.3504.6.camel@hughsie-work.lan> <497A13C0.5020604@suse.de> <20090123220243.GB26701@khazad-dum.debian.net> <1232753981.3504.10.camel@hughsie-work.lan> <497A5D49.6070706@suse.de> <20090124124158.GC5325@khazad-dum.debian.net> <497B43D3.80703@suse.de> <1232879297.3518.26.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39319 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752867AbZAYNmI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Jan 2009 08:42:08 -0500
Content-Disposition: inline
In-Reply-To: <1232879297.3518.26.camel@hughsie-work.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>

On Sun, 25 Jan 2009, Richard Hughes wrote:
> +	/* good batteries update full_charge as the batteries degrade */
> +	if (battery->full_charge_capacity != ACPI_BATTERY_VALUE_UNKNOWN &&
> +	    battery->full_charge_capacity != 0) {
> +		percentage = (100 * battery->capacity_now) / battery->full_charge_capacity;
> +		if (percentage > 90)
> +			return 1;

You guys have to remember that the hardware can know when the cells are
physically full.  That has _nothing_ to do with any level estimation,
battery cells behave differently when they are full, and that's what the
overcharge protection circuitry detects.

So, the above test will still break on any proper battery subsystem with the
high watermark set below 100%, as those systems update full_charge_capacity
*only* when the cells really are full (and not because the EC decided to
stop the charging before they were full).

Thus, it will break if you set the threshold to stop charging (high
watermark) above 90% but below 100% on a T-, X-, R- or W-series ThinkPad,
for example.

The test would still have to be:
	if (battery->full_charge_capacity != ACPI_BATTERY_VALUE_UNKNOWN &&
	    battery->full_charge_capacity != 0 &&
	    battery->capacity_now == battery->full_charge_capacity)
		return 1;

or, if there is crap so bad out there that requires it:
	if (battery->full_charge_capacity != ACPI_BATTERY_VALUE_UNKNOWN &&
	    battery->full_charge_capacity != 0 &&
	    battery->capacity_now == battery->full_charge_capacity) {
		percentage = (100 * battery->capacity_now) / battery->full_charge_capacity;
		if (percentage > 90)
			return 1;

to work well on proper battery firmware set to stop before the battery is
full.

If that can't work well enough with the crap out there, I am out of ideas,
and I'd say we'd have to quirk either the good or the bad systems to
properly implement the FULL state.

As for the sub-second "blinks" the EC does in battery states, if one wants
to avoid that, better report states only after they have been stable for one
or two seconds.  Not that a report of CHARGING->IDLE->FULL is incorrect or a
problem IMHO, but I don't know if that's what you guys are observing.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
