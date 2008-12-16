From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] ACPI: battery: add power_{now, avg} properties to power_class
Date: Tue, 16 Dec 2008 16:19:44 +0100
Message-ID: <200812161619.45073.rjw@sisk.pl>
References: <20081215213855.8414.9349.stgit@thinkpad> <49476C89.3050707@suse.de> <20081216141845.GB13379@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55209 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbYLPPTv (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 10:19:51 -0500
In-Reply-To: <20081216141845.GB13379@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Tuesday, 16 of December 2008, Henrique de Moraes Holschuh wrote:
> On Tue, 16 Dec 2008, Alexey Starikovskiy wrote:
> > Henrique de Moraes Holschuh wrote:
> >> On Tue, 16 Dec 2008, Alexey Starikovskiy wrote:
> >>> @@ -224,10 +224,12 @@ static int acpi_sbs_battery_get_property(struct power_supply *psy,
> >>>  				acpi_battery_vscale(battery) * 1000;
> >>>  		break;
> >>>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
> >>> +	case POWER_SUPPLY_PROP_POWER_NOW:
> >>>  		val->intval = abs(battery->current_now) *
> >>>  				acpi_battery_ipscale(battery) * 1000;
> >>>  		break;
> >>>  	case POWER_SUPPLY_PROP_CURRENT_AVG:
> >>> +	case POWER_SUPPLY_PROP_POWER_AVG:
> >>>  		val->intval = abs(battery->current_avg) *
> >>>  				acpi_battery_ipscale(battery) * 1000;
> >>>  		break;
> >>
> >> Excuse me if I am talking nonsense (I have looked over just the patch,
> >> not the entire file), but how can that be correct?  It is either power
> >> or current, it cannot be both, so the CURRENT case should be dropped.
> > file name under /sys depends on property, so if we want some variable to
> > be named as current_now, it should be returned by case POWER_SUPPLY_PROP_CURRENT_NOW.
> > Then we register with power_supply, we say which set of properties (either charge or energy) we support,
> > so for one battery we will receive request for either CURRENT_AVG or POWER_AVG, not both.
> >> And if it is power, why have fields named current_now... or is
> >> ipscale() a voltage, and not a scaling factor?
> > ipscale stands for I/P scaling, as opposed to V scaling -- it depends on units returned by actual battery.
> > All energy/charge fields are reused, so battery->current_now contains either power_now or current_now from battery.
> 
> I see.  But that's a loaded-spring trap waiting for the unaware.  Can it be
> called something else that is neutral re. power or current, pretty please?
> even "current_or_power_now" would be less confusing...

As I said in my recent reply to Alex, I'd prefer it if there were separate
fields called 'power_now' and 'power_avg' under 'battery'.

Then, there won't be any confustion and people reading the source will clearly
understand what is what.

Thanks,
Rafael
