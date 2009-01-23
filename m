From: Richard Hughes <hughsient@gmail.com>
Subject: Re: ACPI battery driver emits POWER_SUPPLY_STATUS_FULL when power
 lead plugged in
Date: Fri, 23 Jan 2009 23:39:41 +0000
Message-ID: <1232753981.3504.10.camel@hughsie-work.lan>
References: <1232729843.3504.6.camel@hughsie-work.lan>
	 <497A13C0.5020604@suse.de>  <20090123220243.GB26701@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:37901 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757641AbZAWXkX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jan 2009 18:40:23 -0500
Received: by qw-out-2122.google.com with SMTP id 3so2327374qwe.37
        for <linux-acpi@vger.kernel.org>; Fri, 23 Jan 2009 15:40:21 -0800 (PST)
In-Reply-To: <20090123220243.GB26701@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>

On Fri, 2009-01-23 at 20:02 -0200, Henrique de Moraes Holschuh wrote:
> On Fri, 23 Jan 2009, Alexey Starikovskiy wrote:
> > This is probably related to this piece of code (drivers/acpi/battery.c),
> > similar code exists in drivers/acpi/sbs.c, but it is not relevant to your case:
> > 	case POWER_SUPPLY_PROP_STATUS:
> > 		if (battery->state & 0x01)
> > 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> > 		else if (battery->state & 0x02)
> > 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> > 		else if (battery->state == 0)
> > 			val->intval = POWER_SUPPLY_STATUS_FULL;
> > 		else
> > 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> > 		break;
> >
> > Actually, state==0 means POWER_SUPPLY_STATUS_NOT_CHARGING, so if that is preferred it could be changed.
> 
> It should be fixed, yes.  Batteries being idle without being full are really
> common in laptops with battery-life-saving functions (charge/stop-charge
> threshold control).

I suspected this might be the case. Is there a way we can get true
battery state out of acpi for the battery? I always thought there could
be two booleans: charging and discharging.

I guess fully charged isn't just !charging and !discharging.

Richard.


