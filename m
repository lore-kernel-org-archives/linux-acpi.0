From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] 2.6.24-rc: fix ACPI battery technology reporting
Date: Thu, 6 Dec 2007 22:31:01 -0500
Message-ID: <200712062231.02380.lenb@kernel.org>
References: <200711102002.56951.arvidjaar@mail.ru> <4737847A.5050702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38749 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099AbXLGDb0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Dec 2007 22:31:26 -0500
In-Reply-To: <4737847A.5050702@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org

applied.

though kmail found it to be impossible to save
an un-corrupted plain text version of andrezy's message.

should the other string compares be updated like this one?

-len

On Sunday 11 November 2007 17:38, Alexey Starikovskiy wrote:
> Andrey Borzenkov wrote:
> > Subject: [PATCH] 2.6.24-rc: fix ACPI battery technology reporting
> > From: Andrey Borzenkov <arvidjaar@mail.ru>
> >
> > At least some systems report technology information with trailing spaces:
> >
> > {pts/1}% cat -E /var/tmp/bat/2.6.23 | grep type
> > battery type:            Li-ION  $
> >
> > Use strncasecmp to compare model string to skip trailing part
> >
> > Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
> >
> >   
> Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> > ---
> >
> >  drivers/acpi/battery.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index c2ce0ad..1905b88 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -125,7 +125,7 @@ static int acpi_battery_technology(struct acpi_battery 
> > *battery)
> >  		return POWER_SUPPLY_TECHNOLOGY_NiMH;
> >  	if (!strcasecmp("LION", battery->type))
> >  		return POWER_SUPPLY_TECHNOLOGY_LION;
> > -	if (!strcasecmp("LI-ION", battery->type))
> > +	if (!strncasecmp("LI-ION", battery->type, 6))
> >  		return POWER_SUPPLY_TECHNOLOGY_LION;
> >  	if (!strcasecmp("LiP", battery->type))
> >  		return POWER_SUPPLY_TECHNOLOGY_LIPO;
> >   
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
