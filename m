From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] ACPI: Don't report current_now if battery reports in
 mWh
Date: Tue, 24 Aug 2010 12:18:22 +0400
Message-ID: <20100824081822.GA7963@oksana.dev.rtsoft.ru>
References: <1282595132-5026-1-git-send-email-mjg@redhat.com>
 <201008232337.19715.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58407 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab0HXIS1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Aug 2010 04:18:27 -0400
Content-Disposition: inline
In-Reply-To: <201008232337.19715.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, lenb@kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Mon, Aug 23, 2010 at 11:37:19PM +0200, Rafael J. Wysocki wrote:
> On Monday, August 23, 2010, Matthew Garrett wrote:
> > ACPI batteries can report in units of either current or energy. Right
> > now we expose the current_now file even if the battery is reporting
> > energy units, resulting in a file that should contain mA instead
> > containing mW. Don't expose this value unless the battery is reporting
> > current.
> > 
> > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > Cc: Arjan van de Ven <arjan@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Looks good to me as well.

Should I merge this into the battery-2.6.git tree, or
ACPI folks are gonna handle this patch?

Thanks,

> > ---
> >  drivers/acpi/battery.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index dc58402..9841720 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -273,7 +273,6 @@ static enum power_supply_property energy_battery_props[] = {
> >  	POWER_SUPPLY_PROP_CYCLE_COUNT,
> >  	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> >  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > -	POWER_SUPPLY_PROP_CURRENT_NOW,
> >  	POWER_SUPPLY_PROP_POWER_NOW,
> >  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> >  	POWER_SUPPLY_PROP_ENERGY_FULL,
> > 

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
