From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Force acpi_new_pts_ordering for ASUS A6VC laptop
Date: Fri, 28 Mar 2008 15:38:11 +0100
Message-ID: <200803281538.11807.rjw@sisk.pl>
References: <1206434857.23794.8.camel@sli10-desk.sh.intel.com> <1206495661.14062.3.camel@sli10-desk.sh.intel.com> <200803280227.05992.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52074 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757472AbYC1Oif (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Mar 2008 10:38:35 -0400
In-Reply-To: <200803280227.05992.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Shaohua Li <shaohua.li@intel.com>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux acpi <linux-acpi@vger.kernel.org>

On Friday, 28 of March 2008, Len Brown wrote:
> On Tuesday 25 March 2008, Shaohua Li wrote:
> > 
> > On Tue, 2008-03-25 at 09:24 +0000, Carlos Corbacho wrote:
> > > > +static int __init asus_suspend_order(const struct dmi_system_id *d)
> > > > +{
> > > > +	printk(KERN_WARNING PREFIX "%s detected, "
> > > > +		"acpi_new_pts_ordering is force enabled\n", d->ident);
> > > > +	new_pts_ordering = true;
> > > > +	return 0;
> > > 
> > > Given all you're doing here is just changing the ordering,
> > > 'asus_suspend_order' doesn't strike me as the right name for this function
> > > since:
> > > 
> > > 1) This clearly isn't the case for all Asus boards.
> > > 
> > > 2) Perhaps something like 'new_suspend_order' would be a better name for
> > > this function (e.g. if others want to use DMI to do this for non-Asus
> > > boards).
> > Makes sense. I changed it.
> 
> There doesn't appear to be anyting particularly "new" about the ACPI implementation on this laptop
> 
> [000h 000  4]                    Signature : "FACP"    /* Fixed ACPI Description Table */
> [004h 004  4]                 Table Length : 00000084
> [008h 008  1]                     Revision : 02
> 
> FADT revision 2 is from _before_ ACPI 2.0.

So in theory it should work with the suspend ordering we use by default right
now. :-)

Thanks,
Rafael
