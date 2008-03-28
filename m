From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Force acpi_new_pts_ordering for ASUS A6VC laptop
Date: Fri, 28 Mar 2008 02:27:05 -0400
Message-ID: <200803280227.05992.lenb@kernel.org>
References: <1206434857.23794.8.camel@sli10-desk.sh.intel.com> <9985.194.201.210.214.1206437077.squirrel@phoenix.slamd64.com> <1206495661.14062.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51508 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753326AbYC1G14 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Mar 2008 02:27:56 -0400
In-Reply-To: <1206495661.14062.3.camel@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tuesday 25 March 2008, Shaohua Li wrote:
> 
> On Tue, 2008-03-25 at 09:24 +0000, Carlos Corbacho wrote:
> > > +static int __init asus_suspend_order(const struct dmi_system_id *d)
> > > +{
> > > +	printk(KERN_WARNING PREFIX "%s detected, "
> > > +		"acpi_new_pts_ordering is force enabled\n", d->ident);
> > > +	new_pts_ordering = true;
> > > +	return 0;
> > 
> > Given all you're doing here is just changing the ordering,
> > 'asus_suspend_order' doesn't strike me as the right name for this function
> > since:
> > 
> > 1) This clearly isn't the case for all Asus boards.
> > 
> > 2) Perhaps something like 'new_suspend_order' would be a better name for
> > this function (e.g. if others want to use DMI to do this for non-Asus
> > boards).
> Makes sense. I changed it.

There doesn't appear to be anyting particularly "new" about the ACPI implementation on this laptop

[000h 000  4]                    Signature : "FACP"    /* Fixed ACPI Description Table */
[004h 004  4]                 Table Length : 00000084
[008h 008  1]                     Revision : 02

FADT revision 2 is from _before_ ACPI 2.0.

(However, MCFG, which is present, is reserved starting at ACPI 3.0)

-Len


> On Asus A6VC laptop, PCI config space read of slot 01:01.* after ACPI
> _PTS is exectued always returns 0xFFFFFFFF.  Force _PTS is executed
> after suspending devices
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
> index d2f71a5..4dded01 100644
> --- a/drivers/acpi/sleep/main.c
> +++ b/drivers/acpi/sleep/main.c
> @@ -272,12 +272,31 @@ static int __init init_ints_after_s1(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> +/*
> + * Laptop needs _PTS is executed after suspending devices. 
> + * Asus A6VC - PCI config read of slot 01:01.* after _PTS returns 0xFFFFFFFF.
> + */
> +static int __init new_suspend_order(const struct dmi_system_id *d)
> +{
> +	printk(KERN_WARNING PREFIX "%s detected, "
> +		"acpi_new_pts_ordering is force enabled\n", d->ident);
> +	new_pts_ordering = true;
> +	return 0;
> +}
> +
>  static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
>  	{
>  	 .callback = init_ints_after_s1,
>  	 .ident = "Toshiba Satellite 4030cdt",
>  	 .matches = {DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),},
>  	 },
> +	{
> +	 .callback = new_suspend_order,
> +	 .ident = "Asus A6VC",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "A6VC"),},
> +	 },
>  	{},
>  };
>  #endif /* CONFIG_SUSPEND */
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


