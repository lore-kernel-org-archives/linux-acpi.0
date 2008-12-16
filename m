From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC][PATCH] ACPI: battery: add power_{now, avg} properties to
	power_class
Date: Mon, 15 Dec 2008 23:22:04 -0200
Message-ID: <20081216012204.GF10767@khazad-dum.debian.net>
References: <20081215213855.8414.9349.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34947 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750965AbYLPBWI (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 15 Dec 2008 20:22:08 -0500
Content-Disposition: inline
In-Reply-To: <20081215213855.8414.9349.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Tue, 16 Dec 2008, Alexey Starikovskiy wrote:
> @@ -224,10 +224,12 @@ static int acpi_sbs_battery_get_property(struct power_supply *psy,
>  				acpi_battery_vscale(battery) * 1000;
>  		break;
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +	case POWER_SUPPLY_PROP_POWER_NOW:
>  		val->intval = abs(battery->current_now) *
>  				acpi_battery_ipscale(battery) * 1000;
>  		break;
>  	case POWER_SUPPLY_PROP_CURRENT_AVG:
> +	case POWER_SUPPLY_PROP_POWER_AVG:
>  		val->intval = abs(battery->current_avg) *
>  				acpi_battery_ipscale(battery) * 1000;
>  		break;

Excuse me if I am talking nonsense (I have looked over just the patch,
not the entire file), but how can that be correct?  It is either power
or current, it cannot be both, so the CURRENT case should be dropped.
And if it is power, why have fields named current_now... or is
ipscale() a voltage, and not a scaling factor?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
