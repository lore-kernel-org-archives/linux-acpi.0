From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] ACPI: Add Toshiba Satellite C650D to DMI
 blacklist for corrupting DSDT
Date: Wed, 11 Aug 2010 12:50:41 -0700
Message-ID: <20100811195041.GE23566@kroah.com>
References: <1281112818-19388-1-git-send-email-anisse@astier.eu>
 <20100806190618.78d061bd@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:49344 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758502Ab0HKT7i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Aug 2010 15:59:38 -0400
Content-Disposition: inline
In-Reply-To: <20100806190618.78d061bd@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-acpi@vger.kernel.org, stable@kernel.org, Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>

On Fri, Aug 06, 2010 at 07:06:18PM +0200, Anisse Astier wrote:
> On Fri,  6 Aug 2010 18:40:18 +0200, Anisse Astier <anisse@astier.eu>
> wrote :
> 
> > This machine has a BIOS that corrupts the DSDT, and adding
> > acpi=copy_dsdt on cmdline fixes it. This feature and the corresponding
> > blacklist was added in commit aa2110cb1a7510f9b834adfb39b05d4843a35d35
> > 
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Lin Ming <ming.m.lin@intel.com>
> > ---
> >  drivers/acpi/bus.c |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index c1d23cd..fe7d7b9 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -99,6 +99,14 @@ static struct dmi_system_id dsdt_dmi_table[] __initdata = {
> >  		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L505D"),
> >  		},
> >  	},
> > +	{
> > +	 .callback = set_copy_dsdt,
> > +	 .ident = "TOSHIBA Satellite C650D",
> > +	 .matches = {
> > +		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> > +		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite C650D"),
> > +		},
> > +	},
> >  	{}
> >  };
> >  #else
> 
> Other users experiencing problems as reference:
> https://bugs.launchpad.net/ubuntu/+bug/612341
> 
> Also, I'm cc-ing stable as it might interest Greg for 35.1 (not earlier
> versions since the feature was added by Lin Ming in .35).

What is the git commit id of this patch in Linus's tree?

thanks,

greg k-h
