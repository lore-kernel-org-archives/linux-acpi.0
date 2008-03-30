From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Force acpi_new_pts_ordering for ASUS A6VC laptop
Date: Sun, 30 Mar 2008 14:01:55 +0200
Message-ID: <200803301401.56170.rjw@sisk.pl>
References: <1206434857.23794.8.camel@sli10-desk.sh.intel.com> <200803262229.38167.rjw@sisk.pl> <20080330112000.GB6247@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34281 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbYC3MBx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Mar 2008 08:01:53 -0400
In-Reply-To: <20080330112000.GB6247@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Shaohua Li <shaohua.li@intel.com>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Sunday, 30 of March 2008, Pavel Machek wrote:
> On Wed 2008-03-26 22:29:37, Rafael J. Wysocki wrote:
> > On Wednesday, 26 of March 2008, Shaohua Li wrote:
> > > 
> > > On Tue, 2008-03-25 at 09:24 +0000, Carlos Corbacho wrote:
> > > > > +static int __init asus_suspend_order(const struct dmi_system_id *d)
> > > > > +{
> > > > > +	printk(KERN_WARNING PREFIX "%s detected, "
> > > > > +		"acpi_new_pts_ordering is force enabled\n", d->ident);
> > > > > +	new_pts_ordering = true;
> > > > > +	return 0;
> > > > 
> > > > Given all you're doing here is just changing the ordering,
> > > > 'asus_suspend_order' doesn't strike me as the right name for this function
> > > > since:
> > > > 
> > > > 1) This clearly isn't the case for all Asus boards.
> > > > 
> > > > 2) Perhaps something like 'new_suspend_order' would be a better name for
> > > > this function (e.g. if others want to use DMI to do this for non-Asus
> > > > boards).
> > > Makes sense. I changed it.
> > > 
> > > On Asus A6VC laptop, PCI config space read of slot 01:01.* after ACPI
> > > _PTS is exectued always returns 0xFFFFFFFF.  Force _PTS is executed
> > > after suspending devices
> > > 
> > > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > 
> > I don't think we can do anything smarter about it.
> > 
> > Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> This will clash with your patch to remove the option...

Well, it won't be needed at all if my patch is applied. :-)

The $subject patch was posted earlier than mine and the second system broken
by the ordering change (the MacBook) was reported in the meantime.  That's
why I decided to post that patch (please also see
http://bugzilla.kernel.org/show_bug.cgi?id=10340).

Thanks,
Rafael


> 
> > > index d2f71a5..4dded01 100644
> > > --- a/drivers/acpi/sleep/main.c
> > > +++ b/drivers/acpi/sleep/main.c
> > > @@ -272,12 +272,31 @@ static int __init init_ints_after_s1(const struct dmi_system_id *d)
> > >  	return 0;
> > >  }
> > >  
> > > +/*
> > > + * Laptop needs _PTS is executed after suspending devices. 
> > > + * Asus A6VC - PCI config read of slot 01:01.* after _PTS returns 0xFFFFFFFF.
> > > + */
> > > +static int __init new_suspend_order(const struct dmi_system_id *d)
> > > +{
> > > +	printk(KERN_WARNING PREFIX "%s detected, "
> > > +		"acpi_new_pts_ordering is force enabled\n", d->ident);
> > > +	new_pts_ordering = true;
> > > +	return 0;
> > > +}
> > > +
> > >  static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
> > >  	{
> > >  	 .callback = init_ints_after_s1,
> > >  	 .ident = "Toshiba Satellite 4030cdt",
> > >  	 .matches = {DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),},
> > >  	 },
> > > +	{
> > > +	 .callback = new_suspend_order,
> > > +	 .ident = "Asus A6VC",
> > > +	 .matches = {
> > > +		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
> > > +		DMI_MATCH(DMI_PRODUCT_NAME, "A6VC"),},
> > > +	 },
> > >  	{},
> > >  };
> > >  #endif /* CONFIG_SUSPEND */
> > > 
> > > 
> > > 
> > > 
> > 
> > 
> > 
> 



-- 
"Premature optimization is the root of all evil." - Donald Knuth
