From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI battery driver emits POWER_SUPPLY_STATUS_FULL when power
	lead plugged in
Date: Fri, 23 Jan 2009 20:02:43 -0200
Message-ID: <20090123220243.GB26701@khazad-dum.debian.net>
References: <1232729843.3504.6.camel@hughsie-work.lan> <497A13C0.5020604@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44695 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756500AbZAWWQA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Jan 2009 17:16:00 -0500
Content-Disposition: inline
In-Reply-To: <497A13C0.5020604@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>

On Fri, 23 Jan 2009, Alexey Starikovskiy wrote:
> This is probably related to this piece of code (drivers/acpi/battery.c),
> similar code exists in drivers/acpi/sbs.c, but it is not relevant to your case:
> 	case POWER_SUPPLY_PROP_STATUS:
> 		if (battery->state & 0x01)
> 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> 		else if (battery->state & 0x02)
> 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> 		else if (battery->state == 0)
> 			val->intval = POWER_SUPPLY_STATUS_FULL;
> 		else
> 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> 		break;
>
> Actually, state==0 means POWER_SUPPLY_STATUS_NOT_CHARGING, so if that is preferred it could be changed.

It should be fixed, yes.  Batteries being idle without being full are really
common in laptops with battery-life-saving functions (charge/stop-charge
threshold control).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
