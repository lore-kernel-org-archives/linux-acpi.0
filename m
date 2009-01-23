From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: ACPI battery driver emits POWER_SUPPLY_STATUS_FULL when power
 lead plugged in
Date: Fri, 23 Jan 2009 22:00:16 +0300
Message-ID: <497A13C0.5020604@suse.de>
References: <1232729843.3504.6.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:58307 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752814AbZAWTAH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jan 2009 14:00:07 -0500
In-Reply-To: <1232729843.3504.6.camel@hughsie-work.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>

Hi Richard,

This is probably related to this piece of code (drivers/acpi/battery.c),
similar code exists in drivers/acpi/sbs.c, but it is not relevant to your case:
	case POWER_SUPPLY_PROP_STATUS:
		if (battery->state & 0x01)
			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
		else if (battery->state & 0x02)
			val->intval = POWER_SUPPLY_STATUS_CHARGING;
		else if (battery->state == 0)
			val->intval = POWER_SUPPLY_STATUS_FULL;
		else
			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
		break;

Actually, state==0 means POWER_SUPPLY_STATUS_NOT_CHARGING, so if that is preferred it could be changed.

Regards,
Alex.


Richard Hughes wrote:
> When I insert the power lead or attach my T61 to the powered dock, the
> battery power supply status goes like this:
> 
> 0.00s Discharging
> {dock}
> 0.10s Fully charged
> 1.00s Charging
> 
> This causes userspace (in my case gnome-power-manager) to pop up a
> dialog telling me the battery is full, and the icon flickers to fully
> green, then 10% green and charging.
> 
> This seems to have existed as long as the power supply class was being
> used by the acpi battery, but we've always relied on a userspace fudge.
> 
> This is tested with 2.6.27.9-159.fc10.i686, although I seem to get the
> same thing with git from kernel.org.
> 
> Is this a known issue? Does anybody have any insight into what causes
> this? I'm fully willing to test patches or debug this further myself.
> 
> Thanks,
> 
> Richard.
> 
> 

